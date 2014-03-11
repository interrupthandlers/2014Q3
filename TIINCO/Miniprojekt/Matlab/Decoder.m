clc;
clear;

n = 7;
k = 4;
g = [1 1 0 1]; % g(x) = 1 + X + X^3
r = [1 0 1 1 0 1 1];
%r = [0 0 1 0 1 1 0];

s = zeros(1, (n-k-1) + 1);
buffer = r;

for i = 0:n-1,
    gate = s(end); %store msb for feedback calc
    s = circshift(s,[0 1]); %shift syndrom 1 right
    s(1) = r(n-i); %shift bit from r to s
    
    %calc and apply feedback
    feedback = gate * g;
    feedback(end) = []; %remove msb
    s = mod(s + feedback, 2); %add feedback to syndrom
end

dmin = gfweight(g);
t = floor((dmin-1)/2);

%calc error patterns
E = zeros(1, n);
E(end) = 1;

H = cyclgen(n,g,'system');

S = E*H'; %calc all syndrome vectors

errors = 0;
synMod = 0;
for i = 0:n-1,
    gate = s(end); %store msb for feedback calc
    s = circshift(s,[0 1]); %shift syndrom 1 right
    s(1) = 0; %reset lsb to counter circshift() wrapping around
    buffer = circshift(buffer,[0 1]); %shift syndrom 1 right    
    
    %calc and apply feedback
    feedback = gate * g;
    feedback(end) = []; %remove msb
    s = mod(s + feedback, 2); %add feedback to syndrom
    s(1) = mod(s(1) + synMod, 2); %apply syndrome modification
    
    %check if the syndrome vector corresponds to an error pattern with 1 as highest bit
    if ismember(s, S, 'rows') %if S contains a vector equal to s
        buffer(end) = mod(buffer(end) + 1, 2); %correct the buffer
        synMod = 1; %syndrome modification
        errors = errors + 1;
    else
        synMod = 0;
    end
end

if s == zeros(1, (n-k-1) + 1) %if syndrome vector is all zeroes
    %decoded correct
else
    %uncorrectable
end

