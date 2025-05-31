#' Kernel Canonical Correlation Analysis
#' @description
#' Computes the canonical correlation analysis in feature space.
#' Kernel Canonical Correlation Analysis (KCCA) is a non-linear extension of CCA.
#' Given two random variables (or datasets), KCCA aims at extracting the information which is shared by the two random variables (or datasets).
#' more information found at [kernlab::kcca()]
#' @param x variable or dataframe
#' @param y variable or dataframe
#' @param kernel a kernel to use
#' @param gamma regularization parameter
#' @param num_comp number of components
#' @param ... pass through args for kcca function
#'
#' @return A kernel canonical correlation analysis data frame `kcor_df`
#' @export
kcca_correlate <- function(x, y = NULL,
                      kernel = "rbfdot",
                      gamma = 0.1,
                      num_comp = 10,
                      ...) {
  UseMethod("kcca_correlate")
}


#' @export
kcca_correlate.default <- function(x,
                                   y = NULL,
                                   kernel = "rbfdot",
                                   gamma = 0.1,
                                   num_comp = 10,
                                   ...) {
  if (is.null(y)) {
    y <- x
  }

  if (is.data.frame(x)) {
    x <- data.matrix(x)
  }

  if (is.data.frame(y)) {
    y <- data.matrix(y)
  }


  # kcca results --------------------------------------------------------------------
kcca_res <-
    kernlab::kcca(
      x = x,
      y = y,
      kernel = kernel,
      gamma  = gamma,
      ncomps = num_comp,
      ...
    )

 # kcor_df -------------------------------------------------------------------------

# cleaning up results ---

# canonical correlations  ~~~~~~~~~~~~~~~
k_cor <-
  dplyr::tibble(
  component = paste0("component_", seq_along(kcca_res@kcor)),
  canonical_correlation = as.numeric(kcca_res@kcor)
)

# xcoef: Projection coefficients for x in feature space (n samples x n comps) ~~~~~~~~~~~~~~~
x_coef <-
  as.data.frame(kcca_res@xcoef) |>
  dplyr::mutate(sample = dplyr::row_number()) |>
  tidyr::pivot_longer(cols = -sample, names_to = "component", values_to = "x_feature_space") |>
  dplyr::mutate(component = paste0("component_", as.numeric(substring(component, 2))))

# ycoef: Projection coefficients for y in feature space (n samples x ncomps)  ~~~~~~~~~~~~~~~
y_coef <-
  as.data.frame(kcca_res@ycoef) |>
  dplyr::mutate(sample = dplyr::row_number()) |>
  tidyr::pivot_longer(cols = -sample, names_to = "component", values_to = "y_feature_space") |>
  dplyr::mutate(component = paste0("component_", as.numeric(substring(component, 2))))

# return as one large df instead of correlation table ~~~~~~~~~~~~~~~~~~~
kcor_df <-
k_cor |>
  dplyr::left_join(x_coef, by = "component") |>
  dplyr::left_join(y_coef, by = c("component", "sample")) |>
  dplyr::mutate(component = as.numeric(gsub("component_", "", component))) |>
  dplyr::as_tibble()

# make it a special _df class ~~~~~~~~~~~~~~~~~~~~
class(kcor_df) <- c("kcor_df", class(kcor_df))

  kcor_df

}


#' visualize component x-y feature space
#'
#' @param x a kcor_df object
#' @export
autoplot.kcor_df <- function(x){

# x <- kcor_df

  x |>
  dplyr::mutate(component = as.factor(component)) |>
  ggplot2::ggplot() +
  geom_point(ggplot2::aes(x = x_feature_space, y = y_feature_space, color = component)) +
  ggplot2::facet_wrap(~component, scales = "free") +
  ggplot2::theme_minimal() +
  ggplot2::scale_color_viridis_d(option = "G", end = .8)

}
