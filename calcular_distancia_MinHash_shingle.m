function [J,Assinaturas] = calcular_distancia_MinHash_shingle(recommended_category_titles_from_history,k,R,prime)
    Nu = length(recommended_category_titles_from_history);
    J = zeros(Nu);
    Assinaturas = zeros(k,length(recommended_category_titles_from_history));
    % calcular assinaturas    
    for i = 1:k
        for c = 1:length(recommended_category_titles_from_history)
            conjunto = recommended_category_titles_from_history(c);
            hash_codes = zeros(length(conjunto),1);
            for e = 1:length(conjunto)
                shingle = conjunto(e)
                hc = hash_function_shingle(shingle,i,R,prime);
                hash_codes(e) = hc;
            end
            minhash = min(hash_codes);
            Assinaturas(i,c) = minhash;
        end
    end
    for n1= 1:Nu
        waitbar(n1/Nu,h);
        for n2= n1+1:Nu
            % Adicionar código aqui
            assinatura1 = Assinaturas(:,n1);
            assinatura2 = Assinaturas(:,n2);
            simil = sum(assinatura1 == assinatura2)/ length(assinatura1);
            J(n1,n2) = 1- simil;
        end   
    end
end