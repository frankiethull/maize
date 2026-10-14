# General Interface for "Support Vector Machine" ARIMA Regression Models

`arima_svm_laplace()` is a way to generate a *specification* of a time
series model that uses SVMs to improve modeling errors (residuals) on
Exogenous Regressors. It works with both "automated" ARIMA
(`auto.arima`) and standard ARIMA (`arima`). The main algorithms are:

- Auto ARIMA + SVM Errors (engine = `auto_arima_svm_laplace`, default)

- ARIMA + SVM Errors (engine = `arima_svm_laplace`)

## Usage

``` r
arima_svm_laplace(
  mode = "regression",
  seasonal_period = NULL,
  non_seasonal_ar = NULL,
  non_seasonal_differences = NULL,
  non_seasonal_ma = NULL,
  seasonal_ar = NULL,
  seasonal_differences = NULL,
  seasonal_ma = NULL,
  cost = NULL,
  margin = NULL,
  laplace_sigma = NULL
)
```

## Arguments

- mode:

  A single character string for the type of model. The only possible
  value for this model is "regression".

- seasonal_period:

  A seasonal frequency. Uses "auto" by default. A character phrase of
  "auto" or time-based phrase of "2 weeks" can be used if a date or
  date-time variable is provided. See Fit Details below.

- non_seasonal_ar:

  The order of the non-seasonal auto-regressive (AR) terms. Often
  denoted "p" in pdq-notation.

- non_seasonal_differences:

  The order of integration for non-seasonal differencing. Often denoted
  "d" in pdq-notation.

- non_seasonal_ma:

  The order of the non-seasonal moving average (MA) terms. Often denoted
  "q" in pdq-notation.

- seasonal_ar:

  The order of the seasonal auto-regressive (SAR) terms. Often denoted
  "P" in PDQ-notation.

- seasonal_differences:

  The order of integration for seasonal differencing. Often denoted "D"
  in PDQ-notation.

- seasonal_ma:

  The order of the seasonal moving average (SMA) terms. Often denoted
  "Q" in PDQ-notation.

- cost:

  A positive number for the cost of predicting a sample within or on the
  wrong side of the margin

- margin:

  A positive number for the epsilon in the SVM insensitive loss function
  (regression only)

- laplace_sigma:

  sigma parameter for laplacian

- sample_size:

  number for the number (or proportion) of data that is exposed to the
  fitting routine.
