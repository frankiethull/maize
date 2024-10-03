#' Laplacian function kernel PCA signal extraction
#'
#' `step_kpca_tanh()` creates a *specification* of a recipe step that will
#' convert numeric data into one or more principal components using a tanh
#' kernel basis expansion.
#' @inheritParams step_kpca_laplace
#' @param scale_factor A numeric value for the tanh function parameter.
#' @param res An S4 [kernlab::kpca()] object is stored
#'  here once this preprocessing step has be trained by
#'  [prep()].
#' @family multivariate transformation steps
#' @export
step_kpca_tanh <-
  function(recipe,
           ...,
           role = "predictor",
           trained = FALSE,
           num_comp = 5,
           res = NULL,
           columns = NULL,
           scale_factor = 0.2,
           prefix = "kPC",
           keep_original_cols = FALSE,
           skip = FALSE,
           id = rand_id("kpca_tanh")) {
    recipes_pkg_check(required_pkgs.step_kpca_tanh())

    add_step(
      recipe,
      step_kpca_tanh_new(
        terms = enquos(...),
        role = role,
        trained = trained,
        num_comp = num_comp,
        res = res,
        columns = columns,
        scale_factor = scale_factor,
        prefix = prefix,
        keep_original_cols = keep_original_cols,
        skip = skip,
        id = id
      )
    )
  }

step_kpca_tanh_new <-
  function(terms, role, trained, num_comp, res, columns, scale_factor, prefix,
           keep_original_cols, skip, id) {
    step(
      subclass = "kpca_tanh",
      terms = terms,
      role = role,
      trained = trained,
      num_comp = num_comp,
      res = res,
      columns = columns,
      scale_factor = scale_factor,
      prefix = prefix,
      keep_original_cols = keep_original_cols,
      skip = skip,
      id = id
    )
  }

#' @export
prep.step_kpca_tanh <- function(x, training, info = NULL, ...) {
  col_names <- recipes_eval_select(x$terms, training, info)
  check_type(training[, col_names], types = c("double", "integer"))

  if (x$num_comp > 0 && length(col_names) > 0) {
    cl <-
      rlang::call2(
        "kpca",
        .ns = "kernlab",
        x = rlang::expr(as.matrix(training[, col_names])),
        features = x$num_comp,
        kernel = "tanhdot",
        kpar = list(scale_factor = x$scale_factor)
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

  step_kpca_tanh_new(
    terms = x$terms,
    role = x$role,
    trained = TRUE,
    num_comp = x$num_comp,
    scale_factor = x$scale_factor,
    res = kprc,
    columns = col_names,
    prefix = x$prefix,
    keep_original_cols = get_keep_original_cols(x),
    skip = x$skip,
    id = x$id
  )
}

#' @export
bake.step_kpca_tanh <- function(object, new_data, ...) {
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
print.step_kpca_tanh <- function(x, width = max(20, options()$width - 40), ...) {
  title <- "tanh kernel PCA extraction with "
  print_step(x$columns, x$terms, x$trained, title, width)
  invisible(x)
}


#' @rdname tidy.recipe
#' @export
tidy.step_kpca_tanh <- function(x, ...) {
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
tunable.step_kpca_tanh <- function(x, ...) {
  tibble::tibble(
    name = c("num_comp", "scale_factor"),
    call_info = list(
      list(pkg = "dials", fun = "num_comp", range = c(1L, 4L)),
      list(pkg = "dials", fun = "scale_factor")
    ),
    source = "recipe",
    component = "step_kpca_tanh",
    component_id = x$id
  )
}

#' @rdname required_pkgs.recipe
#' @export
required_pkgs.step_kpca_tanh <- function(x, ...) {
  c("kernlab")
}
