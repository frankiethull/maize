make_misvm_orova_rbf <- function() {

  parsnip::set_new_model("misvm_orova_rbf")

  parsnip::set_model_mode("misvm_orova_rbf", "classification")

  # ------------------------------------------------------------------------------

  parsnip::set_model_engine("misvm_orova_rbf", "classification", "mildsvm")
  parsnip::set_dependency("misvm_orova_rbf", "mildsvm", "mildsvm")
  parsnip::set_dependency("misvm_orova_rbf", "mildsvm", "maize")

  parsnip::set_model_arg(
    model = "misvm_orova_rbf",
    eng = "mildsvm",
    parsnip = "cost",
    original = "cost",
    func = list(pkg = "dial", fun = "cost", range = c(1, 20)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "misvm_orova_rbf",
    eng = "mildsvm",
    parsnip = "rbf_sigma",
    original = "sigma",
    func = list(pkg = "dials", fun = "rbf_sigma"),
    has_submodel = FALSE
  )

  parsnip::set_fit(
    model = "misvm_orova_rbf",
    eng = "mildsvm",
    mode = "classification",
    value = list(
      interface = "formula",
      data = c(formula = "formula", data = "data"),
      protect = c("formula", "data"),
      func = c(pkg = "maize", fun = "misvm_orova_fit_spec"),
      defaults = list(NULL)
    )
  )

  parsnip::set_encoding(
    model = "misvm_orova_rbf",
    eng = "mildsvm",
    mode = "classification",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )


  parsnip::set_pred(
    model = "misvm_orova_rbf",
    eng = "mildsvm",
    mode = "classification",
    type = "class",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "maize", fun = "misvm_predict_spec"),
      args =
        list(
          object = quote(object$fit),
          new_data = quote(new_data),
          type = "class"
        )
    )
  )

  # only "class" and "raw" in mildsvm
  # parsnip::set_pred(
  #   model = "misvm_orova_rbf",
  #   eng = "mildsvm",
  #   mode = "classification",
  #   type = "prob",
  #   value = list(
  #     pre = NULL,
  #     post = function(result, object) as_tibble(result),
  #     func = c(pkg = "maize", fun = "misvm_predict_spec"),
  #     args =
  #       list(
  #         object = quote(object$fit),
  #         new_data = quote(new_data),
  #         type = "prob"
  #       )
  #   )
  # )

  parsnip::set_pred(
    model = "misvm_orova_rbf",
    eng = "mildsvm",
    mode = "classification",
    type = "raw",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "maize", fun = "misvm_predict_spec"),
      args = list(object = quote(object$fit), new_data = quote(new_data), type = "raw")
    )
  )
}
