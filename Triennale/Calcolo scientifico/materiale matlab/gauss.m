function[Amod,c,deter]=gauss(A,b) %Amod matrice a modificata , c termini noti ,determinante , m matrice con i moltiplicatori
n=length(b);
A=[A,b]; %si aggiunge all`ultima colonna il vettore b

deter=1; %elemento neutro per il prodotto

for k=1:n-1
    deter=deter*A(k,k);
    for i=k+1:n
        m=A(i,k)/A(k,k); %i moltiplicatori vanno in una matrice apparte m (da modificare)
        A(i,k:n+1)=A(i,k:n+1)-m*A(k,k:n+1);
        A(i,k)=m;    
    end
end

deter=deter*A(n,n)
Amod=A(:,1:n)
c=A(:,n+1)