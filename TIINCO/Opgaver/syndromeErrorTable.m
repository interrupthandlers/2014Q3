G = [gf1 a gf1 gf0 gf0; gf1 a2 gf0 gf1 gf0; gf1 gf1 gf0 gf0 gf1]

P = G(:,1 : 1 : 2)

%eye(n-k)
H = [eye(2) P']

E = [gf([1 0 0 0 0],2); 
     gf([0 1 0 0 0],2);      
     gf([0 0 1 0 0],2); 
     gf([0 0 0 1 0],2); 
     gf([0 0 0 0 1],2); 
     gf([2 0 0 0 0],2); 
     gf([0 2 0 0 0],2); 
     gf([0 0 2 0 0],2); 
     gf([0 0 0 2 0],2); 
     gf([0 0 0 0 2],2); 
     gf([3 0 0 0 0],2); 
     gf([0 3 0 0 0],2); 
     gf([0 0 3 0 0],2); 
     gf([0 0 0 3 0],2); 
     gf([0 0 0 0 3],2);      
    ]

tabel = [];

[numErrorPatterns, n] = size(E);

for i = 1:numErrorPatterns,
    tabel = [tabel ; E(i,:) E(i,:)*H'];
end

tabel
     