#' Prediction intervals via conformal inference and QRSVM
#'
#' To compute quantiles, this function uses Quantile
#' SVM instead of probably's `"int_conformal_quantile"` QRF or classic quantile regression.
#' @param object A fitted [workflows::workflow()] object.
#' @param ... Not currently used.
#' @param train_data,cal_data Data frames with the _predictor and outcome data_.
#' `train_data` should be the same data used to produce `object` and `cal_data` is
#' used to produce predictions (and residuals). If the workflow used a recipe,
#' these should be the data that were inputs to the recipe (and not the product
#' of a recipe).
#' @param level The confidence level for the intervals.
#' @param ... Options to pass to [qrsvm::qrsvm()]
#' @return An object of class `"int_conformal_quantile"` containing the
#' information to create intervals (which includes `object`).
#' The `predict()` method is used to produce the intervals.
#' @details
#' based on the initial probably implementation with slight modification.
#'
#' origin: https://github.com/tidymodels/probably/blob/HEAD/R/conformal_infer_quantile.R
#'
#' for more information, visit:
#' https://probably.tidymodels.org
#'
#' @export
int_conformal_quantile_svm <- function(object, ...) {
  UseMethod("int_conformal_quantile_svm")
}


#' @export
#' @rdname int_conformal_quantile_svm
int_conformal_quantile_svm.workflow <-
  function(object, train_data, cal_data, level = 0.95, ...) {
    check_data_all(train_data, object)
    check_data_all(cal_data, object)

    # ------------------------------------------------------------------------------

    y_name <- names(hardhat::extract_mold(object)$outcomes)

    # maize adjustments for qrsvm
    # edits for y_name and level for both fcns
    quant_fit <- quant_train(train_data, y_name, level, ...)
    quant_pred <- quant_predict(quant_fit, cal_data, y_name)

    # ------------------------------------------------------------------------------

    R_low <- quant_pred$.pred_lower - cal_data[[y_name]]
    R_high <- cal_data[[y_name]] - quant_pred$.pred_upper
    resid <- pmax(R_low, R_high)

    # ------------------------------------------------------------------------------

    res <-
      list(
        resid = sort(resid),
        wflow = object,
        n = nrow(cal_data),
        quant = quant_fit,
        level = level
      )
    class(res) <- c("conformal_reg_quantile_svm", "int_conformal_quantile_svm")
    res
  }

#' @export
print.int_conformal_quantile_svm <- function(x, ...) {
  cat("Split Conformal inference via Quantile Regression SVM\n")

  cat("preprocessor:", .get_pre_type(x$wflow), "\n")
  cat("model:", .get_fit_type(x$wflow), "\n")
  cat("calibration set size:", format(x$n, big.mark = ","), "\n")
  cat("confidence level:", format(x$level, digits = 3), "\n\n")

  cat("Use `predict(object, new_data)` to compute prediction intervals\n")
  invisible(x)
}

#' @export
#' @rdname predict.int_conformal_quantile_svm
predict.int_conformal_quantile_svm <- function(object, new_data, ...) {
  check_data(new_data, object$wflow)
  rlang::check_dots_empty()

  # additional helper
  y_name <- svm_int$wflow$pre$mold$outcomes |> names()

  new_pred <- predict(object$wflow, new_data)
  quant_pred <- quant_predict(object$quant, new_data, y_name)

  alpha <- (1 - object$level)
  q_ind <- ceiling((1 - alpha) * (object$n + 1))
  q_val <- object$resid[q_ind]

  quant_pred$.pred_lower <- quant_pred$.pred_lower - q_val
  quant_pred$.pred_upper <- quant_pred$.pred_upper + q_val
  dplyr::bind_cols(new_pred, quant_pred)
}

# maize adjustments for qrsvm ---
# both quant_train and quant_predict have been edited
# these have been adjusted to handle upper/lower predictions from qrsvm
# super experimental swap of quantile reg RF for quantile reg SVM

quant_train <- function(train_data, y_name, level, ...) {

  rlang::check_installed("qrsvm", reason = "to compute quantiles")

  alpha <- (1 - level)
  lower <- (alpha / 2)
  upper <- 1 - (alpha / 2)


  cl_lo <- rlang::call2(
    "qrsvm",
    .ns = "qrsvm",
    x = quote(as.matrix(train_data |> select(-dplyr::all_of(y_name)))),
    y = quote(train_data[[y_name]]),
    tau = lower,
    ...
  )
  int_lo <- rlang::eval_tidy(cl_lo)

  cl_up <- rlang::call2(
    "qrsvm",
    .ns = "qrsvm",
    x = quote(as.matrix(train_data |> select(-dplyr::all_of(y_name)))),
    y = quote(train_data[[y_name]]),
    tau = upper,
    ...
  )
  int_up <- rlang::eval_tidy(cl_up)

  list(int_lo, int_up)
}

quant_predict <- function(fit, new_data, y_name) {
  rlang::check_installed("qrsvm", reason = "to compute quantiles")

  quant_pred_lo <- predict(fit[[1]], as.matrix(new_data |> dplyr::select(-dplyr::all_of(y_name))))
  quant_pred_up <- predict(fit[[2]], as.matrix(new_data |> dplyr::select(-dplyr::all_of(y_name))))
  quant_pred <- cbind(quant_pred_lo, quant_pred_up)

  quant_pred <- dplyr::as_tibble(quant_pred)
  quant_pred <- stats::setNames(quant_pred, c(".pred_lower", ".pred_upper"))
  quant_pred
}

# helpers ----

# probably:
# grabbing helper from other conformal scripts
# -------------------------------------------------------------------
# https://github.com/tidymodels/probably/blob/main/R/conformal_infer_split.R

check_data_all <- function(.data, wflow) {
  mold <- hardhat::extract_mold(wflow)
  ptypes <- mold$blueprint$ptypes
  ptypes <- dplyr::bind_cols(ptypes$predictors, ptypes$outcomes)
  hardhat::shrink(.data, ptypes)
  invisible(NULL)
}

# https://github.com/tidymodels/probably/blob/main/R/conformal_infer.R

check_data <- function(.data, wflow) {
  hardhat::scream(.data, wflow$blueprint$ptypes$predictors)
  invisible(NULL)
}

# https://github.com/tidymodels/probably/blob/main/R/conformal_infer_cv.R

.get_pre_type <- function(x) {
  cls <- x |>
    workflows::extract_preprocessor() |>
    class()
  cls <- cls[!grepl("butchered", cls)]
  cls[1]
}


.get_fit_type <- function(x) {
  fitted <- x |> workflows::extract_fit_parsnip()
  res <- paste0(class(fitted$spec)[1], " (engine = ", fitted$spec$engine, ")")
  res
}

# qrsvm:
# adding namespace to kernelMult
# ---------------------------------------------------------------
# https://github.com/frankiethull/qrsvm/blob/master/R/predict.qrsvm.R

#' @export
predict.qrsvm <- function(model, newdata) {
  requireNamespace("kernlab", quietly = TRUE)



  if (class(model)=="qrsvm"){
    xold <- model$xtrain

    if (ncol(newdata) != ncol(xold)) {
      cat("Newdata has different number of columns than xtrain please check consistency!",
          fill = TRUE)
    }
    alpha <- model$alpha
    kern <- model$kernel
    b <- model$b0
    prediction <- kernlab::kernelMult(kern, newdata, xold, alpha) + b
  }

  return(prediction)
}
