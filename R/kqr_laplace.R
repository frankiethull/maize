#' Laplacian Kernel Quantile Regression
#' @description laplacian kernel
#' @param mode regression
#' @param engine kernlab kqr
#' @param cost A positive number for the cost of predicting a sample within
#'  or on the wrong side of the margin
#' @param tau a quantile for the loss function
#' @param laplace_sigma sigma parameter for laplacian
#' @export

kqr_laplace <-
  function(mode = "unknown", engine = "kernlab",
           cost = NULL, tau = NULL, laplace_sigma = NULL) {

    args <- list(
      cost   = enquo(cost),
      tau    = enquo(tau),
      laplace_sigma = enquo(laplace_sigma)
    )

    parsnip::new_model_spec(
      "kqr_laplace",
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

#' @method update kqr_laplace
#' @rdname parsnip_update
#' @export
update.kqr_laplace <-
  function(object,
           parameters = NULL,
           cost = NULL, tau = NULL, laplace_sigma = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      cost   = enquo(cost),
      tau  = enquo(tau),
      laplace_sigma = enquo(laplace_sigma)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "kqr_laplace",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.kqr_laplace <- function(x, engine = x$engine, ...) {
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
check_args.kqr_laplace <- function(object, call = rlang::caller_env()) {
  invisible(object)
}

