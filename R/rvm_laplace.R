#' Laplacian Relevance Vector Machine (Experimental RVM)
#' @description laplacian kernel
#' @param mode regression only for RVM
#' @param engine kernlab rvm
#' @param alpha (alpha) The initial alpha value or vector.
#' Can be either a vector of length equal to the number of data points or a single number.
#' @param var 	(var) the initial noise variance
#' @param laplace_sigma sigma parameter for laplacian
#' @export

rvm_laplace <-
  function(mode = "unknown", engine = "kernlab",
           alpha = NULL, var = NULL, laplace_sigma = NULL) {

    args <- list(
      alpha   = enquo(alpha),
      var     = enquo(var),
      laplace_sigma = rlang::enquo(laplace_sigma)
    )

    parsnip::new_model_spec(
      "rvm_laplace",
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

#' @method update rvm_laplace
#' @rdname parsnip_update
#' @export
update.rvm_laplace <-
  function(object,
           parameters = NULL,
           alpha = NULL, var = NULL, laplace_sigma = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      alpha   = enquo(alpha),
      var     = enquo(var),
      laplace_sigma = enquo(laplace_sigma)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "rvm_laplace",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.rvm_laplace <- function(x, engine = x$engine, ...) {
  x <- parsnip::translate.default(x, engine = engine, ...)

  # slightly cleaner code using
  arg_vals <- x$method$fit$args
  arg_names <- names(arg_vals)

  # add checks to error trap or change things for this method
  if (x$engine == "kernlab") {

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
check_args.rvm_laplace <- function(object, call = rlang::caller_env()) {
  invisible(object)
}

