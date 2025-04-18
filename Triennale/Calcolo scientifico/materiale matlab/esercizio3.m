clc
clear all

A=[-352/3 -88/3 -88/3;-176/3 264 0;0 704/3 176];
b=[12;-14;28];
xVera=[-87/583;-201/2332;639/2332]
x0=[0;0;0];
toll=eps;
Nmax=50;

disp('Jacobi')
[xJ,stimaerroreJ,NiterJ,ierJ]=metodoJacobi(A,b,x0,toll,Nmax)
errRelJ=norm(xJ-xVera)/norm(xVera)

disp('Gauss-Seidell')
[xGS,stimaerroreGS,NiterGS,ierGS]=metodoGaussSeidell(A,b,x0,toll,Nmax)
errRelGS=norm(xGS-xVera)/norm(xVera)

 codizionamento=cond(A)
