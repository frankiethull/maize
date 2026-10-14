# Bessel Support Vector Machine

bessel kernel for support vector machines

## Usage

``` r
svm_bessel(
  mode = "unknown",
  engine = "kernlab",
  cost = NULL,
  bessel_sigma = NULL,
  degree = NULL,
  order = NULL,
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

- bessel_sigma:

  sigma parameter for bessel

- degree:

  degree parameter for bessel

- order:

  order parameter for bessel

- margin:

  A positive number for the epsilon in the SVM insensitive loss function
  (regression only)
