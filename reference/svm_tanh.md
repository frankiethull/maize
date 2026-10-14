# Hyperbolic Tangent Support Vector Machine

tanh kernel for support vector machines

## Usage

``` r
svm_tanh(
  mode = "unknown",
  engine = "kernlab",
  cost = NULL,
  scale_factor = NULL,
  margin = NULL
)
```

## Arguments

- mode:

  regression or classification

- engine:

  kernlab ksvm

- cost:

  A positive number for the cost of predicting a sample within or on the
  wrong side of the margin

- scale_factor:

  scale parameter for tanh

- margin:

  A positive number for the epsilon in the SVM insensitive loss function
  (regression only)
