function[U,c,deter,L]=gauss_naive(A,b)
n=length(b);
A=[A,b];
C=norm(A);
m=zeros(n,n);
deter=1;

for k=1:n-1
    deter=deter*A(k,k);
    if A(k,k)== 0
        U=A(:,1:n);c=A(:,n+1);deter=[];L=-m+eye(n);
        disp('Attenzione matrice singolare!!!')
        k
        return
    elseif abs(A(k,k))<eps*C
        disp('Attenzione matrice potrebbe essere singolare!!!')
    end
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