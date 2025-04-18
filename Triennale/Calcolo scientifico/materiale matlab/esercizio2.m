clear all
clc

a=1e-10;
e=1e-10;
A=[a , 6 , -1 ; 7/10 , 12 , 7; 7/10+a ,18 , 6+e ];
b=[(58+a)/5; 1347/50 ; (1/50)*(1927 +10*a +20*e)];
xvera=[1/5;2;2/5];

disp('%%GAUSS NAIVE%%')
[UN,cN,deterN,LN]=gauss_naive(A,b)
if (deterN~=0) && (~isempty(deterN))
    xN=backsubst(UN,cN)
    errN=norm(xN-xvera)/norm(xvera)
end

disp('%%GAUSS PIVOTING%%')
[UP,cP,deterP,LP,pivotP]=gaus_pivonting(A,b)
if deterP~=0 &&   ~isempty(deterP)
    xP=backsubst(UP,cP)
    errP=norm(xP-xvera)/norm(xvera)
end
cond(A)
A\b
