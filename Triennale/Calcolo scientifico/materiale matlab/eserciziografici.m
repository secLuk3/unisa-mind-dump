a=0;b=3;

fplot(@exp,[0,3]) %funzione esponenziale da 0 a 3
hold on  %mantiene i grafici disegnati

p2=@(x) 1+x+x.^2/2; %definisco una funzione| si usa x. per far prendre l`elemento di una matrice x e non la matrice intera
p3=@(x) 1+x+x.^2/2+x.^3/factorial(3);
p4=@(x) 1+x+x.^2/2+x.^3/factorial(3)+x.^4/factorial(4);

fplot(p2,[a,b],'g') %disegna p2 nell`intervallo a,b con colore verde
fplot(p3,[a,b],'r') %disegna p3 nell`intervallo a,b con colore rosso
fplot(p4,[a,b],'k') %disegna p4 nell`intervallo a,b con colore nero
legend('exp','p2','p3','p4') %imposta una legenda


%per disegnare su diverse finestre si usa il comando figure(2)...
%figure(n)