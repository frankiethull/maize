# {maize} package


## what is {maize}?

{maize} is an extension library for support vector machines in
tidymodels! The package consists of additional kernel bindings listed in
{kernlab} that are not available in the {parsnip} package.

{parnsip} has three kernels available: linear, radial basis function, &
polynomial. {maize} currently includes five more kernels: laplace,
bessel, anova rbf, spline, & hyperbolic tangent.

## kernels and kernels

say we have three types of corn with different size kernels which create
different height corn. we could (1) create a support vector machine that
can predict the height of the corn given the kernel type and kernel
size, we could also (2) predict the corn type given the kernel size and
corn height.

#### corn kernel dataset

``` r
library(parsnip)
library(maize)
```


    Attaching package: 'maize'

    The following object is masked from 'package:parsnip':

        check_args

``` r
library(ggplot2)

maize::corn_data |>
    ggplot() +
    geom_point(aes(x = kernel_size, y = height, color = type)) +
    theme_minimal() +
    labs(title = 'corn kernel data') 
```

![](readme_files/figure-commonmark/unnamed-chunk-1-1.png)

#### regression for corn kernel height given a specialty svm kernel

``` r
corn_train <- corn_data |> dplyr::sample_frac(.80)
corn_test  <- corn_data |> dplyr::anti_join(corn_train)
```

    Joining with `by = join_by(height, kernel_size, type)`

``` r
# model params --
  svm_reg_spec <- 
    svm_bessel(cost = 1, margin = 0.1) |> 
    set_mode("regression") |>
    set_engine("kernlab")


# fit --
set.seed(31415)
  svm_reg_fit <- svm_reg_spec |> fit(height ~ ., data = corn_train)
```

     Setting default kernel parameters  

``` r
# predictions --
preds <- predict(svm_reg_fit, corn_test)

# plot --
corn_test |>
  cbind(preds) |> 
    ggplot() +
    geom_point(aes(x = kernel_size, y = height, color = type), shape = 1, size = 2) +
    geom_point(aes(x = kernel_size, y = .pred,  color = type), shape = 2, size = 3) +
    theme_minimal() +
    labs(title = 'Bessel Kernel SVM',
         subtitle = "corn height prediction") 
```

![](readme_files/figure-commonmark/unnamed-chunk-2-1.png)

#### classification of corn kernel type given a specialty svm kernel

``` r
# model params --
  svm_cls_spec <- 
    svm_laplace(cost = 1, margin = 0.1, laplace_sigma = 10) |> 
    set_mode("classification") |>
    set_engine("kernlab")
  
# fit --
set.seed(31415)
  svm_cls_fit <- svm_cls_spec |> fit(type ~ ., data = corn_train)

# predictions --
preds <- predict(svm_cls_fit, corn_test, "class")

# plot --
corn_test |>
  cbind(preds) |> 
  dplyr::mutate(
    correct = ifelse(type == .pred_class, "correct corn!", "not correct")
  ) |>
    ggplot() +
    geom_point(aes(x = kernel_size, y = height,  color = correct), size = 2) +
    theme_minimal() +
    labs(title = 'Laplace Kernel SVM',
         subtitle = "corn type prediction") 
```

![](readme_files/figure-commonmark/unnamed-chunk-3-1.png)

## future enhancements

although these five additions are all that are listed in {kernlab} atm,
it is possible to add additional kernels through custom function. These
can be added as a ‘kernel’ class in {kernlab} then used as the kernel
for a new svm\_ function in {maize}.

future kernels to consider: isolation, sigmoid, others??? feel free to
pull request or submit issue for some unique kernels.

other ideas, swap the *ksvm* func for *lssvm* and bind both svm
functions listed in {kernlab} (currently only supporting ksvm).

## references

this package is based off the initial parsnip code, kernlab documents,
and tidymodels’ developer guides. Mostly just copy/paste and connecting
systems. I gave this a go after looking under the hood of bonsai and
poissonreg packages managed by tidymodels team. Additionally, I saw an
opportunity for a funny pun joke {kernels, parsnip, ~ maize?}, joke is
on me though, it’s not that funny. BUT i did build this entirely from
Positron public beta which was a fun experience. I’d say that developing
packages is a lot easier in Positron IDE, whereas I still use RStudio
IDE for the time being for data analysis, data viz, ml, eda, etc. as
it’s less prone to crash at the moment.

##### cheatsheets on how to register a model

- https://www.tidymodels.org/learn/develop/models/
- https://github.com/tidymodels/parsnip/blob/main/R/svm_linear.R
- https://github.com/tidymodels/parsnip/blob/main/R/svm_rbf.R
- https://github.com/tidymodels/parsnip/blob/main/R/svm_rbf_data.R

##### make function ideas, zzz.R,check_args,

- https://github.com/tidymodels/poissonreg/tree/main/R
- https://github.com/tidymodels/bonsai/tree/main/R

##### kernel parameters (kpar)

- https://github.com/cran/kernlab/blob/master/R/kernels.R
- https://www.rdocumentation.org/packages/kernlab/versions/0.9-32/topics/ksvm