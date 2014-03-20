function codeword = EncodeCyclicSystematic(generatorPoly, message)
%Example generator g = 1 + X^4 + X^6 + X^7 + X^8 =   1 0 0 0 1 0 1 1 1] 
%Example message m = X^3 + X^4 + X^5 + X^6 =         [0 0 0 1 1 1 1]
%Example statement: codeword =                          EncodeCyclicSystematic(g,m)
%Example output: codeword =                             [1 1 0 1 1 1 0 1 0 0 0 1 1 1 1]

k = length(message); %7 as per the conditions
n = 15; %15 as per the conditions

%creating X^(n-k) = X^r
Xr = zeros(1,length(generatorPoly));   %All zero vector with length = r
Xr(end) = 1;          %Assign 1 to r'th position

%(X^r)m(X)
XrMX = gfconv(Xr, message);

%calculate the remainder(p(X)) of (X^r)m(X) / g(X) 
[qu p] = gfdeconv(XrMX, generatorPoly);

%codeword calculated as c(X)= (X^r)m(X) + p(X)
codeword = mod([ p zeros(1, n - length(p))] + [XrMX zeros(1, n - length(XrMX))], 2);
end