# fitspphylo
function to fit a model using GLS and account for spatial and phylogenetic autocorrelation

## Inputs:
1. formula: the regression model formula y~x1+x2.
2. data: each row is the dependent and the independent variables of a grid
3. spmatrix: diagonal is 0 and the ij-th offdiagonal is geographic distance between grid i and grid j, assuming Gaussian decrease in spatial autocorrelation; 
4. phylomatrix: diagnal is 1; the ij-th offdiagnal is the shared amount of tree path between grid i and grid j/#the total amount of tree path in grid i and grid j
5. p: starting value for maximization, p[1] is the contribution of spatial and phylogenetic autocorrelation, p[2] is the scaling factor to model spatial autocorrelation, the smaller p[2] is , the faster spatial autocorrelation decreases with spatial distance, p[3] is the relative contribution of spatial versus phylogenetic autocorrelation. 

## Outputs:
output is a list of:
1. $p.res: the best fit parameters for p
2. $lm.res: this custom code used gls as the basic regression method, so any relative code to gls is also applicable to the result, which is in lm.res.
