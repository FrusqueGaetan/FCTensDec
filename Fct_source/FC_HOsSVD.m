function [F,V,W] = FC_HOsSVD(T,K,lambda1,lambda2,iter)

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

if (mean(Ut{3})<0)%Optional, due to the sign incertainty of the SVD in matlab [U,Lambda,V] = SVD(X),
    %U and V or -V and -U are solutions
Ut{3} = -W';
end


for i =1:iter
   %Step A 
   M = ttv(A,Ut{3}',3);
   if i>1
   [F,V] = FC_sSVD(M.data,K,lambda1,lambda2,F,V);
   else
   [F,V] = FC_sSVD(M.data,K,lambda1,lambda2,M);   
   end
   
  %Step B 
    Ov2=ones(1,K);
    Filt = krb(V,F)*Ov2';
    FM = double(tenmat(A,3))*Filt;
    W= FM./norm(FM,'fro');

  %angular metric
   CosTheta = abs(acosd(dot(abs(W'),abs(Ut{3}))/(norm(W')*norm(Ut{3}))));
   
   Ut{3} = W'; 
   if (mean(Ut{3})<0)%Optional, due to the sign incertainty of the SVD in matlab [U,Lambda,V] = SVD(X),
    %U and V or -V and -U are solutions
   Ut{3} = -W';
   end

   
   
   if(CosTheta < 0.001)
      break
   end


end



end

function AB = krb(A,B);
%KRB Khatri-Rao product
%
% The columnwise Khatri-Rao-Bro product (Harshman, J.Chemom., 2002, 198-205)
% For two matrices with similar column dimension the khatri-Rao-Bro product
% is krb(A,B) = [kron(A(:,1),B(:,1)) .... kron(A(:,F),B(:,F))]
% 
% I/O AB = krb(A,B);
%

% Copyright (C) 1995-2006  Rasmus Bro & Claus Andersson
% Copenhagen University, DK-1958 Frederiksberg, Denmark, rb@life.ku.dk
%

% $ Version 1.02 $ Date 28. July 1998 $ Not compiled $
% $ Version 2.00 $ May 2001 $ Changed to array notation $ RB $ Not compiled $
% $ Version 2.01 $ May 2001 $ Error in helpfile - A and B reversed $ RB $ Not compiled $

[I,F]=size(A);
[J,F1]=size(B);

if F~=F1
   error(' Error in krb.m - The matrices must have the same number of columns')
end

AB=zeros(I*J,F);
for f=1:F
   ab=B(:,f)*A(:,f).';
   AB(:,f)=ab(:);
end
end


