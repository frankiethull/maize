# Laplacian function kernel KFA signal extraction

`step_kfa_laplace()` creates a *specification* of a recipe step that
will convert numeric data into one or more kernel components using a
laplace kernel. similar to KPCA, but instead of extracting eigenvectors
of the dataset in feature space, it approximates the eigenvectors by
selecting patterns which are good basis vectors for the dataset.

## Usage

``` r
step_kfa_laplace(
  recipe,
  ...,
  role = "predictor",
  trained = FALSE,
  num_comp = 5,
  res = NULL,
  columns = NULL,
  sigma = 0.2,
  prefix = "kFA",
  keep_original_cols = FALSE,
  skip = FALSE,
  id = rand_id("kfa_laplace")
)
```

## Arguments

- recipe:

  A recipe object. The step will be added to the sequence of operations
  for this recipe.

- ...:

  One or more selector functions to choose variables for this step. See
  `selections()` for more details.

- role:

  For model terms created by this step, what analysis role should they
  be assigned? By default, the new columns created by this step from the
  original variables will be used as *predictors* in a model.

- trained:

  A logical to indicate if the quantities for preprocessing have been
  estimated.

- num_comp:

  The number of components to retain as new predictors. If `num_comp` is
  greater than the number of columns or the number of possible
  components, a smaller value will be used. If `num_comp = 0` is set
  then no transformation is done and selected variables will stay
  unchanged, regardless of the value of `keep_original_cols`.

- res:

  An S4 [`kernlab::kfa()`](https://rdrr.io/pkg/kernlab/man/kfa.html)
  object is stored here once this preprocessing step has be trained by
  `prep()`.

- columns:

  A character string of the selected variable names. This field is a
  placeholder and will be populated once `prep()` is used.

- sigma:

  A numeric value for the laplace function parameter.

- prefix:

  A character string for the prefix of the resulting new variables. See
  notes below.

- keep_original_cols:

  A logical to keep the original variables in the output. Defaults to
  `FALSE`.

- skip:

  A logical. Should the step be skipped when the recipe is baked by
  `bake()`? While all operations are baked when `prep()` is run, some
  operations may not be able to be conducted on new data (e.g.
  processing the outcome variable(s)). Care should be taken when using
  `skip = TRUE` as it may affect the computations for subsequent
  operations.

- id:

  A character string that is unique to this step to identify it.

## See also

Other multivariate transformation steps:
[`step_kfm_nystrom()`](https://frankiethull.github.io/maize/reference/step_kfm_nystrom.md),
[`step_kha_laplace()`](https://frankiethull.github.io/maize/reference/step_kha_laplace.md),
[`step_kha_tanh()`](https://frankiethull.github.io/maize/reference/step_kha_tanh.md),
[`step_kpca_laplace()`](https://frankiethull.github.io/maize/reference/step_kpca_laplace.md),
[`step_kpca_tanh()`](https://frankiethull.github.io/maize/reference/step_kpca_tanh.md)
