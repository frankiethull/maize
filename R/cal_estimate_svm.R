#------------------------------- Methods ---------------------------------------
#' Uses a support vector regression model to calibrate numeric predictions
#' @param .data An ungrouped  `data.frame` object, or `tune_results` object,
#' that contains a prediction column.
#' @param truth The column identifier for the observed outcome data (that is
#' numeric). This should be an unquoted column name.
#' @param estimate Column identifier for the predicted values
#' @param parameters (Optional)  An optional tibble of tuning parameter values
#' that can be used to filter the predicted values before processing. Applies
#' only to `tune_results` objects.
#' @param ... Additional arguments passed to the models or routines used to
#' calculate the new predictions.
#' @param smooth Applies to the svm models. It switches between a polydot`TRUE`,
#' and vanilladot `FALSE`.
#' @seealso
#' \url{https://www.tidymodels.org/learn/models/calibration/},

#' @details
#' This function uses existing modeling functions from other packages to create
#' the calibration:
#'
#' - [kernlab::ksvm()] with a "vanilladot" is used when `smooth` is set to `FALSE`
#' - [kernlab::ksvm()] with a "polydot" is used when `smooth` is set to `TRUE`
#'
#' These methods estimate the relationship in the unmodified predicted values
#' and then remove that trend when [cal_apply()] is invoked.
#' @export
cal_estimate_svm <- function(.data,
                                truth = NULL,
                                estimate = dplyr::matches("^.pred$"),
                                smooth = TRUE,
                                parameters = NULL,
                                ...,
                                .by = NULL) {
  UseMethod("cal_estimate_svm")
}

#' @export
#' @rdname cal_estimate_svm
cal_estimate_svm.data.frame <- function(.data,
                                           truth = NULL,
                                           estimate = dplyr::matches("^.pred$"),
                                           smooth = TRUE,
                                           parameters = NULL,
                                           ...,
                                           .by = NULL) {
  stop_null_parameters(parameters)

  group <- get_group_argument({{ .by }}, .data)
  .data <- dplyr::group_by(.data, dplyr::across({{ group }}))

  cal_svm_impl(
    .data = .data,
    truth = {{ truth }},
    estimate = {{ estimate }},
    smooth = smooth,
    source_class = cal_class_name(.data),
    ...
  )
}

#' @export
#' @rdname cal_estimate_svm
cal_estimate_svm.tune_results <- function(.data,
                                             truth = NULL,
                                             estimate = dplyr::matches("^.pred$"),
                                             smooth = TRUE,
                                             parameters = NULL,
                                             ...) {
  tune_args <- tune_results_args(
    .data = .data,
    truth = {{ truth }},
    estimate = {{ estimate }},
    event_level = NA_character_,
    parameters = parameters,
    ...
  )

  tune_args$predictions |>
    dplyr::group_by(!!tune_args$group) |>
    cal_svm_impl(
      truth = !!tune_args$truth,
      estimate = !!tune_args$estimate,
      smooth = smooth,
      source_class = cal_class_name(.data),
      ...
    )
}

#' @export
#' @rdname cal_estimate_svm
cal_estimate_svm.grouped_df <- function(.data,
                                           truth = NULL,
                                           estimate = NULL,
                                           smooth = TRUE,
                                           parameters = NULL,
                                           ...) {
  abort_if_grouped_df()
}

#' @rdname required_pkgs.cal_object
#' @keywords internal
#' @export
required_pkgs.cal_estimate_svm_poly <- function(x, ...) {
  c("kernlab", "probably")
}

#' @rdname required_pkgs.cal_object
#' @keywords internal
#' @export
required_pkgs.cal_estimate_svm_linear <- function(x, ...) {
  c("kernlab", "probably")
}


#--------------------------- Implementation ------------------------------------
cal_svm_impl <- function(.data,
                            truth = NULL,
                            estimate = dplyr::starts_with(".pred"),
                            type,
                            smooth,
                            source_class = NULL,
                            ...) {
  if (smooth) {
    model <- "svm_poly"
    method <- "svm polynomial kernel"
    additional_class <- "cal_estimate_svm_poly"
  } else {
    model <- "svm_linear"
    method <- "svm vanilla kernel"
    additional_class <- "cal_estimate_svm_linear"
  }

  truth <- rlang::enquo(truth)

  levels <- truth_estimate_map(.data, !!truth, {{ estimate }})

  if (length(levels) == 1) {
    # check outcome type:
    y <- rlang::eval_tidy(levels[[1]], .data)
    if (!is.vector(y) || !is.numeric(y) || is.factor(y)) {
      rlang::abort("Predictions should be a single numeric vector.")
    }

    svm_model <- cal_svm_impl_grp(
      .data = .data,
      truth = !!truth,
      estimate = levels[[1]],
      run_model = model,
      ...
    )

    res <- as_regression_cal_object(
      estimate = svm_model,
      levels = levels,
      truth = !!truth,
      method = method,
      rows = nrow(.data),
      additional_class = additional_class,
      source_class = source_class
    )
  } else {
    rlang::abort("Outcome data should be a single numeric vector.")
  }

  res
}

cal_svm_impl_grp <- function(.data, truth, estimate, run_model, group, ...) {
  .data |>
    dplyr::group_by({{ group }}, .add = TRUE) |>
    split_dplyr_groups() |>
    lapply(
      function(x) {
        estimate <- cal_svm_impl_single(
          .data = x$data,
          truth = {{ truth }},
          estimate = estimate,
          run_model = run_model,
          ... = ...
        )
        list(
          filter = x$filter,
          estimate = estimate
        )
      }
    )
}

cal_svm_impl_single <- function(.data, truth, estimate, run_model, ...) {
  truth <- rlang::ensym(truth)

  fx <- as.formula(paste(rlang::as_name(truth), "~", estimate))

  if (run_model == "svm_poly") {
   # f_model <- rlang::expr(!!truth ~ !!estimate)
    init_model <- kernlab::ksvm(fx, data = .data, kernel = "polydot", ...)
    model <- butcher::butcher(init_model)
  }

  if (run_model == "svm_linear") {
  #  f_model <- rlang::expr(!!truth ~ !!estimate)
    init_model <- kernlab::ksvm(fx, data = .data, kernel = "vanilladot", ...)
    model <- butcher::butcher(init_model)
  }

  model
}


#' @export
print.cal_estimate_svm <- function(x, ...) {
  print_reg_cal(x, upv = FALSE, ...)
}

################################################################################
# ----------------------------- utils ------------------------------------------
#
# these come from probably,
# ported over when building calibration,
# with small adjustments for namespaces and pipes
#
stop_null_parameters <- function(x) {
  if (!is.null(x)) {
    rlang::abort("The `parameters` argument is only valid for `tune_results`.")
  }
}

get_group_argument <- function(group, .data, call = rlang::env_parent()) {
  group <- rlang::enquo(group)

  group_names <- tidyselect::eval_select(
    expr = group,
    data = .data,
    allow_rename = FALSE,
    allow_empty = TRUE,
    allow_predicates = TRUE,
    error_call = call
  )

  n_group_names <- length(group_names)

  useable_config <- n_group_names == 0 &&
    ".config" %in% names(.data) &&
    dplyr::n_distinct(.data[[".config"]]) > 1

  if (useable_config) {
    return(quo(.config))
  }

  if (n_group_names > 1) {
    cli::cli_abort(
      c(
        x = "{.arg .by} cannot select more than one column.",
        i = "The following {n_group_names} columns were selected:",
        i = "{names(group_names)}"
      )
    )
  }

  return(group)
}


truth_estimate_map <- function(.data, truth, estimate, validate = FALSE) {
  truth_str <- tidyselect_cols(.data, {{ truth }})

  if (is.integer(truth_str)) {
    truth_str <- names(truth_str)
  }

  # Get the name(s) of the column(s) that have the predicted values. For binary
  # data, this is a single column name.
  estimate_str <- .data |>
    tidyselect_cols({{ estimate }}) |>
    names()

  if (length(estimate_str) == 0) {
    cli::cli_abort("{.arg estimate} must select at least one column.")
  }

  truth_levels <- levels(.data[[truth_str]])

  # `est_map` maps the levels of the outcome to the corresponding column(s) in
  # the data
  if (length(truth_levels) > 0) {
    if (all(substr(estimate_str, 1, 6) == ".pred_")) {
      est_map <- purrr::map(
        truth_levels,
        ~ {
          match <- paste0(".pred_", .x) == estimate_str
          if (any(match)) {
            rlang::sym(estimate_str[match])
          }
        }
      )
    } else {
      if (length(estimate_str) == 1) {
        est_map <- list(rlang::sym(estimate_str), NULL)
      } else {
        est_map <- purrr::map(seq_along(truth_levels), ~ rlang::sym(estimate_str[[.x]]))
      }
    }
    if (validate) {
      check_level_consistency(truth_levels, est_map)
    }
    res <- set_names(est_map, truth_levels)
  } else {
    # regression case
    res <- list(rlang::sym(estimate_str))
    names(res) <- "predictions"
  }
  purrr::discard(res, is.null)
}

tidyselect_cols <- function(.data, x) {
  tidyselect::eval_select(
    expr = enquo(x),
    data = .data[unique(names(.data))],
    allow_rename = FALSE
  )
}

split_dplyr_groups <- function(.data) {
  if (dplyr::is_grouped_df(.data)) {
    grp_keys <- .data |> dplyr::group_keys()
    grp_keys <- purrr::map(grp_keys, as.character)
    grp_var <- .data |> dplyr::group_vars()
    grp_data <- .data |> tidyr::nest()
    grp_filters <- purrr::map(grp_keys[[1]], ~ expr(!!parse_expr(grp_var) == !!.x))
    grp_n <- purrr::map_int(grp_data$data, nrow)
    res <- vector(mode = "list", length = length(grp_filters))
    for (i in seq_along(res)) {
      res[[i]]$data <- grp_data$data[[i]]
      res[[i]]$filter <- grp_filters[[i]]
      res[[i]]$rows <- grp_n[[i]]
    }
  } else {
    res <- list(list(data = .data))
  }
  res
}

as_regression_cal_object <- function(estimate,
                                     truth,
                                     levels,
                                     method,
                                     rows,
                                     additional_class = NULL,
                                     source_class = NULL) {
  truth <- enquo(truth)

  as_cal_object(
    estimate = estimate,
    truth = !!truth,
    levels = levels,
    method = method,
    rows = rows,
    additional_classes = additional_class,
    source_class = source_class,
    type = "regression"
  )
}

as_cal_object <- function(estimate,
                          truth,
                          levels,
                          method,
                          rows,
                          additional_classes = NULL,
                          source_class = NULL,
                          type = NULL) {
  if (length(levels) == 1) {
    type <- "regression"
    obj_class <- "cal_regression"
  } else if (length(levels) == 2) {
    if (is.null(type)) {
      type <- "binary"
    }
    obj_class <- "cal_binary"
  } else if (length(levels) > 2) {
    if (is.null(type)) {
      type <- "one_vs_all"
    }
    obj_class <- "cal_multi"
  } else {
    rlang::abort("Can't translate 'levels' to a class.")
  }

  str_truth <- rlang::as_name(rlang::enquo(truth))

  structure(
    list(
      type = type,
      method = method,
      truth = str_truth,
      levels = levels,
      rows = rows,
      source_class = source_class,
      estimates = estimate
    ),
    class = c(additional_classes, obj_class, "cal_object")
  )
}


# ------------------------ Estimate name methods -------------------------------

cal_class_name <- function(x) {
  UseMethod("cal_class_name")
}

#' @export
cal_class_name.data.frame <- function(x) {
  "Data Frame"
}

#' @export
cal_class_name.tune_results <- function(x) {
  "Tune Results"
}

#' @export
cal_class_name.tune_results <- function(x) {
  "Tune Results"
}

#' @export
cal_class_name.rset <- function(x) {
  "Resampled data set"
}

################################################################################
# -------------------------- svm cal-apply methods -----------------------------

#' @export
cal_apply_regression <- function(object, .data, pred_class) {
  UseMethod("cal_apply_regression")
}

#cal_apply_regression <- probably:::cal_apply_regression

#' @export
cal_apply_regression.cal_estimate_svm_linear <- function(object, .data, pred_class = NULL, ...) {
    maize:::apply_reg_predict(
      object = object,
      .data = .data
    )
  }

#' @export
cal_apply_regression.cal_estimate_svm_poly <-
  cal_apply_regression.cal_estimate_svm_linear

apply_reg_predict <- function(object, .data) {
  .pred_name <- rlang::expr_deparse(object$levels$predictions)
  .data <- object$estimates |>
    purrr::map(
      ~ {
        if (is.null(.x$filter)) {
          new_data <- .data
        } else {
          new_data <- dplyr::filter(.data, !!.x$filter)
        }
        preds <- kernlab::predict(.x$estimate, newdata = new_data, type = "response")
        new_data[.pred_name] <- preds
        new_data
      }
    ) |>
    purrr::reduce(dplyr::bind_rows)
  .data
}
