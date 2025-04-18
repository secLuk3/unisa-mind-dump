function[x,stimaerrore,Niter,ier]=metodoGaussSeidell(A,b,x0,toll,Nmax)
n=length(b);
Niter=0;
ier=0; %indicatore di errore 
stimaerrore=1; %io devo almeno apllicare una volta il metodo .Per farlo entrare la prima volta   
x=zeros(n,1);

while(Niter < Nmax) && ( stimaerrore >= toll)
    for i=1:n
        x(i) = (b(i)-A(i,1:i-1)*x(1:i-1)-A(i,i+1:n)*x0(i+1:n))/A(i,i); %le 2 sommatorie separate Ps: unica differenza con jacobi l`x al posto di x0 alla prima sommatoria cosi prende i risultati mano mano  
    end
    stimaerrore = norm(x-x0)/norm(x);
    Niter = Niter + 1;
    x0=x;
end 
if stimaerrore >= toll
    disp('GaussS non raggiunge l`accuratezza desiderata nel numero delle iterazioni fissate')
    ier = 1;
else
    disp('Accuratezza ottenuta')
end