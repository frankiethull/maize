#' T-Student Support Vector Machine
#' @description t-student kernel for support vector machines
#' @param mode regression or classification
#' @param engine kernlab ksvm
#' @param cost A positive number for the cost of predicting a sample within
#'  or on the wrong side of the margin
#' @param margin A positive number for the epsilon in the SVM insensitive
#'  loss function (regression only)
#' @param degree a degree parameter for tstudent kernels
#' @export

svm_tstudent <-
  function(mode = "unknown", engine = "kernlab",
           cost = NULL, margin = NULL, degree = NULL) {

    args <- list(
      cost   = enquo(cost),
      margin = enquo(margin),
      degree  = enquo(degree)
    )

    parsnip::new_model_spec(
      "svm_tstudent",
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

#' @method update svm_tstudent
#' @rdname parsnip_update
#' @export
update.svm_tstudent <-
  function(object,
           parameters = NULL,
           cost = NULL, margin = NULL, degree = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      cost   = enquo(cost),
      margin  = enquo(margin),
      degree   = enquo(degree)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "svm_tstudent",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.svm_tstudent <- function(x, engine = x$engine, ...) {
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
check_args.svm_tstudent <- function(object, call = rlang::caller_env()) {
  invisible(object)
}
