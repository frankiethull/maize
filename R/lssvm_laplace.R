#' Laplacian Least Squares Support Vector Machine
#' @description laplacian kernel
#' @param mode classification
#' @param engine kernlab lssvm
#' @param laplace_sigma sigma parameter for laplacian
#' @export

lssvm_laplace <-
  function(mode = "unknown", engine = "kernlab",laplace_sigma = NULL) {

    args <- list(
      laplace_sigma = enquo(laplace_sigma)
    )

    parsnip::new_model_spec(
      "lssvm_laplace",
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

#' @method update lssvm_laplace
#' @rdname parsnip_update
#' @export
update.lssvm_laplace <-
  function(object,
           parameters = NULL, laplace_sigma = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      laplace_sigma = enquo(laplace_sigma)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "lssvm_laplace",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.lssvm_laplace <- function(x, engine = x$engine, ...) {
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

    # convert sigma and scale to a `kpar` argument.
    if (any(arg_names == "sigma")) {
      kpar <- rlang::expr(list())
      kpar$sigma <- arg_vals$sigma
      arg_vals$sigma <- NULL
      arg_vals$kpar <- kpar
    }

  }

  x$method$fit$args <- arg_vals

  # worried about people using this to modify the specification
  x
}

# ------------------------------------------------------------------------------

#' @export
check_args.lssvm_laplace <- function(object, call = rlang::caller_env()) {
  invisible(object)
}

