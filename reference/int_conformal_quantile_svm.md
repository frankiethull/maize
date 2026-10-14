# Prediction intervals via conformal inference and QRSVM

To compute quantiles, this function uses Quantile SVM instead of
probably's `"int_conformal_quantile"` QRF or classic quantile
regression.

## Usage

``` r
int_conformal_quantile_svm(object, ...)

# S3 method for class 'workflow'
int_conformal_quantile_svm(object, train_data, cal_data, level = 0.95, ...)
```

## Arguments

- object:

  A fitted
  [`workflows::workflow()`](https://workflows.tidymodels.org/reference/workflow.html)
  object.

- ...:

  Options to pass to
  [`qrsvm::qrsvm()`](https://rdrr.io/pkg/qrsvm/man/qrsvm.html)

- train_data, cal_data:

  Data frames with the *predictor and outcome data*. `train_data` should
  be the same data used to produce `object` and `cal_data` is used to
  produce predictions (and residuals). If the workflow used a recipe,
  these should be the data that were inputs to the recipe (and not the
  product of a recipe).

- level:

  The confidence level for the intervals.

## Value

An object of class `"int_conformal_quantile"` containing the information
to create intervals (which includes `object`). The
[`predict()`](https://rdrr.io/r/stats/predict.html) method is used to
produce the intervals.

## Details

based on the initial probably implementation with slight modification.

origin:
https://github.com/tidymodels/probably/blob/HEAD/R/conformal_infer_quantile.R

for more information, visit: https://probably.tidymodels.org
