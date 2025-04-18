p=0.85; n=4;
%dichiarazione di una matrice 
A=[1 -p/2 0 0;
    -p/3 1 0 -p/2;
    -p/3 0 1 -p/2;
    -p/3 -p/2 -p 1]

b=((1-p)/n)*ones(n,1) %ones genera un vettore di tutti uno di n righe e 1 colonna

x=A\b %backslash usa il metodo di eiminazione di Gauss per risolvere la matrice

sum(x); %fa la fomme degli elementi di un  vettore