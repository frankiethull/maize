# Nystrom kernel feature map approximation (RBF)

`step_kfm_nystrom()` creates a *specification* of a recipe step that
will convert numeric data into a feature appoximation. nystrom
approximates the 'radial' kernel approximation.

## Usage

``` r
step_kfm_nystrom(
  recipe,
  ...,
  role = "predictor",
  trained = FALSE,
  res = NULL,
  columns = NULL,
  sigma = 0.2,
  m = NULL,
  r = NULL,
  sampling = "random",
  prefix = "kFM",
  keep_original_cols = FALSE,
  skip = FALSE,
  id = rand_id("kfm_nystrom")
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

- res:

  An
  [`mildsvm::kfm_nystrom()`](https://rdrr.io/pkg/mildsvm/man/kfm_nystrom.html)
  object is stored here once this preprocessing step has be trained by
  `prep()`.

- columns:

  A character string of the selected variable names. This field is a
  placeholder and will be populated once `prep()` is used.

- sigma:

  A numeric value for the nystrom function parameter.

- m:

  The number rows from df to sample in fitting. defaults to nrow of data

- r:

  The rank of matrix approximation to use. Must be less than or equal to
  m, the default.

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
[`step_kfa_laplace()`](https://frankiethull.github.io/maize/reference/step_kfa_laplace.md),
[`step_kha_laplace()`](https://frankiethull.github.io/maize/reference/step_kha_laplace.md),
[`step_kha_tanh()`](https://frankiethull.github.io/maize/reference/step_kha_tanh.md),
[`step_kpca_laplace()`](https://frankiethull.github.io/maize/reference/step_kpca_laplace.md),
[`step_kpca_tanh()`](https://frankiethull.github.io/maize/reference/step_kpca_tanh.md)
