# String Support Vector Machine

stringdot for support vector machines

## Usage

``` r
svm_string(
  x,
  y,
  mode = "unknown",
  engine = "kernlab",
  cost = NULL,
  length = NULL,
  lambda = NULL,
  normalized = TRUE,
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

- length:

  The length of the substrings considered

- lambda:

  The decay factor

- normalized:

  normalize string kernel values, (default = TRUE)

- margin:

  A positive number for the epsilon in the SVM insensitive loss function
  (regression only)
