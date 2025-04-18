[U,G] = surfer('https://www.unisa.it/',250);
spy(G)
p=0.85;

[A,b,Ap]=pageRankFinal(G,p);
n=length(b);
x0=zeros(n,1);

xVera=A\b

disp('jacobi')
[xJ,stimaerroreJ,NiterJ,ierJ]=metodoJacobi(A,b,x0,1e-3,50)
errRelJ=norm(xJ-xVera)/norm(xVera)


disp('potenze')
[lambdaP,mP,stimaerroreP,yP]=potenze(Ap,1e-3,50)
errRelJ=norm(x-xVera)/norm(xVera)
