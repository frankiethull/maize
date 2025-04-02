make_ada_boost_svm_rbf <- function() {

  parsnip::set_new_model("ada_boost_svm_rbf")

  parsnip::set_model_mode("ada_boost_svm_rbf", "classification")

  # ------------------------------------------------------------------------------

  parsnip::set_model_engine("ada_boost_svm_rbf", "classification", "ebmc")
  parsnip::set_dependency("ada_boost_svm_rbf", "ebmc", "ebmc")
  parsnip::set_dependency("ada_boost_svm_rbf", "ebmc", "maize")

  parsnip::set_model_arg(
    model = "ada_boost_svm_rbf",
    eng = "ebmc",
    parsnip = "num_learners",
    original = "size",
    func = list(pkg = "maize", fun = "num_learners", range = c(1, 20)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "ada_boost_svm_rbf",
    eng = "ebmc",
    parsnip = "imb_ratio",
    original = "ir",
    func = list(pkg = "maize", fun = "imb_ratio", range = c(1, 2)),
    has_submodel = FALSE
  )

  parsnip::set_fit(
    model = "ada_boost_svm_rbf",
    eng = "ebmc",
    mode = "classification",
    value = list(
      interface = "formula",
      data = c(formula = "formula", data = "data"),
      protect = c("formula", "data"),
      func = c(pkg = "ebmc", fun = "rus"),
      defaults = list(alg = "svm", svm.ker = "radial")
    )
  )

  parsnip::set_encoding(
    model = "ada_boost_svm_rbf",
    eng = "ebmc",
    mode = "classification",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )


  parsnip::set_pred(
    model = "ada_boost_svm_rbf",
    eng = "ebmc",
    mode = "classification",
    type = "class",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "ebmc", fun = "predict.modelBst"),
      args =
        list(
          object = quote(object$fit),
          newdata = quote(new_data),
          type = "class"
        )
    )
  )

  parsnip::set_pred(
    model = "ada_boost_svm_rbf",
    eng = "ebmc",
    mode = "classification",
    type = "prob",
    value = list(
      pre = NULL,
      post = function(result, object) as_tibble(result),
      func = c(pkg = "ebmc", fun = "predict.modelBst"),
      args =
        list(
          object = quote(object$fit),
          newdata = quote(new_data),
          type = "prob"
        )
    )
  )

  parsnip::set_pred(
    model = "ada_boost_svm_rbf",
    eng = "ebmc",
    mode = "classification",
    type = "raw",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "ebmc", fun = "predict.modelBst"),
      args = list(object = quote(object$fit), newdata = quote(new_data))
    )
  )
}
