g=1e-8;

A=[10 2 3;-3 0 1;4+g 2+g 5+g];
b=[157/9;-13/9;1/9*(131+74*g)];
    
xvera=[2/9;79/9;-7/9]



disp('%%GAUSS PIVOTING%%')
[UP,cP,deterP,LP,pivotP]=gaus_pivonting(A,b)
    xP=backsubst(UP,cP)
    errP=norm(xP-xvera)/norm(xvera)