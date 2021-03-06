% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/map.R
\name{InvestMap}
\alias{InvestMap}
\title{Create InvestMap class}
\usage{
InvestMap(ratios = get_ratios(), criteria = "multiple", currency = NULL,
  topo_word)
}
\arguments{
\item{ratios}{data.table containing values to show}

\item{criteria}{character can be multiple or fmv}

\item{currency}{character EUR/USD}
}
\value{
An object of class \code{InvestMap}
}
\description{
\code{InvestMap} S3 class repensents data used of to create a amp of investments
}
\examples{
InvestMap()
}

