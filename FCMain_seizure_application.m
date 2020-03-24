%Main_seizure_application
addpath('Data')
addpath(genpath('Library'))
addpath('Fct_source')

load PLVseizure.mat
load location.mat

[F,V,W]=FC_HOsSVD(TT,4,1,0.95);%Compute reduction


A = FC_assignment(F,5);%Compute cluster

supp  = sum(A) == max(sum(A));
Cfc = A(:,(1-supp)==1); %Suppress unactivated FC cluster

Match = Cfc'*F; %Assign position 
[~,pos] = max(Match,[],2);
F = F(:,pos);
V = V(:,pos);

FC_showNetwork(Position,Cfc,V)


% figure(1)
% subplot(221)
% imagesc(-TT(:,:,1))
% ylabel('FC','Fontsize',22)
% xlabel('times','Fontsize',22)
% subplot(222)
% imagesc(-TT(:,:,2))
% ylabel('FC','Fontsize',22)
% xlabel('times','Fontsize',22)
% subplot(223)
% imagesc(-TT(:,:,3))
% ylabel('FC','Fontsize',22)
% xlabel('times','Fontsize',22)
% subplot(224)
% imagesc(-TT(:,:,4))
% ylabel('FC','Fontsize',22)
% xlabel('times','Fontsize',22)
% colormap('pink')
% figure(2)
% imagesc(-F*V')
% ylabel('FC','Fontsize',22)
% xlabel('times','Fontsize',22)
% colormap('pink')