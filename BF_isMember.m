function result = BF_isMember(elem,BF,k)
    key = elem;
    for i = 1:k
        idx = string2hash(key);
        key = [key num2str(k)];
        idx = mod(idx,length(BF))+1;
        if (BF(idx) ~= 1)
            result = false;
            return
        end
    end
    result = true;
    return

end