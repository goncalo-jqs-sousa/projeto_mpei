function hash = hash_function_shingle(shingle,nfh,R,prime)
   r = R(nfh,:);
   hash = mod(double(shingle)*r',prime);
end