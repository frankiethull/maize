# Cauchy Support Vector Machine

cauchy kernel for support vector machines

## Usage

``` r
svm_cauchy(
  mode = "unknown",
  engine = "kernlab",
  cost = NULL,
  margin = NULL,
  sigma = NULL
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

- margin:

  A positive number for the epsilon in the SVM insensitive loss function
  (regression only)

- sigma:

  a sigma parameter for cauchy kernels
