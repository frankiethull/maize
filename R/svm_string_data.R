
make_svm_string <- function() {

  parsnip::set_new_model("svm_string")

  parsnip::set_model_mode("svm_string", "classification")

  # ------------------------------------------------------------------------------

  parsnip::set_model_engine("svm_string", "classification", "kernlab")
  parsnip::set_dependency("svm_string", "kernlab", "kernlab")
  parsnip::set_dependency("svm_string", "kernlab", "maize")

  parsnip::set_model_arg(
    model = "svm_string",
    eng = "kernlab",
    parsnip = "cost",
    original = "C",
    func = list(pkg = "dials", fun = "cost", range = c(-10, 5)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "svm_string",
    eng = "kernlab",
    parsnip = "length",
    original = "length",
    func = list(pkg = "dials", fun = "length"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "svm_string",
    eng = "kernlab",
    parsnip = "lambda",
    original = "lambda",
    func = list(pkg = "dials", fun = "lambda"),
    has_submodel = FALSE
  )

  # TODO there are a few different stringdot 'types'
  # consider stringdot(type =...), not the ksvm(type =...)
  # parsnip::set_model_arg(
  #   model = "svm_string",
  #   eng = "kernlab",
  #   parsnip = "type",
  #   original = "type",
  #   has_submodel = FALSE
  # )

  parsnip::set_model_arg(
    model = "svm_string",
    eng = "kernlab",
    parsnip = "normalized",
    original = "normalized",
    func = list(pkg = "dials", fun = "normalized"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "svm_string",
    eng = "kernlab",
    parsnip = "margin",
    original = "epsilon",
    func = list(pkg = "dials", fun = "svm_margin"),
    has_submodel = FALSE
  )


  parsnip::set_fit(
    model = "svm_string",
    eng = "kernlab",
    mode = "classification",
    value = list(
      interface = "data.frame",
      protect = c("x", "y"),
      func = c(pkg = "maize", fun = "ksvm_stringdot"),
      defaults = list(shrinking = TRUE, fit = TRUE)
    )
  )

  parsnip::set_encoding(
    model = "svm_string",
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
    model = "svm_string",
    eng = "kernlab",
    mode = "classification",
    type = "class",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "maize", fun = "predict_ksvm_stringdot_class"),
      args =
        list(
          object = quote(object),
          new_data = quote(new_data)
        )
    )
  )

  parsnip::set_pred(
    model = "svm_string",
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
    model = "svm_string",
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
