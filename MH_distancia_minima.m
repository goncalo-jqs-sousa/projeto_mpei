function min = MH_distancia_minima(recommended_category_titles_from_history,k_shingle,k,prime)
R = randi(prime,k,k_shingle);
Set = MH_criar_conjunto(recommended_category_titles_from_history,k_shingle);
J = calcular_distancia_MinHash_shingle(Set,k,R,prime);

min = 1;
for l = 1:length(J)
    for c = 1:length(j)
        if J(l,c) ~= 0
            if J(l,c) < min
                min = J(l,c);
            end
        end
    end

end

end