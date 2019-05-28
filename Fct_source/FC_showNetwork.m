function f = FC_showNetwork(Position,Link,V)
close all
f = figure;

subplot('position',[0.1,0.45,0.4,0.32])
  hold on

  a = 3;
  b = 1;

 G = GetUnderDiag(Link(:,1),size(Position,1));
 for i =1:(size(G,1)-1)
     for j=(i+1):size(G,1)
         if(G(i,j) == 1)
          p1 =  plot(Position([i,j],[a]),Position([i,j],[b]),'color',colors('medium candy apple red'),...
                 'LineWidth',2);
         end
     end
 end
 plot(Position(:,a),Position(:,b),'ks','LineWidth',2)
xlabel('Transverse cut axis x','FontSize',15)
ylabel('Transverse cut axis y','FontSize',15)
 title('1','FontSize',15)
 %lgd = legend([p1,p2,p3,p4],{'Avant crise','Début crise','Propagation','Fin de crise'});
%lgd.FontSize = 12;
 
 subplot('position',[0.1,0.05,0.4,0.32])
   hold on

  G = GetUnderDiag(Link(:,3),size(Position,1));
 for i =1:(size(G,1)-1)
     for j=(i+1):size(G,1)
         if(G(i,j) == 1)
             p2 = plot(Position([i,j],[a]),Position([i,j],[b]),'color',colors('medium taupe'),...
                 'LineWidth',2);      
         end
     end
 end
 plot(Position(:,a),Position(:,b),'ks','LineWidth',2)

 title('3','FontSize',15)


  subplot('position',[0.55,0.45,0.4,0.32])
    hold on

G = GetUnderDiag(Link(:,2),size(Position,1));
 for i =1:(size(G,1)-1)
     for j=(i+1):size(G,1)
         if(G(i,j) == 1)
              p3 =plot(Position([i,j],[a]),Position([i,j],[b]),'color',colors('medium orchid'),...
                 'LineWidth',2);
           
         end
     end
 end
 plot(Position(:,a),Position(:,b),'ks','LineWidth',2)
 title('2','FontSize',15)


  subplot('position',[0.55,0.05,0.4,0.32])
    hold on

 G = GetUnderDiag(Link(:,4),size(Position,1));
 for i =1:(size(G,1)-1)
     for j=(i+1):size(G,1)
         if(G(i,j) == 1)
             p4 = plot(Position([i,j],[a]),Position([i,j],[b]),'color',colors('medium electric blue'),...
                 'LineWidth',2);
           
         end
     end
 end
 
 plot(Position(:,a),Position(:,b),'ks','LineWidth',2)
 title('4','FontSize',15)


 subplot('position',[0.2,0.85,0.7,0.15])
 imagesc(V')
colormap('pink')
%set(gca,'Ytick',1:4,...
%    'YTickLabel', {'Post seizure','Seizure start','Propagation','Seizure end'},'FontSize',16);
set(gca,'Xtick',10:10:100,...
    'XTickLabel', (10:10:100),'FontSize',16);
%ytickangle(-45)
xlabel('time (seconde)','FontSize',16)

end