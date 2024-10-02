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

bind may require additional handlers for input since the dot expects
list input instead of formula + dataframe. . .
