# Synthetic Corn Dataset for Corny Example

Synthetic Corn Dataset for Corny Example

## Source

claude-3-5-sonnet-20240620

## Value

- corn_data:

  a tibble

## Details

Asked Claude Sonnet for a corn data given the README story problem

## Examples

``` r
data(corn_data)
str(corn_data)
#> tibble [300 × 3] (S3: tbl_df/tbl/data.frame)
#>  $ height     : num [1:300] 59.5 57.3 55.4 52.6 61 ...
#>  $ kernel_size: num [1:300] 6.53 9.7 8.48 10.29 7.53 ...
#>  $ type       : Factor w/ 3 levels "Field","Popcorn",..: 3 3 3 3 3 3 3 3 3 3 ...
```
