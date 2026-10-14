# Uses a support vector regression model to calibrate numeric predictions

Uses a support vector regression model to calibrate numeric predictions

## Usage

``` r
cal_estimate_svm(
  .data,
  truth = NULL,
  estimate = dplyr::matches("^.pred$"),
  smooth = TRUE,
  parameters = NULL,
  ...,
  .by = NULL
)

# S3 method for class 'data.frame'
cal_estimate_svm(
  .data,
  truth = NULL,
  estimate = dplyr::matches("^.pred$"),
  smooth = TRUE,
  parameters = NULL,
  ...,
  .by = NULL
)

# S3 method for class 'tune_results'
cal_estimate_svm(
  .data,
  truth = NULL,
  estimate = dplyr::matches("^.pred$"),
  smooth = TRUE,
  parameters = NULL,
  ...
)

# S3 method for class 'grouped_df'
cal_estimate_svm(
  .data,
  truth = NULL,
  estimate = NULL,
  smooth = TRUE,
  parameters = NULL,
  ...
)
```

## Arguments

- .data:

  An ungrouped `data.frame` object, or `tune_results` object, that
  contains a prediction column.

- truth:

  The column identifier for the observed outcome data (that is numeric).
  This should be an unquoted column name.

- estimate:

  Column identifier for the predicted values

- smooth:

  Applies to the svm models. It switches between a polydot`TRUE`, and
  vanilladot `FALSE`.

- parameters:

  (Optional) An optional tibble of tuning parameter values that can be
  used to filter the predicted values before processing. Applies only to
  `tune_results` objects.

- ...:

  Additional arguments passed to the models or routines used to
  calculate the new predictions.

## Details

This function uses existing modeling functions from other packages to
create the calibration:

- [`kernlab::ksvm()`](https://rdrr.io/pkg/kernlab/man/ksvm.html) with a
  "vanilladot" is used when `smooth` is set to `FALSE`

- [`kernlab::ksvm()`](https://rdrr.io/pkg/kernlab/man/ksvm.html) with a
  "polydot" is used when `smooth` is set to `TRUE`

These methods estimate the relationship in the unmodified predicted
values and then remove that trend when `cal_apply()` is invoked.

## See also

<https://www.tidymodels.org/learn/models/calibration/>,
