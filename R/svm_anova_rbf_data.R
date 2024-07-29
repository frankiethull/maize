make_svm_anova_rbf <- function() {

  parsnip::set_new_model("svm_anova_rbf")

  parsnip::set_model_mode("svm_anova_rbf", "classification")
  parsnip::set_model_mode("svm_anova_rbf", "regression")

  # ------------------------------------------------------------------------------

  parsnip::set_model_engine("svm_anova_rbf", "classification", "kernlab")
  parsnip::set_model_engine("svm_anova_rbf", "regression", "kernlab")
  parsnip::set_dependency("svm_anova_rbf", "kernlab", "kernlab")
  parsnip::set_dependency("svm_anova_rbf", "kernlab", "maize")

  parsnip::set_model_arg(
    model = "svm_anova_rbf",
    eng = "kernlab",
    parsnip = "cost",
    original = "C",
    func = list(pkg = "dials", fun = "cost", range = c(-10, 5)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "svm_anova_rbf",
    eng = "kernlab",
    parsnip = "degree",
    original = "degree",
    func = list(pkg = "dials", fun = "degree_int"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "svm_anova_rbf",
    eng = "kernlab",
    parsnip = "rbf_sigma",
    original = "sigma",
    func = list(pkg = "dials", fun = "rbf_sigma"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "svm_anova_rbf",
    eng = "kernlab",
    parsnip = "margin",
    original = "epsilon",
    func = list(pkg = "dials", fun = "svm_margin"),
    has_submodel = FALSE
  )

  parsnip::set_fit(
    model = "svm_anova_rbf",
    eng = "kernlab",
    mode = "regression",
    value = list(
      interface = "formula",
      data = c(formula = "x", data = "data"),
      protect = c("x", "data"),
      func = c(pkg = "kernlab", fun = "ksvm"),
      defaults = list(kernel = "anovadot")
    )
  )

  parsnip::set_encoding(
    model = "svm_anova_rbf",
    eng = "kernlab",
    mode = "regression",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )

  parsnip::set_fit(
    model = "svm_anova_rbf",
    eng = "kernlab",
    mode = "classification",
    value = list(
      interface = "formula",
      data = c(formula = "x", data = "data"),
      protect = c("x", "data"),
      func = c(pkg = "kernlab", fun = "ksvm"),
      defaults = list(kernel = "anovadot")
    )
  )

  parsnip::set_encoding(
    model = "svm_anova_rbf",
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
    model = "svm_anova_rbf",
    eng = "kernlab",
    mode = "regression",
    type = "numeric",
    value = list(
      pre = NULL,
      post = \(results, object) {
        results[,1]
      },
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
    model = "svm_anova_rbf",
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

  parsnip::set_pred(
    model = "svm_anova_rbf",
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
    model = "svm_anova_rbf",
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
    model = "svm_anova_rbf",
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
