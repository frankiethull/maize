# Laplacian Relevance Vector Machine (Experimental RVM)

laplacian kernel

## Usage

``` r
rvm_laplace(
  mode = "unknown",
  engine = "kernlab",
  alpha = NULL,
  var = NULL,
  laplace_sigma = NULL
)
```

## Arguments

- mode:

  regression only for RVM

- engine:

  kernlab rvm

- alpha:

  (alpha) The initial alpha value or vector. Can be either a vector of
  length equal to the number of data points or a single number.

- var:

  (var) the initial noise variance

- laplace_sigma:

  sigma parameter for laplacian
