f=@(x) 4.*cos(x)./20+8.*sin(7.*x)+sin(7.*x.^2);
a=0; b=2*pi;

figure(1)
fplot(f,[a b],'b')
axis(axis)
hold on
grid on


n=20;
x=linspace(a,b,n+1); %per costruire il polinoimi di grado 4
y=f(x);
plot(x,y,'or')
p=polyfit(x,y,n);

xx=linspace(a,b,100);
yp=polyval(p,xx);

ys=spline(x,y,xx);
plot(xx,yp,'k')
plot(xx,ys,'r')


n=6;
x=linspace(a,b,n+1); %per costruire il polinoimi di grado 4
y=f(x);
plot(x,y,'*')
p=polyfit(x,y,n);

xx=linspace(a,b,100);
yp=polyval(p,xx);

plot(xx,yp,'g')
