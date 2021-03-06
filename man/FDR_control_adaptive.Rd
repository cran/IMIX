% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FDR_control_adaptive.R
\name{FDR_control_adaptive}
\alias{FDR_control_adaptive}
\title{The Adaptive Procedure for Across-Data-Type FDR Control}
\usage{
FDR_control_adaptive(lfdr, alpha)
}
\arguments{
\item{lfdr}{Local FDR for each gene of the mixture model results for one component or a combination of components}

\item{alpha}{Prespecified FDR control level}
}
\value{
The estimated mFDR for the target component or component combinaitons and whether the genes is classified in this component/combination after FDR control at alpha level, 1 is yes, 0 is no.
\item{significant_genes_with_FDRcontrol}{The output of each gene ordered by the components based on FDR control and within each component ordered by the local FDR, "localFDR" is 1-posterior probability of each gene in the component based on the maximum posterior probability, "class_withoutFDRcontrol" is the classified component based on maximum posterior probability, "class_FDRcontrol" is the classified component based on the across-data-type FDR control at alpha level}
\item{estimatedFDR}{The estimated marginal FDR value for each component starting from component 2 (component 1 is the global null)}
\item{alpha}{Prespecified nominal level for the across-data-type FDR control}
}
\description{
The adaptive procedure for across-data-type FDR control based on the output from IMIX models, this can be directly performed by IMIX function, however, if the user is interested in other mixture models, alpha level or combinations of components, this function would be useful.
}
\examples{
\donttest{
# First load the data
data("data_p")

# Specify inititial values (this step could be omitted)
mu_input <- c(0,3,0,3)
sigma_input <- rep(1,4)
p_input <- rep(0.5,4)
test1 <- IMIX(data_input = data_p,data_type = "p",mu_ini = mu_input,sigma_ini = sigma_input,
p_ini = p_input,alpha = 0.1,model_selection_method = "AIC")

# Check the selected model based on AIC value
test1$`Selected Model`

# Below is an example for data example 1 in controlling 
# the FDR at 0.2 for component 2 & component 4. 
# First calculate the local FDR for component 2 & component 4:
lfdr_ge_combined <- 1 - (test1$IMIX_cor_twostep$`posterior prob`[,2] + 
test1$IMIX_cor_twostep$`posterior prob`[,4])  # Class 2: (ge+,cnv-); class 4: (ge+,cnv+)
names(lfdr_ge_combined) <- rownames(test1$IMIX_cor_twostep$`posterior prob`)

# Perform the across-data-type FDR control for component 2 & component 4 at alpha level 0.2
fdr_control1 <- FDR_control_adaptive(lfdr = lfdr_ge_combined, alpha = 0.2)
}
}
\references{
Ziqiao Wang and Peng Wei. 2020. “IMIX: a multivariate mixture model approach to association analysis through multi-omics data integration.” Bioinformatics. <doi:10.1093/bioinformatics/btaa1001>.
}
