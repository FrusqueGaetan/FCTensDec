function [F] = FC_Mean(T)

%Input : 
%T tensor to reduce
%K number of factor

%method 2 : Mean

F = mean(T,3);

end