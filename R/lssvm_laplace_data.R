make_lssvm_laplace <- function() {

  parsnip::set_new_model("lssvm_laplace")

  parsnip::set_model_mode("lssvm_laplace", "classification")

  # ------------------------------------------------------------------------------

  parsnip::set_model_engine("lssvm_laplace", "classification", "kernlab")
  parsnip::set_dependency("lssvm_laplace", "kernlab", "kernlab")
  parsnip::set_dependency("lssvm_laplace", "kernlab", "maize")



  parsnip::set_model_arg(
    model = "lssvm_laplace",
    eng = "kernlab",
    parsnip = "laplace_sigma",
    original = "sigma",
    func = list(pkg = "dials", fun = "svm_margin"),
    has_submodel = FALSE
  )


  parsnip::set_fit(
    model = "lssvm_laplace",
    eng = "kernlab",
    mode = "classification",
    value = list(
      interface = "formula",
      data = c(formula = "x", data = "data"),
      protect = c("x", "data"),
      func = c(pkg = "kernlab", fun = "lssvm"),
      defaults = list(kernel = "laplacedot")
    )
  )

  parsnip::set_encoding(
    model = "lssvm_laplace",
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
    model = "lssvm_laplace",
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
    model = "lssvm_laplace",
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
    model = "lssvm_laplace",
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
