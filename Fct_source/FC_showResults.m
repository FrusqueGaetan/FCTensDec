function fg = FC_showResults(A,b,vec)

    %close all
fg=figure('Renderer', 'painters', 'Position', [1 1 900 500]);
A1  = max(A,[],2);
A2 = permute(A1,[4,3,1,2]);

%Exp1 noise only

    CA = A2(:,vec,:);
    %CA = permute(A2(:,vec,:),[2,1,3]);


aa = size(CA,2)-1;
p = 0.9;
errorbar((0:(aa))*p+0.1,mean(squeeze(CA(:,:,1)))',std(squeeze(CA(:,:,1)))','k*','MarkerSize',10)
 hold on
errorbar((0:(aa))*p+0.2,mean(squeeze(CA(:,:,2)))',std(squeeze(CA(:,:,2)))','*','color',colors('trolley grey'),'MarkerSize',10)
errorbar((0:(aa))*p+0.3,mean(squeeze(CA(:,:,3)))',std(squeeze(CA(:,:,3)))','*','color',colors('light green'),'MarkerSize',10)
errorbar((0:(aa))*p+0.4,mean(squeeze(CA(:,:,4)))',std(squeeze(CA(:,:,4)))','*','color',colors('kelly green'),'MarkerSize',10)
errorbar((0:(aa))*p+0.5,mean(squeeze(CA(:,:,5)))',std(squeeze(CA(:,:,5)))','*','color',colors('light blue'),'MarkerSize',10)
errorbar((0:(aa))*p+0.6,mean(squeeze(CA(:,:,6)))',std(squeeze(CA(:,:,6)))','b*','MarkerSize',10)
errorbar((0:(aa))*p+0.7,mean(squeeze(CA(:,:,7)))',std(squeeze(CA(:,:,7)))','*','color',colors('orange peel'),'MarkerSize',10)
errorbar((0:(aa))*p+0.8,mean(squeeze(CA(:,:,8)))',std(squeeze(CA(:,:,8)))','r*','MarkerSize',10)


LengthVec = length(vec)-1;
for i =1:LengthVec
    line([i,i]*p,[0,1],'color','k')
end

lgd= legend({'Direct','Mean','NMF','nnCP','SVD','mHOOI','sSVD','HOsSVD'},'Location', 'Best');
lgd.FontSize = 16;

 ylim([0,1])
 xlim([0,aa*p+1*p])
 
 
 %Create legend
 NameVec = [];
 for i =1:(LengthVec+1)
    NameVec{i} = ['b_{',num2str(vec(i)), '}=[',num2str(b(vec(i),1)), ';' ,...
        num2str(b(vec(i),2)),';',num2str(b(vec(i),3)) ,';',num2str(b(vec(i),4)),']'];
end
 set(gca,'Xtick',(0:aa)*p+0.5*p,...
     'XTickLabel', NameVec...
     ,'FontSize',16);
 xtickangle(25)
ylabel('ARI score','FontSize',24)

 ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
end