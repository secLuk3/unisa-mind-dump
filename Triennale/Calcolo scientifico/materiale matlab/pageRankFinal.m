function [A,b,Ap]=pageRankFinal(G,p) %G matrice connettività 
n=size(G,1); %qua ci sarebbe da controllare se la matrice è quadrata
G=G-diag(diag(G)); %eliminiamo eventuali link autoreferenziali

c=sum(G); %somma i numeri delle colonne
index=find(c==0);ni=length(index); %si eliminano eventuali valori nulli nel vettore c 
c(index)=n*ones(1,ni);             %sostituendoli con n e modificando la matrice G 
G(:,index)=ones(n,ni);             %mettendo 1 dove erano i valori nulli 

I=eye(n); %creazione matrice identità 

e=ones(n,1);
delta=(1-p)/n;
b=delta*e; %vettore termine noto

D=diag(1./c); %operazione fatta per ogni componente della matrice(1./c) || diag fa una matrice diagonale con il risultato sulla diagonale


A=I-p*G*D;
Ap=p*G*D+delta*e*e'; %matrice da da dare in input al metodo delle potenze ||e' = trasposto

