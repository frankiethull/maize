#' AdaBoost SVM with Radial Basis Function Kernel
#' @param mode classification
#' @param engine ebmc's adam2 which uses e1701's svm
#' @param num_learners how many weak learners should be ensembled via boosting
#' @param imb_ratio major-minor class imbalance ratio
#' @export

ada_boost_svm_rbf <-
  function(mode = "unknown", engine = "ebmc",
           num_learners = NULL, imb_ratio = NULL) {

    args <- list(
      num_learners   = enquo(num_learners),
      imb_ratio    = enquo(imb_ratio)
    )

    parsnip::new_model_spec(
      "ada_boost_svm_rbf",
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

#' @method update ada_boost_svm_rbf
#' @rdname parsnip_update
#' @export
update.ada_boost_svm_rbf <-
  function(object,
           parameters = NULL,
           num_learners = NULL, imb_ratio = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      num_learners   = enquo(num_learners),
      imb_ratio      = enquo(imb_ratio)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "ada_boost_svm_rbf",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.ada_boost_svm_rbf <- function(x, engine = x$engine, ...) {
  x <- parsnip::translate.default(x, engine = engine, ...)

  # slightly cleaner code using
  arg_vals <- x$method$fit$args
  arg_names <- names(arg_vals)

  # # add checks to error trap or change things for this method
  # if (x$engine == "kernlab") {
  #
  #   # unless otherwise specified, classification models predict probabilities
  #   if (x$mode == "classification" && !any(arg_names == "prob.model"))
  #     arg_vals$prob.model <- TRUE
  #   if (x$mode == "classification" && any(arg_names == "epsilon"))
  #     arg_vals$epsilon <- NULL
  #
  # }

  x$method$fit$args <- arg_vals

  # worried about people using this to modify the specification
  x
}

# ------------------------------------------------------------------------------

#' @export
check_args.ada_boost_svm_rbf <- function(object, call = rlang::caller_env()) {
  invisible(object)
}

