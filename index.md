---
layout: default
---
# Associated publication #

Codes from the article : \
**Multiplex network inference with sparse tensor decomposition for functional connectivity** [[pdf]](../Support/IEEE-T-SIPN.pdf) [[hal]](https://hal.inria.fr/hal-02531459/file/IEEE-T-SIPN.pdf)\
Gaëtan Frusque, Julien Jung, Pierre Borgnat, Paulo Gonçalves,
IEEE transaction T-SIPN, 03-2020

# Desciption #

We provide the necessary code to remake to experiments from the article.

You need first to download these toolboxes:

* [SPAMS Toolbox](http://spams-devel.gforge.inria.fr/)

* [Tensor Toolbox Version 2.6](https://www.sandia.gov/~tgkolda/TensorToolbox/index-2.6.html)

The methods implemented in this library to perform dimensionality reduction are : 

1) Non Negative matrix Factorisation (NMF)

2) Non Negative Canonical Polyadic decomposition (nnCP)

3) Singular Value Decomposition (SVD)

4) Higher Order Singular Value Decomposition (HOSVD)

5) Sparse Singular Value Decomposition (sSVD)

6) Higher Order Sparse Mode Reduction (HOSMR)

# Overview of the codes provided #

[FCMain_model_comparison.m](./FCMain_model_comparison.m): Main code to remake the experiment from the article. This file is divided in five parts. I) Show results from the paper from the dataset [Results.mat](./Data/Results.mat). II) Build your own experiment using the model from the paper to compare all methods. III) & IV) Perform the full experiment from the paper. V) Experiment from the appendix B.

Beside implementations of the dimensionality reduction methods, this main use the following function:

* [FC_Model.m](./Fct_source/FC_Model.m): Creates the FC model in the form of a tensor of size 66 x 1000 x **NbSeizure**. The arguments are **NbSeizure**, **b** the noise vector and **Ptheo** the groud truth clustering (can be modified). 
* [FC_ScoreExp.m](./Fct_source/FC_ScoreExp.m): Performs the k-means clustering from the reduced FC factor matrix **F** and computes the ARI score between the experimental clustering and the ground truth clustering.
* [FC_showResults.m](./Fct_source/FC_howResults.m): Shows results with boxplots in a similar fashion than in the paper.

[FCMain_seizure_application.m](./FCMain_seizure_application.m): Show results using HOSMR method to discover subgraph of FC caracterising the different events of a seizure. 

All 6 methods are named respectively [FC_NMF.m](./Fct_source/FC_NMF.m), [FC_nnCP.m](./Fct_source/FC_nnCP.m), [FC_SVD.m](./Fct_source/FC_SVD.m), [FC_mHOOI.m](./Fct_source/FC_mHOOI.m) (for the HOSVD), [FC_sSVD.m](./Fct_source/FC_sSVD.m), [FC_HOSMR.m](./Fct_source/FC_HOSMR.m). Their arguments are respectively:
* **T** the dataset presented in the form of a tensor
* **K** the number of factor wanted for the reduction
* **lambda1**, **lambda2** (for sSVD and HOSMR), regularisation parameters. 

Thank you for your interest. 




