function C = FC_assignment(F,N)

[a] = kmeans(F,N,'replicate',100,'MaxIter',1000);

C = zeros(length(a),N);%Create the assignment matrix
for i = 1:N
    C(:,i) = a == i;   
end


end