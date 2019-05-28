function [F,score] = FC_mHOOIscore(T,K,iter)

%Input : 
%T tensor to reduce
%K number of factor

%method 5 : SVD

if ~exist('iter') 
iter = 100;
end 
 

A = tensor(T);
score = zeros(iter+1,1);
R = [K,K,1];
for n = 1:3 
    
[U, ~, ~] = ... 
svds(double(tenmat(A,n)), R(n)); 
Ut{n} = U'; 
end 
lambda = ttm(A, Ut); 
score(1) = norm(double(lambda),'fro')^2;
for i =1:iter
    
   M = ttv(A,Ut{3}',3);
   [U,l,V] = svds(M.data,K);
   F = U*l;
   Ut{2} = V';
   Ut{1} = U';
   Utilde = ttm(A, Ut, -3); 
   [W, ~, ~] = ... 
   svds(double(tenmat(Utilde,3)), 1); 

%   CosTheta = abs(acosd(dot(W',Ut{3})/(norm(W')*norm(Ut{3}))));
   Ut{3} = W';  
score(i+1) = norm(F,'fro')^2;



end

end