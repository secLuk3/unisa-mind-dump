function[U,c,deter,L,pivot]=gaus_pivonting(A,b)
n=length(b);
A=[A,b];
C=norm(A); %norma di matrici cosi vediamo l`ordine di grandezza di una matrice 
m=zeros(n,n);
pivot=1:n;
deter=1;

for k=1:n-1
    [amax,r]=max(abs(A(k:n,k))); %max in un vettore poi valore assoluto di una pezzo di A
    r=r+k-1;
    if r>k
        tmp=A(k,:);
        A(k,:)=A(r,:);
        A(r,:)=tmp;
        tmp=m(k,:);
        m(k,:)=m(r,:);
        m(r,:)=tmp;
        tmp=pivot(k);
        pivot(k)=pivot(r);
        pivot(r)=tmp;
        deter=-deter;
    end
    if A(k,k)== 0
        U=A(:,1:n);c=A(:,n+1);deter=0;L=-m+eye(n);
        disp('Attenzione matrice singolare!!!')
        k
        return
    end
    if abs(A(k,k))<eps*C
        disp('Attenzione matrice potrebbe essere singolare!!!')
    end
    deter=deter*A(k,k);
    for i=k+1:n
        m(i,k)=-A(i,k)/A(k,k);
        A(i,k:n+1)=A(i,k:n+1)+m(i,k)*A(k,k:n+1);
    end
end
if A(n,n)==0
    disp('Attenzione matrice singolare!!!')
elseif abs(A(n,n))<eps*C
       disp('Attenzione matrice potrebbe essere singolare!!!')
end
deter=deter*A(n,n);
U=A(:,1:n);
c=A(:,n+1);
L=-m+eye(n);
        
    