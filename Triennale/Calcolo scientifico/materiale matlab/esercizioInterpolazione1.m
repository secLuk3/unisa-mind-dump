clc 
clear all
close all

f=@(x) cos(x).*(((321-(564.*x)+(112.*(x.^2))-(6.*(x.^3)))./(82-(18.*x)+(x.^2))));

a=4; b=14;


fplot(f,[a,b])
grid on
hold on
axis(axis)

n=5;
x=linspace(a,b,n+1); %per costruire il polinoimi di grado 
y=f(x);
plot(x,y,'or')
p=polyfit(x,y,n);

xx=linspace(a,b,100);
yp=polyval(p,xx);

plot(xx,yp,'k')

n=19;
x=linspace(a,b,n+1); %creo n+1 nodi equidistanti
y=f(x);
p=polyfit(x,y,n);
plot(x,y,'*')
 
 xx=linspace(a,b,100);
 yp=polyval(p,xx);
 plot(xx,yp,'r')
 
 ys=spline(x,y,xx);
 plot(xx,ys,'b')
 
 legend('funzione','nodi g5','g5','nodi g19','g19','spline')
 
