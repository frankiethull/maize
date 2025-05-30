# ---------------------- Notes ------------------------------------------
# @@@@@@@@@@@@@ one-svc novelty detection from kernlab @@@@@@@@@@@@@@@@@@@
# based entirely from tidymodels/applicable for isolation anomaly detection
# repurposed for svm novelty detection
# https://github.com/tidymodels/applicable/blob/develop/R/isolation-fit.R
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------------
# ---------------------- Model Constructor ------------------------------------
# -----------------------------------------------------------------------------

new_apd_svm_novel_detection <- function(model, pctls, blueprint) {
  hardhat::new_model(
    model = model,
    pctls = pctls,
    blueprint = blueprint,
    class = "apd_svm_novel_detection"
  )
}

# -----------------------------------------------------------------------------
# ---------------------- Model function implementation ------------------------
# -----------------------------------------------------------------------------

apd_svm_novel_detection_impl <- function(predictors, options) {

    check_kernlab()

  cl <- rlang::call2("ksvm", .ns = "kernlab", x = data.matrix(predictors), type = "one-svc")
  cl <- rlang::call_modify(cl, !!!options)
  model_fit <- rlang::eval_tidy(cl)

  # Get reference distribution
  tr_pred <- predict(model_fit, data.matrix(predictors), type = "decision")

  # Calculate percentile for scores
  pctls <-
    tibble::tibble(score = applicable:::get_ref_percentile(tr_pred)) |>
    dplyr::mutate(percentile = seq(0, 100, length = 101))

  res <- list(
    model = model_fit,
    pctls = pctls
  )
  res
}

# -----------------------------------------------------------------------------
# ------------------------ Model function bridge ------------------------------
# -----------------------------------------------------------------------------

apd_svm_novel_detection_bridge <- function(processed, ...) {
  predictors <- processed$predictors
  options <- list(...)

  fit <- apd_svm_novel_detection_impl(predictors, options)

  new_apd_svm_novel_detection(
    model = fit$model,
    pctls = fit$pctls,
    blueprint = processed$blueprint
  )
}

# -----------------------------------------------------------------------------
# ----------------------- Model function interface ----------------------------
# -----------------------------------------------------------------------------

#' Fit an SVM novelty detection model to estimate an applicability domain.
#'
#' `apd_svm_novel_detection()` fits an 'one-svc' novelty detection model.
#'
#' @param x Depending on the context:
#'
#'   * A __data frame__ of predictors.
#'   * A __matrix__ of predictors.
#'   * A __recipe__ specifying a set of preprocessing steps
#'     created from [recipes::recipe()].
#'
#' @param data When a __recipe__ or __formula__ is used, `data` is specified as:
#'
#'   * A __data frame__ containing the predictors.
#'
#' @param formula A formula specifying the predictor terms on the right-hand
#' side. No outcome should be specified.
#'
#' @param ... Options to pass to [kernlab::ksvm()]. Options should
#' not include `data`.
#'
#'
#' @return
#'
#' A `apd_svm_novel_detection` object.
#'
#' @export
apd_svm_novel_detection <- function(x, ...) {
  UseMethod("apd_svm_novel_detection")
}

# Default method

#' @export
#' @rdname apd_svm_novel_detection
apd_svm_novel_detection.default <- function(x, ...) {
  cls <- class(x)[1]
  message <-
    "`x` is not of a recognized type.
     Only data.frame, matrix, recipe, and formula objects are allowed.
     A {cls} was specified."
  message <- glue::glue(message)
  rlang::abort(message = message)
}

# Data frame method

#' @export
#' @rdname apd_svm_novel_detection
apd_svm_novel_detection.data.frame <- function(x, ...) {
  processed <- hardhat::mold(x, NA_real_)
  apd_svm_novel_detection_bridge(processed, ...)
}

# Matrix method

#' @export
#' @rdname apd_svm_novel_detection
apd_svm_novel_detection.matrix <- function(x, ...) {
  processed <- hardhat::mold(x, NA_real_)
  apd_svm_novel_detection_bridge(processed, ...)
}

# Formula method

#' @export
#' @rdname apd_svm_novel_detection
apd_svm_novel_detection.formula <- function(formula, data, ...) {
  processed <- hardhat::mold(formula, data)
  apd_svm_novel_detection_bridge(processed, ...)
}

# Recipe method

#' @export
#' @rdname apd_svm_novel_detection
apd_svm_novel_detection.recipe <- function(x, data, ...) {
  processed <- hardhat::mold(x, data)
  apd_svm_novel_detection_bridge(processed, ...)
}

#' @export
print.apd_svm_novel_detection <- function(x, ...) {
  check_kernlab()
  cat("Applicability domain via SVMs\n\n")
  print(x$model)
  invisible(x)
}

check_kernlab <- function() {
  if (!rlang::is_installed("kernlab")) {
    rlang::abort("The 'kernlab' package is required for apd_svm_novel_detection().")
  }
  loadNamespace("kernlab")
  invisible(NULL)
}
