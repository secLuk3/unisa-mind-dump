function s= esponenziale(x,N)
%calcolo dell`esponenziale di un numero
s=0; 
for n=0:N
    %% s=s+x^n/factorial(n)%%%
    prod=1;
    for i=1:n
        prod=prod*(x/i);
    end
    s=s+prod;
    %%%%%%%%%%%
end

