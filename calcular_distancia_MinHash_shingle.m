function [J,Assinaturas] = calcular_distancia_MinHash_shingle(Set,k,R,prime)
    Nu = length(Set);
    J = zeros(Nu);
    Assinaturas = zeros(k,length(Set));
    % calcular assinaturas    
    for i = 1:k
        for c = 1:length(Set)
            conjunto = Set{c};
            hash_codes = zeros(length(conjunto),1);
            for e = 1:length(conjunto)
                shingle = conjunto{e}
                hc = hash_function_shingle(shingle,i,R,prime);
                hash_codes(e) = hc;
            end
            minhash = min(hash_codes);
            Assinaturas(i,c) = minhash;
        end
    end
    for n1= 1:Nu
        for n2= n1+1:Nu
            % Adicionar código aqui
            assinatura1 = Assinaturas(:,n1);
            assinatura2 = Assinaturas(:,n2);
            simil = sum(assinatura1 == assinatura2)/ length(assinatura1);
            J(n1,n2) = 1- simil;
        end   
    end
end