function [F] = FC_mHOOI(T,K,iter)

%Input : 
%T tensor to reduce
%K number of factor

%method 5 : SVD

if ~exist('iter') 
iter = 30;
end 
 

A = tensor(T);
[W, ~, ~] = svds(double(tenmat(A,3)), 1); 
Ut{3} = W';
for i =1:iter
    
   M = ttv(A,Ut{3}',3);
   [U,l,V] = svds(M.data,K);
   F = U*l;
   Ut{2} = V';
   Ut{1} = U';
   Utilde = ttm(A, Ut, -3); 
   [W, ~, ~] = ... 
   svds(double(tenmat(Utilde,3)), 1); 

   CosTheta = abs(acosd(dot(W',Ut{3})/(norm(W')*norm(Ut{3}))));
   Ut{3} = W'; 

   if(CosTheta < 0.001)
      break
   end


end

end