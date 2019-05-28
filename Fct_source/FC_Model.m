function T = FC_Model(Nsujet, b,Ptheo)
%b noise vector 
%Ptheo 4 cluster corresponding to 3 FC activation and a cluster No
%activation



Mat = zeros(66,1000,Nsujet);
for i =1:Nsujet
    
%Generate step
if b(1) == 1
   gen = randperm(308)+5;%Size of the 3 activation steps
   StepA=sort(gen(1:3));
   StepI = randperm(313*3-sum(StepA));%Firsts activation start
   Step = [StepI(1)+30,StepA(1)+StepI(1)+30,StepA(2)+StepA(1)+StepI(1)+30 ,...
      StepA(3)+StepA(2)+StepA(1)+StepI(1)+30 ];
else
   Step = [31,344,657,970]; %3 equal steps of 313 samples
end

StepMat = zeros(4,1000);
StepMat(2,Step(1)+1:Step(3))=1;
StepMat(3,Step(2)+1:Step(3))=1;
StepMat(4,Step(3)+1:Step(4))=1;

%Generate error
if b(2) == 0
    Perror = Ptheo;
    New = Perror(:,2:4);
else
    

    Activation = Ptheo(:,2:4);%What FC is usually activated
    Error = double((rand(66,3).*Activation)>1-b(2));%Selection of FC to replace
    SumErr = sum(Error);%How many FC to replace in each cluster
    
    New = Activation.*(1-Error);

    Assign = [randperm(66)',randperm(66)',randperm(66)'];
    for j =1:3%new activation
        if SumErr(j) > 0
            New(Assign(1:SumErr(j),j),j) = ones(SumErr(j),1);
        end
    end
    
        
    Perror = [Ptheo(:,1),New];

end
    
    
    
if b(4) == 0
%Model with only the %error and duration noise
    Mat(:,:,i) = 1/2*(double(Perror*StepMat>0))+0.2;
else
    Jittconst = b(4)*size(Mat,2);
    JitterMat = floor((Jittconst*rand(66,3)-Jittconst/2)).*New;
    maxJitt = floor(Jittconst/2+1);
    
    
    SumShift= shiffting(Perror(:,2)*StepMat(2,:),JitterMat(:,1),maxJitt )+...
                  shiffting(Perror(:,3)*StepMat(3,:),JitterMat(:,2),maxJitt )+...
                  shiffting(Perror(:,4)*StepMat(4,:),JitterMat(:,3),maxJitt );

    Mat(:,:,i) = 1/2*(double(SumShift>0))+0.2;
              
              
end


end

%Gaussian noise
T = Mat + randn(size(Mat))*b(3);
end





function Mshift = shiffting(M,Jitt,b)

tot = size(M,2)+2*b;
c = [zeros(size(M,1),b),M,zeros(size(M,1),b)];
cshift = round(ifft(fft(c,[],2) .* exp(-2i*pi/tot*Jitt*(0:(tot-1))) ,[],2)  );
Mshift = cshift(:,(b+1):1:(end-b));
end