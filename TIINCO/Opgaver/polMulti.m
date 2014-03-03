function mul = polMulti(polmat)

%A = [ gf([1 0 1 0 0 1],5) ; gf([1 0 1 1 1 1],5); gf([1 1 1 0 1 1],5)]

mul = 0;

for i=1:size(polmat,1)-1
    if(mul == 0)
        mul = conv(polmat(i,:), polmat(i+1,:));
    else
        mul = conv(mul, polmat(i+1,:)); 
    end 
end 

