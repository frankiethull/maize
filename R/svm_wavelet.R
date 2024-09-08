#' Wavelet Support Vector Machine
#' @description wavelet kernel for support vector machines
#' @param mode regression or classification
#' @param engine kernlab ksvm
#' @param cost A positive number for the cost of predicting a sample within
#'  or on the wrong side of the margin
#' @param margin A positive number for the epsilon in the SVM insensitive
#'  loss function (regression only)
#' @param a scale adjustment parameter for wavelet kernels (temp name)
#' @param c dist adjustment parameter for wavelet kernels can be NULL (temp name)
#' @param h wavelet function for wavelet kernel, default wavelet if NULL (temp name)
#' @export

svm_wavelet <-
  function(mode = "unknown", engine = "kernlab",
           cost = NULL, margin = NULL, sigma = NULL, a = 1, c = NULL, h = NULL) {

    args <- list(
      cost   = enquo(cost),
      margin = enquo(margin),
      sigma  = enquo(sigma),
      a      = enquo(a),
      c      = enquo(c),
      h      = enquo(h)
    )

    parsnip::new_model_spec(
      "svm_wavelet",
      args = args,
      eng_args = NULL,
      mode = mode,
      user_specified_mode = !missing(mode),
      method = NULL,
      engine = engine,
      user_specified_engine = !missing(engine)
    )
  }

# ------------------------------------------------------------------------------

#' @method update svm_wavelet
#' @rdname parsnip_update
#' @export
update.svm_wavelet <-
  function(object,
           parameters = NULL,
           cost = NULL, margin = NULL, sigma = NULL,
           a = NULL, c = NULL, h = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      cost   = enquo(cost),
      margin  = enquo(margin),
      sigma   = enquo(sigma),
      a       = enquo(a),
      c       = enquo(c),
      h       = enquo(h)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "svm_wavelet",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.svm_wavelet <- function(x, engine = x$engine, ...) {
  x <- parsnip::translate.default(x, engine = engine, ...)

  # slightly cleaner code using
  arg_vals <- x$method$fit$args
  arg_names <- names(arg_vals)

  # add checks to error trap or change things for this method
  if (x$engine == "kernlab") {

    # unless otherwise specified, classification models predict probabilities
    if (x$mode == "classification" && !any(arg_names == "prob.model"))
      arg_vals$prob.model <- TRUE
    if (x$mode == "classification" && any(arg_names == "epsilon"))
      arg_vals$epsilon <- NULL

  }

  x$method$fit$args <- arg_vals

  # worried about people using this to modify the specification
  x
}

# ------------------------------------------------------------------------------

#' @export
check_args.svm_wavelet <- function(object, call = rlang::caller_env()) {
  invisible(object)
}
