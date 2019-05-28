function [F,V] = FC_HOsSVD(T,K,lambda1,lambda2,iter)

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

if (mean(Ut{3})<0)
Ut{3} = -W';
end


for i =1:iter
    
   M = ttv(A,Ut{3}',3);
   [F,V] = FC_sSVD(M.data,K,lambda1,lambda2);
   [qqv,~] = qr(V);
   Ut{2} = qqv(:,1:K)';
   [qq,~]= qr(F);
   Ut{1} = qq(:,1:K)';
   Utilde = ttm(A, Ut, -3); 
  
   
   
   
   [W, ~, ~] = ... 
   svds(double(tenmat(Utilde,3)), 1); 

   CosTheta = abs(acosd(dot(abs(W'),abs(Ut{3}))/(norm(W')*norm(Ut{3}))));

   Ut{3} = W'; 
   if (mean(Ut{3})<0)
   Ut{3} = -W';
   end


   if(CosTheta < 0.001)
      break
   end


end



end