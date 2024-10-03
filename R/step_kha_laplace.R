#' Laplacian function kernel PCA signal extraction via Hebbian Algorithm
#'
#' `step_kha_laplace()` creates a *specification* of a recipe step that will
#' convert numeric data into one or more principal components using a laplace
#' kernel basis expansion.
#' @inheritParams step_kpca_laplace
#' @param sigma A numeric value for the laplace function parameter.
#' @param learn_rate hebbian learning rate
#' @param threshold the smallest value of the convergence step
#' @param stop_iter maximum number of iterations
#' @param res An S4 [kernlab::kha()] object is stored
#'  here once this preprocessing step has be trained by
#'  [prep()].
#' @family multivariate transformation steps
#' @export
step_kha_laplace <-
  function(recipe,
           ...,
           role = "predictor",
           trained = FALSE,
           num_comp = 5,
           res = NULL,
           columns = NULL,
           sigma = 0.2,
           learn_rate = 0.005, # eta
           threshold = 0.0001, # th
           stop_iter = 100,    # maxiter
           prefix = "kha",
           keep_original_cols = FALSE,
           skip = FALSE,
           id = rand_id("kha_laplace")) {
    recipes_pkg_check(required_pkgs.step_kha_laplace())

    add_step(
      recipe,
      step_kha_laplace_new(
        terms = enquos(...),
        role = role,
        trained = trained,
        num_comp = num_comp,
        res = res,
        columns = columns,
        sigma = sigma,
        learn_rate = learn_rate,
        threshold =  threshold,
        stop_iter =  stop_iter,
        prefix = prefix,
        keep_original_cols = keep_original_cols,
        skip = skip,
        id = id
      )
    )
  }

step_kha_laplace_new <-
  function(terms, role, trained, num_comp, res, columns, sigma, learn_rate, threshold, stop_iter, prefix,
           keep_original_cols, skip, id) {
    step(
      subclass = "kha_laplace",
      terms = terms,
      role = role,
      trained = trained,
      num_comp = num_comp,
      res = res,
      columns = columns,
      sigma = sigma,
      learn_rate = learn_rate,
      threshold =  threshold,
      stop_iter =  stop_iter,
      prefix = prefix,
      keep_original_cols = keep_original_cols,
      skip = skip,
      id = id
    )
  }

#' @export
prep.step_kha_laplace <- function(x, training, info = NULL, ...) {
  col_names <- recipes_eval_select(x$terms, training, info)
  check_type(training[, col_names], types = c("double", "integer"))

  if (x$num_comp > 0 && length(col_names) > 0) {
    cl <-
      rlang::call2(
        "kha",
        .ns = "kernlab",
        x = rlang::expr(as.matrix(training[, col_names])),
        features = x$num_comp,
        learn_rate = x$eta,
        threshold =  x$th,
        stop_iter =  x$maxiter,
        kernel = "laplacedot",
        kpar = list(sigma = x$sigma)
      )
    kprc <- try(rlang::eval_tidy(cl), silent = TRUE)
    if (inherits(kprc, "try-error")) {
      cli::cli_abort(c(
        x = "Failed with error:",
        i = as.character(kprc)
      ))
    }
  } else {
    kprc <- NULL
  }

  step_kha_laplace_new(
    terms = x$terms,
    role = x$role,
    trained = TRUE,
    num_comp = x$num_comp,
    sigma = x$sigma,
    learn_rate = x$eta,
    threshold =  x$th,
    stop_iter =  x$maxiter,
    res = kprc,
    columns = col_names,
    prefix = x$prefix,
    keep_original_cols = get_keep_original_cols(x),
    skip = x$skip,
    id = x$id
  )
}

#' @export
bake.step_kha_laplace <- function(object, new_data, ...) {
  uses_dim_red(object)
  col_names <- names(object$columns)
  check_new_data(col_names, object, new_data)

  keep_going <- object$num_comp > 0 && length(col_names) > 0
  if (!keep_going) {
    return(new_data)
  }

  cl <-
    rlang::call2(
      "predict",
      .ns = "kernlab",
      object = object$res,
      rlang::expr(as.matrix(new_data[, col_names]))
    )
  comps <- rlang::eval_tidy(cl)
  comps <- comps[, seq_len(object$num_comp), drop = FALSE]
  colnames(comps) <- names0(ncol(comps), object$prefix)
  comps <- as_tibble(comps)
  comps <- check_name(comps, new_data, object)
  new_data <- vec_cbind(new_data, comps)
  new_data <- remove_original_cols(new_data, object, col_names)
  new_data
}

#' @export
print.step_kha_laplace <- function(x, width = max(20, options()$width - 40), ...) {
  title <- "laplace kernel Hebbian PCA extraction with "
  print_step(x$columns, x$terms, x$trained, title, width)
  invisible(x)
}


#' @rdname tidy.recipe
#' @export
tidy.step_kha_laplace <- function(x, ...) {
  uses_dim_red(x)
  if (is_trained(x)) {
    res <- tibble(terms = unname(x$columns))
  } else {
    term_names <- sel2char(x$terms)
    res <- tibble(terms = term_names)
  }
  res$id <- x$id
  res
}

#' @export
tunable.step_kha_laplace <- function(x, ...) {
  tibble::tibble(
    name = c("num_comp", "sigma"),
    call_info = list(
      list(pkg = "dials", fun = "num_comp", range = c(1L, 4L)),
      list(pkg = "dials", fun = "laplace_sigma")
    ),
    source = "recipe",
    component = "step_kha_laplace",
    component_id = x$id
  )
}

#' @rdname required_pkgs.recipe
#' @export
required_pkgs.step_kha_laplace <- function(x, ...) {
  c("kernlab")
}
