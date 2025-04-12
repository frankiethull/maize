#' Nystrom kernel feature map approximation (RBF)
#'
#' `step_kfm_nystrom()` creates a *specification* of a recipe step that will
#' convert numeric data into a feature appoximation. nystrom approximates the 'radial'
#' kernel approximation.
#' @param recipe A recipe object. The step will be added to the
#'  sequence of operations for this recipe.
#' @param ... One or more selector functions to choose variables
#'  for this step. See [selections()] for more details.
#' @param role For model terms created by this step, what analysis role should
#'  they be assigned? By default, the new columns created by this step from
#'  the original variables will be used as _predictors_ in a model.
#' @param trained A logical to indicate if the quantities for
#'  preprocessing have been estimated.
#' @param m The number rows from df to sample in fitting. defaults to nrow of data
#' @param r The rank of matrix approximation to use. Must be less than or equal to m, the default.
#' @param columns A character string of the selected variable names. This field
#'   is a placeholder and will be populated once [prep()] is used.
#' @param prefix A character string for the prefix of the resulting new
#'  variables. See notes below.
#' @param keep_original_cols A logical to keep the original variables in the
#'  output. Defaults to `FALSE`.
#' @param sigma A numeric value for the nystrom function parameter.
#' @param res An [mildsvm::kfm_nystrom()] object is stored
#'  here once this preprocessing step has be trained by
#'  [prep()].
#' @param skip A logical. Should the step be skipped when the
#'  recipe is baked by [bake()]? While all operations are baked
#'  when [prep()] is run, some operations may not be able to be
#'  conducted on new data (e.g. processing the outcome variable(s)).
#'  Care should be taken when using `skip = TRUE` as it may affect
#'  the computations for subsequent operations.
#' @param id A character string that is unique to this step to identify it.
#' @family multivariate transformation steps
#' @export
step_kfm_nystrom <-
  function(recipe,
           ...,
           role = "predictor",
           trained = FALSE,
           res = NULL,
           columns = NULL,
           sigma = 0.2,
           m     = NULL,
           r     = NULL,
           sampling = "random",
           prefix = "kFM",
           keep_original_cols = FALSE,
           skip = FALSE,
           id = rand_id("kfm_nystrom")) {
    recipes_pkg_check(required_pkgs.step_kfm_nystrom())

    add_step(
      recipe,
      step_kfm_nystrom_new(
        terms = enquos(...),
        role = role,
        trained = trained,
        m = m,
        r = r,
        sampling = sampling,
        res = res,
        columns = columns,
        sigma = sigma,
        prefix = prefix,
        keep_original_cols = keep_original_cols,
        skip = skip,
        id = id
      )
    )
  }

step_kfm_nystrom_new <-
  function(terms, role, trained, m, r, sampling, res, sigma, columns, prefix,
           keep_original_cols, skip, id) {
    step(
      subclass = "kfm_nystrom",
      terms = terms,
      role = role,
      trained = trained,
      m = m,
      r = r,
      sampling = sampling,
      res = res,
      columns = columns,
      sigma = sigma,
      prefix = prefix,
      keep_original_cols = keep_original_cols,
      skip = skip,
      id = id
    )
  }

#' @export
prep.step_kfm_nystrom <- function(x, training, info = NULL, ...) {
  col_names <- recipes_eval_select(x$terms, training, info)
  check_type(training[, col_names], types = c("double", "integer"))

  if (nrow(training) > 0 && is.null(x$m)) {
    x$m <- nrow(training)
  }

  if (nrow(training) > 0 && is.null(x$r)) {
    x$r <- x$m
  }


  if (nrow(training) > 0 && length(col_names) > 0) {
    cl <-
      rlang::call2(
        "kfm_nystrom",
        .ns = "mildsvm",
        df       = rlang::expr(as.matrix(training[, col_names])),
        m        = x$m,
        r        = x$r,
        sampling = x$sampling,
        sigma    = x$sigma,
        kernel   = "radial"
      )
    kprc <- try(rlang::eval_tidy(cl), silent = TRUE)
    if (inherits(kprc, "try-error")) {
      cli::cli_abort(c(
        x = "Failed with error:",
        i = as.character(kprc)
      ))
    }
  } else {
    kprc <- NULL
  }

  step_kfm_nystrom_new(
    terms = x$terms,
    role = x$role,
    trained = TRUE,
    m = x$m,
    r = x$r,
    sampling = x$sampling,
    sigma    = x$sigma,
    res = kprc,
    columns = col_names,
    prefix = x$prefix,
    keep_original_cols = get_keep_original_cols(x),
    skip = x$skip,
    id = x$id
  )
}

#' @export
bake.step_kfm_nystrom <- function(object, new_data, ...) {
  uses_dim_red(object)
  col_names <- names(object$columns)
  check_new_data(col_names, object, new_data)

  keep_going <- nrow(new_data) > 0 && length(col_names) > 0
  if (!keep_going) {
    return(new_data)
  }

  cl <-
    rlang::call2(
      "build_fm",
      .ns = "mildsvm",
      kfm_fit  = object$res,
      new_data = rlang::expr((new_data[, col_names]))
    )
  comps <- rlang::eval_tidy(cl)
  comps <- comps[, seq_len(object$r), drop = FALSE]
  colnames(comps) <- names0(ncol(comps), object$prefix)
  comps <- as_tibble(comps)
  comps <- check_name(comps, new_data, object)
  new_data <- vec_cbind(new_data, comps)
  new_data <- remove_original_cols(new_data, object, col_names)
  new_data
}

#' @export
print.step_kfm_nystrom <- function(x, width = max(20, options()$width - 40), ...) {
  title <- "Nyström KFM approximation (RBF) with "
  print_step(x$columns, x$terms, x$trained, title, width)
  invisible(x)
}

#' @rdname tidy.recipe
#' @export
tidy.step_kfm_nystrom <- function(x, ...) {
  uses_dim_red(x)
  if (is_trained(x)) {
    res <- tibble(terms = unname(x$columns))
  } else {
    term_names <- sel2char(x$terms)
    res <- tibble(terms = term_names)
  }
  res$id <- x$id
  res
}

#' @export
tunable.step_kfm_nystrom <- function(x, ...) {
  tibble::tibble(
    name = c("m", "r"),
    call_info = list(
      # TODO add dials
      list(pkg = "maize", fun = "m"),
      list(pkg = "maize", fun = "r")
    ),
    source = "recipe",
    component = "step_kfm_nystrom",
    component_id = x$id
  )
}

#' @rdname required_pkgs.recipe
#' @export
required_pkgs.step_kfm_nystrom <- function(x, ...) {
  c("mildsvm")
}
