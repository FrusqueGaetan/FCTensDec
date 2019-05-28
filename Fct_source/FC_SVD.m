function [F] = FC_SVD(T,K)

%Input : 
%T tensor to reduce
%K number of factor

%method 5 : SVD

X = FC_Direct(T); %1Mode Matricized tensor X_(1)
[U,l,~] = svds(X,K);
F = U*l; 




end