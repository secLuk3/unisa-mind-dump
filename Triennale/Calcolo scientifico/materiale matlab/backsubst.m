function x = backsubst(U,c)
n=length(c);

x=zeros(n,1); %vettore soluzione iniziliazzato a zero 

x(n)=c(n)/U(n,n); %prima incognita risolta

for i=n-1:-1:1 %si decrementa di 1 (elemento centrale (-1) ultimo elemento fine ciclo (1))
    somma=0;
    for j=i+1:n
       somma=somma+U(i,j)*x(j);
    end
    x(i)=( c(i)-somma) /U(i,i);

end

