#' @export
#' @keywords internal
#' @rdname add_on_exports
check_args <- function(object, call = rlang::caller_env()) {
  UseMethod("check_args")
}

#' @export
check_args.default <- function(object, call = rlang::caller_env()) {
  invisible(object)
}

# for recipes
uses_dim_red <- function(x) {
  dr <- inherits(x, "dimRedResult")
  if (dr) {
    cli::cli_abort(
      "Recipes version >= 0.1.17 represents the estimates using a different \\
      format. Please recreate this recipe or use version 0.1.16 or less. See \\
      issue {.href [#823](https://github.com/tidymodels/recipes/issues/823)}."
    )
  }
  invisible(NULL)
}
