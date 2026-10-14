# Laplacian Kernel Quantile Regression

laplacian kernel

## Usage

``` r
kqr_laplace(
  mode = "unknown",
  engine = "kernlab",
  cost = NULL,
  tau = NULL,
  laplace_sigma = NULL
)
```

## Arguments

- mode:

  regression

- engine:

  kernlab kqr

- cost:

  A positive number for the cost of predicting a sample within or on the
  wrong side of the margin

- tau:

  a quantile for the loss function

- laplace_sigma:

  sigma parameter for laplacian
