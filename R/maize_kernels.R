# 'all the kernels will belong to maize'
# these are custom kernels that are compatible with `kernlab` then bound to `maize`
# cauchy -----------------------------------------------------------------------
cauchydot <- function(x, y, sigma = 1) {
  #  """
  #    Cauchy kernel,
  #
  #        K(x, y) = 1 / (1 + ||x - y||^2 / s ^ 2)
  #
  #  """
  distances <- sqrt(crossprod((x - y)^2))
  return(1 / (1 + distances^2 / sigma^2))
}
class(cauchydot) <- "kernel"

# cossim -----------------------------------------------------------------------
cossimdot <- function(x, y){
  #    """
  #    Cosine similarity kernel,
  #
  #        K(x, y) = <x, y> / (||x|| ||y||)
  #
  #    """
  return(crossprod(x, y) / sqrt(crossprod(x) * crossprod(y)))
}
class(cossimdot) <- "kernel"
