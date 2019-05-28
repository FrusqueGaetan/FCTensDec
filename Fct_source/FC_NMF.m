function [F] = FC_NMF(T,K)

%Input : 
%T tensor to reduce
%K number of factor

%method 3 : NMF
T(T<0) = 0; %Eliminate negative value (as we know it corresponds to noise)

X = FC_Direct(T); %1Mode Matricized tensor X_(1)
[F,~] = nnmf(X,K);



end