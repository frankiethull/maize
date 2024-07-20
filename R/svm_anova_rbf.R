#' ANOVA RBF Support Vector Machine
#' @description anova rbf for support vector machines
#' @param mode regression or classification
#' @param engine kernlab ksvm
#' @param cost A positive number for the cost of predicting a sample within
#'  or on the wrong side of the margin
#' @param margin A positive number for the epsilon in the SVM insensitive
#'  loss function (regression only)
#' @param degree degree parameter for anova rbf
#' @param anova_rbf_sigma sigma parameter for anova rbf
#' @export

svm_anova_rbf <-
  function(mode = "unknown", engine = "kernlab",
           cost = NULL, anova_rbf_sigma = NULL, degree = NULL, margin = NULL) {

    args <- list(
      cost             = enquo(cost),
      anova_rbf_sigma  = enquo(anova_rbf_sigma),
      degree           = enquo(degree),
      margin           = enquo(margin)
    )

    parsnip::new_model_spec(
      "svm_anova_rbf",
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

#' @method update svm_anova_rbf
#' @rdname parsnip_update
#' @export
update.svm_anova_rbf <-
  function(object,
           parameters = NULL,
           cost = NULL, anova_rbf_sigma = NULL, degree = NULL, margin = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      cost             = enquo(cost),
      anova_rbf_sigma  = enquo(anova_rbf_sigma),
      degree           = enquo(degree),
      margin           = enquo(margin)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "svm_anova_rbf",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.svm_anova_rbf <- function(x, engine = x$engine, ...) {
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

    # convert sigma and degree to a `kpar` argument.
    if (any(arg_names %in% c("sigma", "degree", "offset"))) {
      kpar <- rlang::expr(list())
      if (any(arg_names == "sigma")) {
        kpar$sigma <- arg_vals$sigma
        arg_vals$sigma <- NULL
      }
      if (any(arg_names == "degree")) {
        kpar$degree <- arg_vals$degree
        arg_vals$degree <- NULL
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
check_args.svm_anova_rbf <- function(object, call = rlang::caller_env()) {
  invisible(object)
}
