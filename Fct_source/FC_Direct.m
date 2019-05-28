function [F] = FC_Direct(T)

%Input : 
%T tensor to reduce

%method 1 : Direct

S = size(T);
F = reshape(T,S(1),S(2)*S(3));

end