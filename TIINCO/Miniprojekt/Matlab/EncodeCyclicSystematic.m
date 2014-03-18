function codeword = EncodeCyclicSystematic(generatorPoly, message)
%based on example 3.2 in the book

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