function[lambda,m,stimaerrore,y]=potenze(A,toll,Nmax)

n=size(A,1); %numero di righe di A
y0=ones(n,1); 
lambda0=0;
stimaerrore=toll+1;
m=0;

while stimaerrore > toll && m<Nmax
   w=A*y0;
   [~,k]=max(abs(w)); %prendiamo k a ogni iterazione (quando non vogliamo una cosa mettiao la tilde ~)
   lambda=w(k)/y0(k);
   y=w/norm(w,1); %normalizzioamo per non avere valori troppo grandi
   
   %stimaerrore=norm(y-y0)/norm(y,1); %autovettori (es:se partiaoa da un grafo) 
   stimaerrore= abs(lambda-lambda0)/abs(lambda); %autovalori
   
   y0=y;
   lambda0=lambda;
   m=m+1;
end

%controllare con eig(A) gli autovalori prima di inserire in tabella 
%se ci sono 2 o piu autovalori uguali il metodo non funziona sempre e saara
%piu lento