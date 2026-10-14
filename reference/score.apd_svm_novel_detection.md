# Predict from a `apd_svm_novel_detection`

Predict from a `apd_svm_novel_detection`

## Usage

``` r
# S3 method for class 'apd_svm_novel_detection'
score(object, new_data, type = "numeric", ...)
```

## Arguments

- object:

  A `apd_svm_novel_detection` object.

- new_data:

  A data frame or matrix of new samples.

- type:

  A single character. The type of predictions to generate. Valid options
  are:

  - `"numeric"` for numeric predictions.

- ...:

  Not used, but required for extensibility.

## Value

A tibble of predictions. The number of rows in the tibble is guaranteed
to be the same as the number of rows in `new_data`. The `score` column
is the raw prediction from `kernlab::predict()` while `score_pctl`
compares this value to the reference distribution of the score created
by predicting the training set. A value of *X* means that *X* percent of
the training data have scores less than the predicted value.

## Details

About the score

## See also

[`apd_svm_novel_detection()`](https://frankiethull.github.io/maize/reference/apd_svm_novel_detection.md)
