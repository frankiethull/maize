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