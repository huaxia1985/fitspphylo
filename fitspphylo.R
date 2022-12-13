fitspphylo <- function (formula,data,spmatrix,phylomatrix,p) {
  cal <- function (p,formula,data,spmatrix,phylomatrix) {
    spmatrix <- spmatrix/max(spmatrix)
    spmatrix <- exp(-(spmatrix/p[2])^2)
    mat <- as.matrix((p[3]*(1-p[1])*spmatrix+(1-p[1])*(1-p[3])*phylomatrix+p[1]*diag(dim(phylomatrix)[1])))
    res <- try(gls(model=formula,data=data,correlation=corSymm(mat[lower.tri(mat)],fixed=T),method="ML"),silent=T)
    if (inherits(res,"try-error")) {
      out <- -10000
    } else {
      out <- res$logLik
      if (res$logLik>0) {out <- -10000}
    }
    -out
  }
  cal2 <- function (p,formula,data,spmatrix,phylomatrix) {
    spmatrix <- spmatrix/max(spmatrix)
    spmatrix <- exp(-(spmatrix/p[2])^2)
    mat <- as.matrix((p[3]*(1-p[1])*spmatrix+(1-p[1])*(1-p[3])*phylomatrix+p[1]*diag(dim(phylomatrix)[1])))
    res <- try(gls(model=formula,data=data,correlation=corSymm(mat[lower.tri(mat)],fixed=T),method="ML"),silent=T)
    res
  }
  library(nloptr)
  library(nlme)
  p.res <- sbplx(p,cal,formula=formula,data=data,spmatrix=spmatrix,phylomatrix=phylomatrix,lower=c(0,0,0),upper=c(1,1,1))
  lm.res <- cal2(p=p.res$par,formula=formula,data=data,spmatrix=spmatrix,phylomatrix=phylomatrix)
  list(p.res=p.res,lm.res=lm.res)
}
