# {maize} package


# maize <img src="man/figures/logo.png" align="right" height="139" alt="" />

## stringdot bindings

this branch, *popcorn_garland*, is all about *kernel strings*. Testing
stringdot from the kernlab package which has a handful of types:
(spectrum, boundrange, constant, exponential, string, fullstring).

Initially skipped string dot as it’s a text classification kernel and
requires lists input.

svm_string tests will occur in this branch and PR into main.

### testing a dummy data with underlying engine

before binding, let’s make a quick test:

``` r
library(parsnip)
library(kernlab)
library(maize)
```


    Attaching package: 'maize'

    The following object is masked from 'package:parsnip':

        check_args

``` r
# Create two separate lists for descriptions and labels
descriptions <- list(
  "Yellow kernels on a cob",
  "Grows in tall stalks in fields",
  "Sweet vegetable with husks",
  "Golden corn ready for harvest",
  "Juicy corn kernels on the cob",
  "Corn silk hanging from the husk",
  "Rows of kernels on a green stalk",
  "Corn ears wrapped in leaves",
  
  "Red apple growing on a tree",
  "Green leaves on a bush",
  "Orange carrot in the ground",
  "Purple grapes on a vine",
  "Brown potato from the soil",
  "Yellow banana in a bunch",
  "Red tomato on the vine",
  "Green broccoli florets"
)

labels <- factor(c(rep("corn", 8), rep("not corn", 8)))

# Train the SVM model using ksvm with stringdot kernel
svm_model <- ksvm(descriptions, labels,
                  kernel = "stringdot",
                  kpar = list(length = 4, lambda = 0.5),
                  C = 1)

#fitted value quick test 
predict(svm_model, descriptions)
```

     [1] corn     corn     corn     corn     corn     corn     corn     corn    
     [9] not corn not corn not corn not corn not corn not corn not corn not corn
    Levels: corn not corn

### test binding:

bind will require additional handlers for input since the dot expects
list input instead of formula + dataframe. . .

bound with x + y method, minimal wrapper is called “ksvm_stringdot”..
this is the underlying fcn now mapped to the svm_string_data set_fit
call.

``` r
# make a df input work with the ksvm S4 list method backend
df <- data.frame(
  description = unlist(descriptions),
  label  = labels
)


# spec
svm_string_spec <- 
  svm_string(cost = 1, margin = 0.1, length = 4, lambda = 0.5) |> 
  set_mode("classification") |>
  set_engine("kernlab")

# fit --
svm_cls_fit <- svm_string_spec |> fit(label ~ description, data = df)

svm_cls_fit
```

    parsnip model object

    Support Vector Machine object of class "ksvm" 

    SV type: C-svc  (classification) 
     parameter : cost C = 1 

    String kernel function.  Type =  spectrum 
     Hyperparameters : sub-sequence/string length =  4 
     Normalized 

    Number of Support Vectors : 16 

    Objective Function Value : -7.5065 
    Training error : 0 

predict check:

``` r
predict(svm_cls_fit, df, type = "class")
```

    # A tibble: 16 × 1
       .pred_class
       <fct>      
     1 corn       
     2 corn       
     3 corn       
     4 corn       
     5 corn       
     6 corn       
     7 corn       
     8 corn       
     9 not corn   
    10 not corn   
    11 not corn   
    12 not corn   
    13 not corn   
    14 not corn   
    15 not corn   
    16 not corn   
