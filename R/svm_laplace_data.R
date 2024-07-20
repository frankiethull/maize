make_svm_laplace <- function() {

  parsnip::set_new_model("svm_laplace")

  parsnip::set_model_mode("svm_laplace", "classification")
  parsnip::set_model_mode("svm_laplace", "regression")

# ------------------------------------------------------------------------------

  parsnip::set_model_engine("svm_laplace", "classification", "kernlab")
  parsnip::set_model_engine("svm_laplace", "regression", "kernlab")
  parsnip::set_dependency("svm_laplace", "kernlab", "kernlab")

  parsnip::set_model_arg(
    model = "svm_laplace",
    eng = "kernlab",
    parsnip = "cost",
    original = "C",
    func = list(pkg = "dials", fun = "cost", range = c(-10, 5)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "svm_laplace",
    eng = "kernlab",
    parsnip = "margin",
    original = "epsilon",
    func = list(pkg = "dials", fun = "svm_margin"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "svm_laplace",
    eng = "kernlab",
    parsnip = "laplace_sigma",
    original = "sigma",
    func = list(pkg = "dials", fun = "svm_margin"),
    has_submodel = FALSE
  )

  parsnip::set_fit(
    model = "svm_laplace",
    eng = "kernlab",
    mode = "regression",
    value = list(
     interface = "formula",
     data = c(formula = "x", data = "data"),
      protect = c("x", "data"),
      func = c(pkg = "kernlab", fun = "ksvm"),
      defaults = list(kernel = "laplacedot") 
    )
  )

  parsnip::set_fit(
   model = "svm_laplace",
   eng = "kernlab",
   mode = "classification",
   value = list(
     interface = "formula",
      data = c(formula = "x", data = "data"),
     protect = c("x", "data"),
     func = c(pkg = "kernlab", fun = "ksvm"),
     defaults = list(kernel = "laplacedot") 
    )
  )

  parsnip::set_encoding(
   model = "svm_laplace",
   eng = "kernlab",
   mode = "regression",
   options = list(
     predictor_indicators = "none",
     compute_intercept = FALSE,
     remove_intercept = FALSE,
     allow_sparse_x = FALSE
    )
  )

  svm_reg_post <- function(results, object) {
   results[,1]
  }
  parsnip::set_pred(
    model = "svm_laplace",
    eng = "kernlab",
    mode = "regression",
    type = "numeric",
    value = list(
     pre = NULL,
     post = svm_reg_post,
     func = c(pkg = "kernlab", fun = "predict"),
     args =
       list(
         object = quote(object$fit),
         newdata = quote(new_data),
         type = "response"
       )
   )
  )

  parsnip::set_pred(
    model = "svm_laplace",
    eng = "kernlab",
    mode = "regression",
    type = "raw",
    value = list(
     pre = NULL,
     post = NULL,
     func = c(pkg = "kernlab", fun = "predict"),
     args = list(object = quote(object$fit), newdata = quote(new_data))
    )
  )

  parsnip::set_encoding(
    model = "svm_laplace",
    eng = "kernlab",
    mode = "classification",
    options = list(
     predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )

  parsnip::set_pred(
    model = "svm_laplace",
    eng = "kernlab",
    mode = "classification",
    type = "class",
    value = list(
     pre = NULL,
     post = NULL,
     func = c(pkg = "kernlab", fun = "predict"),
     args =
        list(
          object = quote(object$fit),
          newdata = quote(new_data),
          type = "response"
       )
    )
  )

  parsnip::set_pred(
    model = "svm_laplace",
    eng = "kernlab",
    mode = "classification",
    type = "prob",
    value = list(
      pre = NULL,
      post = function(result, object) as_tibble(result),
      func = c(pkg = "kernlab", fun = "predict"),
      args =
        list(
          object = quote(object$fit),
          newdata = quote(new_data),
          type = "probabilities"
        )
    )
  )

  parsnip::set_pred(
    model = "svm_laplace",
    eng = "kernlab",
    mode = "classification",
    type = "raw",
    value = list(
     pre = NULL,
     post = NULL,
     func = c(pkg = "kernlab", fun = "predict"),
     args = list(object = quote(object$fit), newdata = quote(new_data))
    )
  )
}
