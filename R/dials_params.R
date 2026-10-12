# Custom dials tuning parameters for maize ----
#
# maize is a zoo of SVM variants, many with hyperparameters that have no
# equivalent in dials. These constructors follow the dials API
# (dials::new_quant_param / dials::new_qual_param) so they work with
# parsnip::set_model_arg(func = list(pkg = "maize", fun = ...)).

#' Number of weak learners
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
num_learners <- function(range = c(1L, 20L), trans = NULL) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_learners = "Number of Weak Learners"),
    finalize = NULL
  )
}

#' Imbalance ratio for resampling boosters
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
imb_ratio <- function(range = c(1, 2), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(imb_ratio = "Imbalance Ratio"),
    finalize = NULL
  )
}

#' Quantile level for quantile regression SVMs
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
tau <- function(range = c(.01, .99), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(tau = "Quantile Level"),
    finalize = NULL
  )
}

#' Alpha hyperparameter for RVM variants
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
alpha <- function(range = c(1, 5), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(alpha = "Alpha"),
    finalize = NULL
  )
}

#' Variance hyperparameter for RVM variants
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
var <- function(range = c(.01, 100), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(var = "Variance"),
    finalize = NULL
  )
}

#' Order of the Bessel function for Bessel kernels
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
bessel_order <- function(range = c(1L, 10L), trans = NULL) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(bessel_order = "Bessel Function Order"),
    finalize = NULL
  )
}

#' Substring length for string kernels
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
string_length <- function(range = c(1L, 10L), trans = NULL) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(string_length = "Substring Length"),
    finalize = NULL
  )
}

#' Decay factor for string kernels
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
string_lambda <- function(range = c(0, 1), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(string_lambda = "String Kernel Decay"),
    finalize = NULL
  )
}

#' Whether to normalize string kernel values
#'
#' @export
string_normalized <- function() {
  dials::new_qual_param(
    type = "logical",
    values = c(TRUE, FALSE),
    label = c(string_normalized = "Normalize String Kernel")
  )
}

#' Scale adjustment for wavelet kernels
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
wavelet_a <- function(range = c(.1, 10), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(wavelet_a = "Wavelet Scale Adjustment"),
    finalize = NULL
  )
}

#' Distance adjustment for wavelet kernels
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
wavelet_c <- function(range = c(0, 10), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(wavelet_c = "Wavelet Distance Adjustment"),
    finalize = NULL
  )
}

#' Wavelet function choice for wavelet kernels
#'
#' @param range A two-element vector for the range (inclusive).
#' @param trans A trans object (see `scales::trans_new()`).
#' @export
wavelet_h <- function(range = c(.1, 10), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(wavelet_h = "Wavelet Function Parameter"),
    finalize = NULL
  )
}
