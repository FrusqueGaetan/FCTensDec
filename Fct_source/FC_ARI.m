function ARI = FC_ARI(Aexp,Atheo)

Contingency = Aexp'*Atheo; %Contingency table

Stheo = sum(Contingency,2); %Sum of row
Sexp= sum(Contingency,1); %Sum of column

N = sum(sum(Contingency));

s1 = sum(Stheo.*(Stheo-1)/2);
s2 = sum(Sexp.*(Sexp-1)/2);
Mphi = 1/2*(s1+s2);	  %Max score 
phi = sum(sum(Contingency.*(Contingency-1)/2)); %non normalized score
Ephi = s1*s2/(N*(N-1)/2);% Average score

ARI = (phi-Ephi)/(Mphi-Ephi);

end

