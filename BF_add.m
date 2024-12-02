function BF = BF_add(elem,BF,k)
    key = elem;
    for i = 1:k
        idx = string2hash(key);
        key = [key num2str(k)];
        idx = mod(idx,length(BF))+1;
        BF(idx) = 1;
    end
end