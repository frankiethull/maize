# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#    'all the kernels belong to maize'
#       these are custom kernels
#      made compatible with `kernlab`
# added to `maize` with bindings to `parsnip`

# based on julia and python kernel implementations
# https://github.com/gmum/pykernels/blob/master/pykernels/regular.py
# https://juliagaussianprocesses.github.io/KernelFunctions.jl/stable/kernels/

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

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

# tanimoto ---------------------------------------------------------------------
tanimotodot <- function(x, y) {
  # """
  # Tanimoto kernel
  #     K(x, y) = <x, y> / (||x||^2 + ||y||^2 - <x, y>)
  #
  # as defined in:
  #
  # "Graph Kernels for Chemical Informatics"
  # Liva Ralaivola, Sanjay J. Swamidass, Hiroto Saigo and Pierre Baldi
  # Neural Networks
  # http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.92.483&rep=rep1&type=pdf
  # """

  # dot product calc
  dot_product <- sum(x * y)

  # ||x||^2 and ||y||^2
  norm_x_squared <- sum(x^2)
  norm_y_squared <- sum(y^2)

  # tanimoto kernel
  tanimoto <- dot_product / (norm_x_squared + norm_y_squared - dot_product)

  return(tanimoto)
}
class(tanimotodot) <- "kernel"

# sorensen ---------------------------------------------------------------------
sorsendot <- function(x, y) {
  # """
  # Sorensen kernel
  #     K(x, y) = 2 <x, y> / (||x||^2 + ||y||^2)
  #
  # as defined in:
  #
  # "Graph Kernels for Chemical Informatics"
  # Liva Ralaivola, Sanjay J. Swamidass, Hiroto Saigo and Pierre Baldi
  # Neural Networks
  # http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.92.483&rep=rep1&type=pdf
  # """
  # this one almost the same as tanimoto
  # dot product calc
  dot_product <- sum(x * y)

  # ||x||^2 and ||y||^2
  norm_x_squared <- sum(x^2)
  norm_y_squared <- sum(y^2)

  # sorensen kernel
  sorensen <- 2 * dot_product / (norm_x_squared + norm_y_squared)

  return(sorensen)
}
class(sorsendot) <- "kernel"

# t-student --------------------------------------------------------------------
tstudentdot <- function(x, y, degree = 1){
  # """
  # T-Student kernel,
  #
  #     K(x, y) = 1 / (1 + ||x - y||^d)
  #
  # where:
  #     d = degree
  #
  # as defined in:
  # "Alternative Kernels for Image Recognition"
  # Sabri Boughorbel, Jean-Philippe Tarel, Nozha Boujemaa
  # INRIA - INRIA Activity Reports - RalyX
  # http://ralyx.inria.fr/2004/Raweb/imedia/uid84.html
  # """

  # distance between x and y
  dist <- sqrt(sum((x - y)^2))

  # kernel calculation
  tstudent <- 1 / (1 + dist^degree)

  return(tstudent)
}
class(tstudentdot) <- "kernel"

# wavelet ----------------------------------------------------------------------
waveletdot <- function(x, y, a = 1, c = 1, h = NULL) {
  # """
  #   Wavelet kernel,
  #
  #       K(x, y) = PROD_i h( (x_i-c)/a ) h( (y_i-c)/a )
  #
  #   or for c = None
  #
  #       K(x, y) = PROD_i h( (x_i - y_i)/a )
  #
  #   as defined in
  #   "Wavelet Support Vector Machine"
  #   Li Zhang, Weida Zhou, Licheng Jiao
  #   IEEE Transactions on System, Man, and Cybernetics
  #   http://ieeexplore.ieee.org/xpl/login.jsp?tp=&arnumber=1262479
  #   """

  # creating the default wavelet, but could be changed in user args
  if (is.null(h)) {
    h <- function(z) {
      cos(1.75 * z) * exp(-z^2 / 2)
    }
  }

  if (is.null(c)) {
    # when c is NULL
    diff <- (x - y) / a
    wavelet <- prod(h(diff))
  } else {
    # i think this is right
    diff_x <- (x - c) / a
    diff_y <- (y - c) / a
    wavelet <- prod(h(diff_x) * h(diff_y))
  }

  return(wavelet)
}
class(waveletdot) <- "kernel"

# fourier ----------------------------------------------------------------------
# oddly enough there is a fourierdot in the kernlab kernels but doesn't work
# i think it's missing a loop step after looking at pykernels

fourierdot <- function(x, y, sigma = 0.1) {
  #  """
  #    Fourier kernel
  #        K(x, y) = PROD_i (1-q^2)/(2(1-2q cos(x_i-y_i)+q^2))
  #  """

  # initializer
  kernel <- 1

  # i think this step was missing in kernlab
  for (i in 1:length(x)){
   numerator <- 1 - sigma^2
    denominator <- 2 * (1 - 2*sigma * cos(x[i] - y[i]) + sigma^2)
     kernel <- kernel * (numerator / denominator)
}
  return(kernel)
}
class(fourierdot) <- "kernel"
