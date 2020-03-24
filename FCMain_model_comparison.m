%Main_model_comparison
%1 Show results from paper
%2 Perform your own comparison using a specific noise configuration
%3 Complete experiment
%4 Retrieve the results of the complete experience
%5 Appendix b results

%prerequisites
addpath('Data')
addpath(genpath('Library'))
addpath('Fct_source')


%%%I
%%%
%%%

%Show results from paper

%%%
%%%
%%%

load Results.mat %Presented as Results
load bNoiseVector.mat %Presented as b

view = 1:15; %select here experimental results you want to see Ex : view = [7,9] or 1:6
fg = FC_showResults(Results,b,view);

%%%II
%%%
%%%

%Perform your own comparison using a specific noise configuration

%%%
%%%
%%%Comment the "if 0" to use this part

if 0
load Ptheo.mat
NbSeizure = 4; %Select number of seizure
myb = [1,0.2,1.5,0.3]; %Noise vector : a- Duration ucnertainty 0 or 1, b- Activation error
% c- Gaussian noise (power), d- Jitter as explained in the paper
myP = Ptheo; %You can create your own cluster pattern (with 4 different clusters)


FactorVector = 1:4; %Number of factor K, we take here the best clustering from K= 1,2,3 or 4.
NbRepetition = 10; %Number of repetition

ResultFC = zeros(8,length(FactorVector),1,NbRepetition );
for i = 1:NbRepetition
    T = FC_Model(NbSeizure, myb, Ptheo);
        for j =1:length(FactorVector)
                ResultFC(1,j,1,i) = FC_ScoreExp(FC_Direct(T),myP);%1
                ResultFC(2,j,1,i) = FC_ScoreExp(FC_Mean(T),myP);%2
                ResultFC(3,j,1,i) = FC_ScoreExp(FC_NMF(T,FactorVector(j)),myP);%3
                ResultFC(4,j,1,i) = FC_ScoreExp(FC_nnCP(T,FactorVector(j)),myP);%4
                ResultFC(5,j,1,i) = FC_ScoreExp(FC_SVD(T,FactorVector(j)),myP);%5
                ResultFC(6,j,1,i) = FC_ScoreExp(FC_mHOOI(T,FactorVector(j)),myP);%6
                ResultFC(7,j,1,i) = FC_ScoreExp(FC_sSVD(T,FactorVector(j),0.1,1),myP);%7
                ResultFC(8,j,1,i) = FC_ScoreExp(FC_HOsSVD(T,FactorVector(j),0.1,4),myP);%8
        end
end
fg = FC_showResults(ResultFC,myb,1);

end

%%%III
%%%
%%%

%Full experiment

%%%
%%%
%%%Comment the "if 0" to use this part

if 0

%Noise configuration
load Ptheo.mat
load bNoiseVector



%Full Experiment
NbSeizure = 4;%Number of seizure used

for StepRep = 1:12%Saving step
    ResultFC = zeros(8,4,15,10);
    
    for Repetition = 1:10%10 repetition of each experiment
        
        for Noise =1:15%15 noise configuration
            T = FC_Model(NbSeizure, b(Noise,:),Ptheo);
             [StepRep,Repetition,Noise]%print current state
             
            for Nfactor = 1:4%Factor from K=1 to K=4
                %Test on every method compared in the paper
                ResultFC(1,Nfactor,Noise,Repetition) = FC_ScoreExp(FC_Direct(T),Ptheo);%1
                ResultFC(2,Nfactor,Noise,Repetition) = FC_ScoreExp(FC_Mean(T),Ptheo);%2
                ResultFC(3,Nfactor,Noise,Repetition) = FC_ScoreExp(FC_NMF(T,Nfactor),Ptheo);%3
                ResultFC(4,Nfactor,Noise,Repetition) = FC_ScoreExp(FC_nnCP(T,Nfactor),Ptheo);%4
                ResultFC(5,Nfactor,Noise,Repetition) = FC_ScoreExp(FC_SVD(T,Nfactor),Ptheo);%5
                ResultFC(6,Nfactor,Noise,Repetition) = FC_ScoreExp(FC_mHOOI(T,Nfactor),Ptheo);%6
                ResultFC(7,Nfactor,Noise,Repetition) = FC_ScoreExp(FC_sSVD(T,Nfactor,0.1,1),Ptheo);%6
                ResultFC(8,Nfactor,Noise,Repetition) = FC_ScoreExp(FC_HOsSVD(T,Nfactor,0.1,4),Ptheo);%8
                
            end
            
        end
        
    end

    Name = ['FC2exp',num2str(StepRep)];%Save under the name FC3exp"StepRep".mat
    save(Name,'ResultFC')
end



end

%%%IV
%%%
%%%

%Retrieve the results of the complete experience

%%%
%%%
%%%Comment the "if 0" to use this part

if 0

    Res1 = [];
for i = 1:12
    filename = ['FC2exp',num2str(i),'.mat'];
    if isfile(filename)
        load(filename)
        R = permute(ResultFC,[1,4,3,2]);
        Res1 = [Res1, R];
    end
    
end
    Results2 = permute(Res1,[1,4,3,2]);

end




%%%V
%%%
%%%

%Appendix B results

%%%
%%%
%%%Comment the "if 0" to use this part


if 0
load Ptheo.mat
load bNoiseVector
NbSeizure = 4;


repet = 12;
iter =100;
score1 = zeros(repet,iter+1);
score2 = zeros(repet,iter+1);

   for i =1:repet
       
        T = FC_Model(NbSeizure, b(12,:), Ptheo);
        %T = rand(20,20,20);
        [~,score1(i,:)] = FC_mHOOIscore(T,4,iter);
        [~,score2(i,:)] = FC_HOOI(T,4,iter);
       
   end
   
   
   S1 = mean(score1,1);
   S2 = mean(score2,1);
    
    plot(S1)
    hold on 
    plot(S2)
end


