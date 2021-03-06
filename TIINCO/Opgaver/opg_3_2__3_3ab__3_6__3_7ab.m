%% Exercise 3.2, 3.3(a-b), 3.6 and 3.7
%% 3.2
% Verify that the generator polynomial g(X) = 1 + X + X2 + X3 generates a 
% binary cyclic code Ccyc(8, 5) and determine the code polynomial for the 
% message vector m = (10101) in systematic form.
clear; clc;
g = [1 1 1 1];

%%
% f(n) = X^n+1 = X^8+1

f = [1 0 0 0 0 0 0 0 1];

[qu re] = gfdeconv(f, g) 

%% 
% Because the remainder of f/g is 0, the polynomial g generates a Ccyc(8,k)
% . r can be obtained by inspecting g. k can now be verified:
r = 3;
n = 8;
k = n - r

%%
% Since k = 5 g generates Ccyc(8,5).

%%
% The following is based on ex. 3.2 from the book.

m = [1 0 1 0 1];

Xr = [0 0 0 1]; 

XrMX = gfconv(Xr, m)

[qu p] = gfdeconv(XrMX, g)

cX = mod([ p zeros(1, n - length(p))] + XrMX, 2)

%%
% Given cX the code polynomial is: c(X) = X + X^3 + X^5 + X^7

clear;
%% 3.3
% A binary linear cyclic code Ccyc(n, k) has code length n = 7 and 
% generator polynomial g(X) = 1 + X2 + X3 + X4.

%%
% a)
% Find the code rate, the generator and parity check matrices of the code 
% in systematic form, and its Hamming distance.

g = [1 0 1 1 1];
n = 7;
r = 4; % degree as seen from g

%%
% CodeRate
k = n - r;

codeRate = k/n 

%%
% Generator matrix

g1 = gfconv([0 1],g); 
g2 = gfconv([0 0 1],g);

G = [g 0 0 ; g1 0; g2]

GRowReduced = mod(rref(G),2)

GRowReducedSystematic = [GRowReduced(:,4 : 1 : end) GRowReduced(:,1 : 1 : 3)]

%%
% Parity matrix

P = GRowReducedSystematic(:,1 : 1 : 4)

H = [eye(n-k) P']

%%
% Hamming distance

hamDist = gfweight(GRowReducedSystematic)


%%
% b) If all the information symbols are �1�s, what is the corresponding 
% code vector? 
% Based on example 3.2, so the resulting code vector is systematic.

m = [1 1 1];

Xr = [0 0 0 0 1]; 

XrMX = gfconv(Xr, m)

[qu p] = gfdeconv(XrMX, g)

cX = mod([ p zeros(1,n - length(p))] + XrMX, 2)

clear;
%% 3.6

%%
% a)
% Determine the table of code vectors of the binary linear cyclic block 
% code Ccyc(6, 2) generated by the polynomial g(X) = 1 + X + X3 + X4.

g = [1 1 0 1 1];
n = 6;
k = 2;

M = [0 0; 1 0; 0 1; 1 1]

%%
% These code vectors are not in systematic form.

C1 = gfconv(M(1,:), g);
C2 = gfconv(M(2,:), g);
C3 = gfconv(M(3,:), g);
C4 = gfconv(M(4,:), g);

C = [C1 0; C2 0; C3; C4]

%%
% b)
% Calculate the minimum Hamming distance of the code, and its error-
% correction capability.

%%
% The hamming distance is the minimum weight of all non-zero code vectors.
Dmin = 4;

%%
% Error correction
Edetect = Dmin - 1

Ecorrect = floor((Dmin-1)/2)


clear;
%% 3.7
% A binary linear cyclic block code with a code length of n = 14 has the 
% generator polynomial g(X) = 1 + X2 + X6.

g = [1 0 1 0 0 0 1];
n = 14;
r = 6; % degree as seen from g

%%
% a)
% Determine the number of information and parity check bits in each code
% vector.

%%
% information bits
k = n - r

%%
% parity bits
parBits = n - k

%%
% b)
% Determine the number of code vectors in the code.

numCodeVectors = 2^k



