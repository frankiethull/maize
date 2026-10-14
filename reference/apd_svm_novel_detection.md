# Fit an SVM novelty detection model to estimate an applicability domain.

`apd_svm_novel_detection()` fits an 'one-svc' novelty detection model.

## Usage

``` r
apd_svm_novel_detection(x, ...)

# Default S3 method
apd_svm_novel_detection(x, ...)

# S3 method for class 'data.frame'
apd_svm_novel_detection(x, ...)

# S3 method for class 'matrix'
apd_svm_novel_detection(x, ...)

# S3 method for class 'formula'
apd_svm_novel_detection(formula, data, ...)

# S3 method for class 'recipe'
apd_svm_novel_detection(x, data, ...)
```

## Arguments

- x:

  Depending on the context:

  - A **data frame** of predictors.

  - A **matrix** of predictors.

  - A **recipe** specifying a set of preprocessing steps created from
    [`recipes::recipe()`](https://recipes.tidymodels.org/reference/recipe.html).

- ...:

  Options to pass to
  [`kernlab::ksvm()`](https://rdrr.io/pkg/kernlab/man/ksvm.html).
  Options should not include `data`.

- formula:

  A formula specifying the predictor terms on the right-hand side. No
  outcome should be specified.

- data:

  When a **recipe** or **formula** is used, `data` is specified as:

  - A **data frame** containing the predictors.

## Value

A `apd_svm_novel_detection` object.
