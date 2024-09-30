#' String Support Vector Machine
#' @description stringdot for support vector machines
#' @param mode regression or classification
#' @param engine kernlab ksvm
#' @param cost A positive number for the cost of predicting a sample within
#'  or on the wrong side of the margin
#' @param margin A positive number for the epsilon in the SVM insensitive
#'  loss function (regression only)
#' @param length The length of the substrings considered
#' @param lambda The decay factor
#' @param type one of: spectrum, boundrange, constant, exponential, string, fullstring
#' @param normalized normalize string kernel values, (default = TRUE)
#' @export

svm_string <-
  function(mode = "unknown", engine = "kernlab",
           cost = NULL, length = NULL, lambda = NULL, type = NULL, normalized = TRUE, margin = NULL) {

    args <- list(
      cost        = enquo(cost),
      length      = enquo(length),
      lambda      = enquo(lambda),
      type        = enquo(type),
      normalized  = enquo(normalized),
      margin      = enquo(margin)
    )

    parsnip::new_model_spec(
      "svm_string",
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

#' @method update svm_string
#' @rdname parsnip_update
#' @export
update.svm_string <-
  function(object,
           parameters = NULL,
           cost = NULL, length = NULL, lambda = NULL, type = NULL, normalized = TRUE, margin = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      cost        = enquo(cost),
      length      = enquo(length),
      lambda      = enquo(lambda),
      type        = enquo(type),
      normalized  = enquo(normalized),
      margin      = enquo(margin)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "svm_string",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.svm_string <- function(x, engine = x$engine, ...) {
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

    # convert length, lambda, type, normalized to a `kpar` argument.
    if (any(arg_names %in% c("length", "lambda", "type", "normalized", "offset"))) {
      kpar <- rlang::expr(list())
      if (any(arg_names == "length")) {
        kpar$length <- arg_vals$length
        arg_vals$length <- NULL
      }
      if (any(arg_names == "lambda")) {
        kpar$lambda <- arg_vals$lambda
        arg_vals$lambda <- NULL
      }
      if (any(arg_names == "type")) {
        kpar$type <- arg_vals$type
        arg_vals$type <- NULL
      }
      if (any(arg_names == "normalized")) {
        kpar$normalized <- arg_vals$normalized
        arg_vals$normalized <- NULL
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
check_args.svm_string <- function(object, call = rlang::caller_env()) {
  invisible(object)
}
