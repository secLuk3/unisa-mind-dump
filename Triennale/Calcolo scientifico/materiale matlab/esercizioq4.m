clc 
clear all
close all
f=@(x) cos(x).*(((321-(564.*x)+(112.*(x.^2))-(6.*(x.^3)))./(82-(18.*x)+(x.^2))));

a=4; b=14;

grid on;
hold on;
axis(axis);
fplot(f,[a,b])

% n=6;
% x=linspace(a,b,n+1); %creo n+1 nodi equidistanti
% y=f(x);
% p=polyfit(x,y,n);
% 
% xx=linspace(x,y,100);
% yp=polyval(p,xx);
% plot(xx,yp,'g')
% 
% n=20;
% x=linspace(a,b,n+1); %creo n+1 nodi equidistanti
% y=f(x);
% p=polyfit(x,y,n);
% 
% xx=linspace(x,y,100);
% yp=polyval(p,xx);
% plot(xx,yp,'r')
% 
% ys=spline(xx,y);
% plot(xx,ys,'b')
% 
