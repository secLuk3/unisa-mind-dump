function [x]=pageRank1(G,p)
[m,n]=size(G); %qua ci sarebbe da controllare se la matrice è quadrata

I=eye(n); %creazione matrice identità 

c=sum(G); %somma i numeri delle colonne
D=diag(1./c); %operazione fatta per ogni componente della matrice(1./c) || diag fa una matrice diagonale con il risultato sulla diagonale


A=I-p*G*D;

b=((1-p)/n)*ones(n,1);

x=A\b; %cosa c'è dietro a back slash??? Gauss con pivoting parziale! 

