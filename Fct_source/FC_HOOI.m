function [F] = FC_HOOI(T,K)

%Use of the HOOI algorithm provided by Kolda


[Tn] = hooi(T,[K,K,1]);

F = Tn{2}*Tn{1};

end


function B = hooi(A,R,kmax) 
A = tensor(A); 
N = ndims(A); 
% Default value 
if ~exist('kmax','var') 
kmax = 100; 
end 
% Compute an orthonormal basis for the dominant 
% Rn-dimensional left singular subspace of 
% A_(n) (1 <= n <= N). We store its transpose. 
for n = 1:N 
    
[U, ~, ~] = ... 
svds(double(tenmat(A,n)), R(n)); 
Ut{n} = U'; 
end 
% Iterate until convergence 
for k = 1:kmax 
    
for n = 1:N 
Utilde = ttm(A, Ut, -n); 
% Maximize norm(Utilde x_n W?) wrt W and 
% keeping orthonormality of W 
[W,~,~] = ... 
svds(double(tenmat(Utilde, n)), R(n)); 
Ut{n} = W'; 
end 
end 
% Create the core array 
lambda = ttm(A, Ut); 
% Create cell array containing U from the cell 
% array containing its transpose 
for n = 1:N 
B{n+1} = Ut{n}'; 
end 
% Assemble the resulting tensor 
B{1} = double(lambda);
%B = ttensor(lambda, OO);
end