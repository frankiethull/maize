# RUS Bagged SVM with Radial Basis Function Kernel

RUS Bagged SVM with Radial Basis Function Kernel

## Usage

``` r
bag_svm_rbf(
  mode = "unknown",
  engine = "ebmc",
  num_learners = NULL,
  imb_ratio = NULL
)
```

## Arguments

- mode:

  classification

- engine:

  ebmc's ub which uses e1701's svm

- num_learners:

  how many weak learners should be ensembled via bagging

- imb_ratio:

  major-minor class imbalance ratio
