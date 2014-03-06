function codeword = EncodeCyclicSystematic(generatorPoly, message)
%based on example 3.2 in the book

n = 15; %condition of the task
k = length(message); %7 as per the conditions
r = n - k; %no. of parity bits is 8

%creating X^(n-k) = X^r
Xr = zeroes(1,r);
Xr(r) = 1;

%(X^r)m(X)
XrMX = gfconv(Xr, message);

%calculate the remainder(p(X)) of (X^r)m(X) / g(X) 
[qu p] = gfdeconv(XrMX, generatorPoly); 

%codeword calculated as c(X)= (X^r)m(X) + p(X)
codeword = mod([ p zeros(1, n - length(p))] + XrMX, 2);
end