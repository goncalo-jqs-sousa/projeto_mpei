function res = NB_calculo_classes(classes_treino, Cat, OCORRENCIAS_treinoC1, OCORRENCIAS_treinoC2, documentos_teste, palavras_unicas_teste, palavras_unicas_treinoC1, palavras_unicas_treinoC2, n_max_word)
% Função de cálculo das classes


palavras_aux_1 = {};
palavras_aux_2 = {};
palavras_aux_3 = {};
res = [];

if length(documentos_teste{1}) == 2
    pC1 = sum(classes_treino == Cat(1)) / length(classes_treino);
    pC2 = sum(classes_treino == Cat(2)) / length(classes_treino);

    unicas_aux1 = [];
    unicas_aux2 = [];
    indice_C1 = [];
    indice_C2 = [];
    cnt = 0;
    docs_C1 = OCORRENCIAS_treinoC1;
    docs_C2 = OCORRENCIAS_treinoC2;
    num_palavras_docs_C1 = sum(docs_C1);
    num_palavras_docs_C2 = sum(docs_C2);
    [ordenado_C1, indice1] = sort(num_palavras_docs_C1, "descend");
    [ordenado_C2, indice2] = sort(num_palavras_docs_C2, "descend");

    % calcular palavras_unicas_treinoC1
    for i = 1:length(ordenado_C1)
        flag_ambos = 0;
        aux = palavras_unicas_treinoC1(indice1(i));
        for j = 1:length(palavras_unicas_treinoC2)
            if strcmp(aux, palavras_unicas_treinoC2(j))
                flag_ambos = 1;
                break;
            end
        end
        if ~ flag_ambos
            unicas_aux1 = [unicas_aux1, aux];
            indice_C1 = [indice_C1, i];
            cnt = cnt + 1;
        end
        if cnt == n_max_word
            cnt = 0;
            break;
        end
    end

    % calcular palavras_unicas_treinoC2
    for i = 1:length(ordenado_C2)
        flag_ambos = 0;
        aux = palavras_unicas_treinoC2(indice2(i));
        for j = 1:length(palavras_unicas_treinoC1)
            if strcmp(aux, palavras_unicas_treinoC1(j))
                flag_ambos = 1;
                break;
            end
        end
        if ~ flag_ambos
            unicas_aux2 = [unicas_aux2, aux];
            indice_C2 = [indice_C2, i];
            cnt = cnt + 1;
        end
        if cnt == n_max_word
            cnt = 0;
            break;
        end
    end

    for i=1:length(documentos_teste)
        for j = 1:length(documentos_teste{i}{1})
            if ~ ismember(documentos_teste{i}{1}{j}, unicas_aux1) & ~ ismember(documentos_teste{i}{1}{j}, unicas_aux2)
                % guarda indice i e j da palavra não pertencente às únicas
                palavras_aux_1{end+1} = [i,j];
                palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{1}{j}) = [];
            end
        end
        for j = 1:length(documentos_teste{i}{2})
            if ~ ismember(documentos_teste{i}{2}{j}, unicas_aux1) & ~ ismember(documentos_teste{i}{2}{j}, unicas_aux2)
                palavras_aux_2{end+1} = [i,j];
                palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{2}{j}) = [];
            end
        end
    end

    docs_C1 = OCORRENCIAS_treinoC1(:,indice1(indice_C1(:,1:n_max_word)));
    docs_C2 = OCORRENCIAS_treinoC2(:,indice2(indice_C2(:,1:n_max_word)));

    for i = 1:length(palavras_unicas_teste)
        for j = 1:length(unicas_aux1)
            if strcmp(palavras_unicas_teste(i),unicas_aux1(j))
                num_palavras_docs_C1(i) = sum(docs_C1(:,j));
            else
                num_palavras_docs_C1(i) = -0.9;
            end
        end
    end

    for i = 1:length(palavras_unicas_teste)
        for j = 1:length(unicas_aux2)
            if strcmp(palavras_unicas_teste(i),unicas_aux2(j))
                num_palavras_docs_C2(i) = sum(docs_C2(:,j));
            else
                num_palavras_docs_C2(i) = -0.9;
            end
        end
    end

    num = num_palavras_docs_C1 + 1;
    den = sum(sum(docs_C1)) + length(palavras_unicas_teste);
    prob_palavra_dado_C1 = num/den;

    num = num_palavras_docs_C2 + 1;
    den = sum(sum(docs_C2)) + length(palavras_unicas_teste);
    prob_palavra_dado_C2 = num/den;

    for i=1:length(palavras_aux_1)
        j = palavras_aux_1{i};
        documentos_teste{j(1)}{1}{j(2)} = '';
    end
    for i=1:length(palavras_aux_2)
        j = palavras_aux_2{i};
        documentos_teste{j(1)}{2}{j(2)} = '';
    end
    for i=1:length(palavras_aux_3)
        j = palavras_aux_3{i};
        documentos_teste{j(1)}{3}{j(2)} = '';
    end

    for i=1:length(documentos_teste)
        prob_C1 = 1;
        prob_C2 = 1;

        for j = 1:length(documentos_teste{i}{1})
            if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j}));
            end
        end
        for j = 1:length(documentos_teste{i}{2})
            if ~ strcmpi(string(documentos_teste{i}{2}{j}), "")
                prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{2}{j}));
            end
        end

        prob_testeC1 = prob_C1 * pC1;
        prob_testeC2 = prob_C2 * pC2;

        res = [res; prob_testeC1 prob_testeC2;];
    end  
else
    pC1 = sum(classes_treino == Cat(1)) / length(classes_treino);
    pC2 = sum(classes_treino == Cat(2)) / length(classes_treino);

    unicas_aux1 = [];
    unicas_aux2 = [];
    indice_C1 = [];
    indice_C2 = [];
    cnt = 0;
    docs_C1 = OCORRENCIAS_treinoC1;
    docs_C2 = OCORRENCIAS_treinoC2;
    num_palavras_docs_C1 = sum(docs_C1);
    num_palavras_docs_C2 = sum(docs_C2);
    [ordenado_C1, indice1] = sort(num_palavras_docs_C1, "descend");
    [ordenado_C2, indice2] = sort(num_palavras_docs_C2, "descend");

    % calcular palavras_unicas_treinoC1
    for i = 1:length(ordenado_C1)
        flag_ambos = 0;
        aux = palavras_unicas_treinoC1(indice1(i));
        for j = 1:length(palavras_unicas_treinoC2)
            if strcmp(aux, palavras_unicas_treinoC2(j))
                flag_ambos = 1;
                break;
            end
        end
        if ~ flag_ambos
            unicas_aux1 = [unicas_aux1, aux];
            indice_C1 = [indice_C1, i];
            cnt = cnt + 1;
        end
        if cnt == n_max_word
            cnt = 0;
            break;
        end
    end

    % calcular palavras_unicas_treinoC2
    for i = 1:length(ordenado_C2)
        flag_ambos = 0;
        aux = palavras_unicas_treinoC2(indice2(i));
        for j = 1:length(palavras_unicas_treinoC1)
            if strcmp(aux, palavras_unicas_treinoC1(j))
                flag_ambos = 1;
                break;
            end
        end
        if ~ flag_ambos
            unicas_aux2 = [unicas_aux2, aux];
            indice_C2 = [indice_C2, i];
            cnt = cnt + 1;
        end
        if cnt == n_max_word
            cnt = 0;
            break;
        end
    end

    for i=1:length(documentos_teste)
        for j = 1:length(documentos_teste{i}{1})
            if ~ ismember(documentos_teste{i}{1}{j}, unicas_aux1) & ~ ismember(documentos_teste{i}{1}{j}, unicas_aux2)
                % guarda indice i e j da palavra não pertencente às únicas
                palavras_aux_1{end+1} = [i,j];
                palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{1}{j}) = [];
            end
        end
        for j = 1:length(documentos_teste{i}{2})
            if ~ ismember(documentos_teste{i}{2}{j}, unicas_aux1) & ~ ismember(documentos_teste{i}{2}{j}, unicas_aux2)
                palavras_aux_2{end+1} = [i,j];
                palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{2}{j}) = [];
            end
        end
        for j = 1:length(documentos_teste{i}{3})
            if ~ ismember(documentos_teste{i}{3}{j}, unicas_aux1) & ~ ismember(documentos_teste{i}{3}{j}, unicas_aux2)
                palavras_aux_3{end+1} = [i,j];
                palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{3}{j}) = [];
            end
        end
    end

    docs_C1 = OCORRENCIAS_treinoC1(:,indice1(indice_C1(:,1:n_max_word)));
    docs_C2 = OCORRENCIAS_treinoC2(:,indice2(indice_C2(:,1:n_max_word)));

    for i = 1:length(palavras_unicas_teste)
        for j = 1:length(unicas_aux1)
            if strcmp(palavras_unicas_teste(i),unicas_aux1(j))
                num_palavras_docs_C1(i) = sum(docs_C1(:,j));
            else
                num_palavras_docs_C1(i) = -0.9;
            end
        end
    end

    for i = 1:length(palavras_unicas_teste)
        for j = 1:length(unicas_aux2)
            if strcmp(palavras_unicas_teste(i),unicas_aux2(j))
                num_palavras_docs_C2(i) = sum(docs_C2(:,j));
            else
                num_palavras_docs_C2(i) = -0.9;
            end
        end
    end

    num = num_palavras_docs_C1 + 1;
    den = sum(sum(docs_C1)) + length(palavras_unicas_teste);
    prob_palavra_dado_C1 = num/den;

    num = num_palavras_docs_C2 + 1;
    den = sum(sum(docs_C2)) + length(palavras_unicas_teste);
    prob_palavra_dado_C2 = num/den;

    for i=1:length(palavras_aux_1)
        j = palavras_aux_1{i};
        documentos_teste{j(1)}{1}{j(2)} = '';
    end
    for i=1:length(palavras_aux_2)
        j = palavras_aux_2{i};
        documentos_teste{j(1)}{2}{j(2)} = '';
    end
    for i=1:length(palavras_aux_3)
        j = palavras_aux_3{i};
        documentos_teste{j(1)}{3}{j(2)} = '';
    end

    for i=1:length(documentos_teste)
        prob_C1 = 1;
        prob_C2 = 1;
        for j = 1:length(documentos_teste{i}{1})
            if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j}));
            end
        end
        for j = 1:length(documentos_teste{i}{2})
            if ~ strcmpi(string(documentos_teste{i}{2}{j}), "")
                prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{2}{j}));
            end
        end
        for j = 1:length(documentos_teste{i}{3})
            if ~ strcmpi(string(documentos_teste{i}{3}{j}), "")
                prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{3}{j}));
                prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{3}{j}));
            end
        end

        prob_testeC1 = prob_C1 * pC1;
        prob_testeC2 = prob_C2 * pC2;

        res = [res; prob_testeC1 prob_testeC2;];
    end    
end

end