function x=backsubst1(U,c)

%funziona solo con matrice triangolare 3x3

x=zeros(3,1); %costruiamo un vettore colonna
x(3) = c(3)/U(3,3);
x(2) = (c(2)-U(2,3)*x(3))/U(2,2);
x(1) = (c(1)-U(1,2)*x(2)-U(1,3)*x(3))/U(1,1);