A=[-352/3 -88/3 -88/3;-176/3 264 0;0 704/3 176];

D=diag(diag(A));
C=A-D;
B=-inv(D)*C;
rJ= max(abs(eig(B)))

D=tril(A);
C=A-D;
B=-inv(D)*C;
rG= max(abs(eig(B)))

%È piu veloce il metodo con il raggio spettrale minore 