function J = MH(recommended_category_titles_from_history,k_shingle,k,prime)
R = randi(prime,k,k_shingle);
Set = MH_criar_conjunto(recommended_category_titles_from_history,k_shingle);
J = calcular_distancia_MinHash_shingle(Set,k,R,prime);

end