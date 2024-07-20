#' Bessel Support Vector Machine
#' @description bessel kernel for support vector machines
#' @param mode regression or classification
#' @param engine kernlab ksvm
#' @param cost A positive number for the cost of predicting a sample within
#'  or on the wrong side of the margin
#' @param margin A positive number for the epsilon in the SVM insensitive
#'  loss function (regression only)
#' @param degree degree parameter for bessel
#' @param order  order parameter for bessel
#' @param bessel_sigma sigma parameter for bessel
#' @export

svm_bessel <-
  function(mode = "unknown", engine = "kernlab",
           cost = NULL, bessel_sigma = NULL, degree = NULL, order = NULL, margin = NULL) {

    args <- list(
      cost          = enquo(cost),
      bessel_sigma  = enquo(bessel_sigma),
      degree        = enquo(degree),
      order         = enquo(order),
      margin        = enquo(margin)
    )

    parsnip::new_model_spec(
      "svm_bessel",
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

#' @method update svm_bessel
#' @rdname parsnip_update
#' @export
update.svm_bessel <-
  function(object,
           parameters = NULL,
           cost = NULL, bessel_sigma = NULL, degree = NULL, order = NULL, margin = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      cost          = enquo(cost),
      bessel_sigma  = enquo(bessel_sigma),
      degree        = enquo(degree),
      order         = enquo(order),
      margin        = enquo(margin)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "svm_bessel",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.svm_bessel <- function(x, engine = x$engine, ...) {
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

    # convert sigma, degree, order to a `kpar` argument.
    if (any(arg_names %in% c("sigma", "degree", "order", "offset"))) {
      kpar <- rlang::expr(list())
      if (any(arg_names == "sigma")) {
        kpar$sigma <- arg_vals$sigma
        arg_vals$sigma <- NULL
      }
      if (any(arg_names == "degree")) {
        kpar$degree <- arg_vals$degree
        arg_vals$degree <- NULL
      }
      if (any(arg_names == "order")) {
        kpar$order <- arg_vals$order
        arg_vals$order <- NULL
      }
      if (any(arg_names == "offset")) {
        kpar$offset <- arg_vals$offset
        arg_vals$offset <- NULL
      }
      arg_vals$kpar <- kpar
    }

  }
  x$method$fit$args <- arg_vals

  # worried about people using this to modify the specification
  x
}

# ------------------------------------------------------------------------------

#' @export
check_args.svm_bessel <- function(object, call = rlang::caller_env()) {
  invisible(object)
}
