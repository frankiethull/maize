#' Laplacian function kernel PCA signal extraction
#'
#' `step_kpca_laplace()` creates a *specification* of a recipe step that will
#' convert numeric data into one or more principal components using a laplace
#' kernel
#' @param recipe A recipe object. The step will be added to the
#'  sequence of operations for this recipe.
#' @param ... One or more selector functions to choose variables
#'  for this step. See [selections()] for more details.
#' @param role For model terms created by this step, what analysis role should
#'  they be assigned? By default, the new columns created by this step from
#'  the original variables will be used as _predictors_ in a model.
#' @param trained A logical to indicate if the quantities for
#'  preprocessing have been estimated.
#' @param num_comp The number of components to retain as new predictors.
#'  If `num_comp` is greater than the number of columns or the number of
#'  possible components, a smaller value will be used. If `num_comp = 0`
#'  is set then no transformation is done and selected variables will
#'  stay unchanged, regardless of the value of `keep_original_cols`.
#' @param columns A character string of the selected variable names. This field
#'   is a placeholder and will be populated once [prep()] is used.
#' @param prefix A character string for the prefix of the resulting new
#'  variables. See notes below.
#' @param keep_original_cols A logical to keep the original variables in the
#'  output. Defaults to `FALSE`.
#' @param sigma A numeric value for the laplace function parameter.
#' @param res An S4 [kernlab::kpca()] object is stored
#'  here once this preprocessing step has be trained by
#'  [prep()].
#' @param skip A logical. Should the step be skipped when the
#'  recipe is baked by [bake()]? While all operations are baked
#'  when [prep()] is run, some operations may not be able to be
#'  conducted on new data (e.g. processing the outcome variable(s)).
#'  Care should be taken when using `skip = TRUE` as it may affect
#'  the computations for subsequent operations.
#' @param id A character string that is unique to this step to identify it.
#' @family multivariate transformation steps
#' @export
step_kpca_laplace <-
  function(recipe,
           ...,
           role = "predictor",
           trained = FALSE,
           num_comp = 5,
           res = NULL,
           columns = NULL,
           sigma = 0.2,
           prefix = "kPC",
           keep_original_cols = FALSE,
           skip = FALSE,
           id = rand_id("kpca_laplace")) {
    recipes_pkg_check(required_pkgs.step_kpca_laplace())

    add_step(
      recipe,
      step_kpca_laplace_new(
        terms = enquos(...),
        role = role,
        trained = trained,
        num_comp = num_comp,
        res = res,
        columns = columns,
        sigma = sigma,
        prefix = prefix,
        keep_original_cols = keep_original_cols,
        skip = skip,
        id = id
      )
    )
  }

step_kpca_laplace_new <-
  function(terms, role, trained, num_comp, res, columns, sigma, prefix,
           keep_original_cols, skip, id) {
    step(
      subclass = "kpca_laplace",
      terms = terms,
      role = role,
      trained = trained,
      num_comp = num_comp,
      res = res,
      columns = columns,
      sigma = sigma,
      prefix = prefix,
      keep_original_cols = keep_original_cols,
      skip = skip,
      id = id
    )
  }

#' @export
prep.step_kpca_laplace <- function(x, training, info = NULL, ...) {
  col_names <- recipes_eval_select(x$terms, training, info)
  check_type(training[, col_names], types = c("double", "integer"))

  if (x$num_comp > 0 && length(col_names) > 0) {
    cl <-
      rlang::call2(
        "kpca",
        .ns = "kernlab",
        x = rlang::expr(as.matrix(training[, col_names])),
        features = x$num_comp,
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

  step_kpca_laplace_new(
    terms = x$terms,
    role = x$role,
    trained = TRUE,
    num_comp = x$num_comp,
    sigma = x$sigma,
    res = kprc,
    columns = col_names,
    prefix = x$prefix,
    keep_original_cols = get_keep_original_cols(x),
    skip = x$skip,
    id = x$id
  )
}

#' @export
bake.step_kpca_laplace <- function(object, new_data, ...) {
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
print.step_kpca_laplace <- function(x, width = max(20, options()$width - 40), ...) {
  title <- "laplace kernel PCA extraction with "
  print_step(x$columns, x$terms, x$trained, title, width)
  invisible(x)
}


#' @rdname tidy.recipe
#' @export
tidy.step_kpca_laplace <- function(x, ...) {
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
tunable.step_kpca_laplace <- function(x, ...) {
  tibble::tibble(
    name = c("num_comp", "sigma"),
    call_info = list(
      list(pkg = "dials", fun = "num_comp", range = c(1L, 4L)),
      list(pkg = "dials", fun = "laplace_sigma")
    ),
    source = "recipe",
    component = "step_kpca_laplace",
    component_id = x$id
  )
}

#' @rdname required_pkgs.recipe
#' @export
required_pkgs.step_kpca_laplace <- function(x, ...) {
  c("kernlab")
}
