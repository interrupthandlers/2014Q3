%create error pattern with one error bit
n = 15;

E = zeros(1, n);
E(end) = 1;

%create 2 bit error patterns
for i = 1:n-1
    e = zeros(1, n);
    e(i) = 1; %set bit
    e(end) = 1; %set MSb (all 2 pattern have MSb set)
    E = [E ; e]; 
end

H = cyclgen(15, [1 0 0 0 1 0 1 1 1], 'system');

S = [];

for i = 1:size(E,1)
    si = E(i,:)*H';
    
    S = [S ; si];
end