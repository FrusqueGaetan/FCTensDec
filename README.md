# FCTensDec
Matlab algorithms from "Sparse tensor dimensionality reduction with application to clustering functional connectivity"

First you need to download MATLAB Tensor Toolbox Version 2.6 and SPAMS toolbox respectively Here :


http://spams-devel.gforge.inria.fr/


https://www.sandia.gov/~tgkolda/TensorToolbox/index-2.6.html


And put both toolbox in the library file, N-way toolbox is optional


FCMain_model_comparison : Show results from part IV adn V 
FCMain_seizure_application : Show results from part VI

In FC_source, a list of usefull function such as FC_"Method"(T,K,varargin) where Method can be Direct, Mean, NMF, nnCP, SVD, mHOOI, sSVD, HOsSVD
T is the tensor to decompose
K is the number of factor in F
varargin corresponds to lambda1 and lambda2 for sparse methods



thanks for your interest
