%Main_seizure_application
addpath('Data')
addpath(genpath('Library'))
addpath('Fct_source')

load PLVseizure.mat
load location.mat

[F,V]=FC_HOsSVD(TT,4,1,1);%Compute reduction


A = FC_assignment(F,5);%Compute cluster

supp  = sum(A) == max(sum(A));
Cfc = A(:,(1-supp)==1); %Suppress unactivated FC cluster

Match = Cfc'*F; %Assign position 
[~,pos] = max(Match,[],2);
F = F(:,pos);
V = V(:,pos);

FC_showNetwork(Position,Cfc,V)


