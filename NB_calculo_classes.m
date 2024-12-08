function res = NB_calculo_classes(classes_treino, Cat, OCORRENCIAS_treino, documentos_teste, palavras_unicas_teste, palavras_unicas_treino)
% Função de cálculo das classes

palavras_aux_1 = {};
palavras_aux_2 = {};
res = [];

if length(Cat) == 4
    pC1 = sum(classes_treino == Cat(1)) / length(classes_treino);
    pC2 = sum(classes_treino == Cat(2)) / length(classes_treino);
    pC3 = sum(classes_treino == Cat(3)) / length(classes_treino);
    pC4 = sum(classes_treino == Cat(4)) / length(classes_treino);
    
    docs_C1 = OCORRENCIAS_treino(classes_treino == Cat(1),:);
    num_palavras_docs_C1 = sum(docs_C1);
    num = num_palavras_docs_C1 + 1;
    den = sum(sum(docs_C1)) + length(palavras_unicas_teste);
    prob_palavra_dado_C1 = num/den;
    
    docs_C2 = OCORRENCIAS_treino(classes_treino == Cat(2),:);
    num_palavras_docs_C2 = sum(docs_C2);
    num = num_palavras_docs_C2 + 1;
    den = sum(sum(docs_C2)) + length(palavras_unicas_teste);
    prob_palavra_dado_C2 = num/den;
    
    docs_C3 = OCORRENCIAS_treino(classes_treino == Cat(3),:);
    num_palavras_docs_C3 = sum(docs_C3);
    num = num_palavras_docs_C3 + 1;
    den = sum(sum(docs_C3)) + length(palavras_unicas_teste);
    prob_palavra_dado_C3 = num/den;
    
    docs_C4 = OCORRENCIAS_treino(classes_treino == Cat(4),:);
    num_palavras_docs_C4 = sum(docs_C4);
    num = num_palavras_docs_C4 + 1;
    den = sum(sum(docs_C4)) + length(palavras_unicas_teste);
    prob_palavra_dado_C4 = num/den;
    
    for i=1:length(documentos_teste)
        if (isa(documentos_teste{i}{2}, 'cell'))
            for j = 1:length(documentos_teste{i}{1})
                if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                    % guarda indice i e j da palavra não pertencente às únicas
                    palavras_aux_1{end+1} = [i,j];
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ ismember(documentos_teste{i}{2}{j}, palavras_unicas_treino)
                    palavras_aux_2{end+1} = [i,j];
                end
            end
        else
            for j = 1:length(documentos_teste{i}{1})
                if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                    palavras_aux_1{end+1} = [i,j];
                end
            end
        end
    end
    
    for i=1:length(palavras_aux_1)
        j = palavras_aux_1{i};
        documentos_teste{j(1)}{1}{j(2)} = '';
    end
    
    for i=1:length(palavras_aux_2)
        j = palavras_aux_2{i};
        documentos_teste{j(1)}{2}{j(2)} = '';
    end
    
    for i=1:length(documentos_teste)
        prob_C1 = 1;
        prob_C2 = 1;
        prob_C3 = 1;
        prob_C4 = 1;
        if (isa(documentos_teste{i}{2}, 'cell') )
            for j = 1:length(documentos_teste{i}{1})
                if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                    prob_C1 = prob_C1 * prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j});
                    prob_C2 = prob_C2 * prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j});
                    prob_C3 = prob_C3 * prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{1}{j});
                    prob_C4 = prob_C4 * prob_palavra_dado_C4(palavras_unicas_teste == documentos_teste{i}{1}{j});
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ strcmpi(string(documentos_teste{i}{2}{j}), "")
                    prob_C1 = prob_C1 * prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{2}{j});
                    prob_C2 = prob_C2 * prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{2}{j});
                    prob_C3 = prob_C3 * prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{2}{j});
                    prob_C4 = prob_C4 * prob_palavra_dado_C4(palavras_unicas_teste == documentos_teste{i}{2}{j});
                end
            end
        else
            for j = 1:length(documentos_teste{i}{1})
                if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                    prob_C1 = prob_C1 * prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j});
                    prob_C2 = prob_C2 * prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j});
                    prob_C3 = prob_C3 * prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{1}{j});
                    prob_C4 = prob_C4 * prob_palavra_dado_C4(palavras_unicas_teste == documentos_teste{i}{1}{j});
                end
            end
        end
        prob_testeC1 = prob_C1 * pC1;
        prob_testeC2 = prob_C2 * pC2;
        prob_testeC3 = prob_C3 * pC3;
        prob_testeC4 = prob_C4 * pC4;
    
        res = [res; prob_testeC1 prob_testeC2 prob_testeC3 prob_testeC4;];
    end
elseif length(Cat) == 3
    pC1 = sum(classes_treino == Cat(1)) / length(classes_treino);
pC2 = sum(classes_treino == Cat(2)) / length(classes_treino);
pC3 = sum(classes_treino == Cat(3)) / length(classes_treino);

docs_C1 = OCORRENCIAS_treino(classes_treino == Cat(1),:);
num_palavras_docs_C1 = sum(docs_C1);
num = num_palavras_docs_C1 + 1;
den = sum(sum(docs_C1)) + length(palavras_unicas_teste);
prob_palavra_dado_C1 = num/den;

docs_C2 = OCORRENCIAS_treino(classes_treino == Cat(2),:);
num_palavras_docs_C2 = sum(docs_C2);
num = num_palavras_docs_C2 + 1;
den = sum(sum(docs_C2)) + length(palavras_unicas_teste);
prob_palavra_dado_C2 = num/den;

docs_C3 = OCORRENCIAS_treino(classes_treino == Cat(3),:);
num_palavras_docs_C3 = sum(docs_C3);
num = num_palavras_docs_C3 + 1;
den = sum(sum(docs_C3)) + length(palavras_unicas_teste);
prob_palavra_dado_C3 = num/den;

for i=1:length(documentos_teste)
    if (isa(documentos_teste{i}{2}, 'cell'))
        for j = 1:length(documentos_teste{i}{1})
            if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                % guarda indice i e j da palavra não pertencente às únicas
                palavras_aux_1{end+1} = [i,j];
            end
        end
        for j = 1:length(documentos_teste{i}{2})
            if ~ ismember(documentos_teste{i}{2}{j}, palavras_unicas_treino)
                palavras_aux_2{end+1} = [i,j];
            end
        end
    else
        for j = 1:length(documentos_teste{i}{1})
            if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                palavras_aux_1{end+1} = [i,j];
            end
        end
    end
end

for i=1:length(palavras_aux_1)
    j = palavras_aux_1{i};
    documentos_teste{j(1)}{1}{j(2)} = '';
end

for i=1:length(palavras_aux_2)
    j = palavras_aux_2{i};
    documentos_teste{j(1)}{2}{j(2)} = '';
end

for i=1:length(documentos_teste)
    prob_C1 = 1;
    prob_C2 = 1;
    prob_C3 = 1;

    if (isa(documentos_teste{i}{2}, 'cell') )
        for j = 1:length(documentos_teste{i}{1})
            if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                prob_C1 = prob_C1 * prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j});
                prob_C2 = prob_C2 * prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j});
                prob_C3 = prob_C3 * prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{1}{j});
            end
        end
        for j = 1:length(documentos_teste{i}{2})
            if ~ strcmpi(string(documentos_teste{i}{2}{j}), "")
                prob_C1 = prob_C1 * prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{2}{j});
                prob_C2 = prob_C2 * prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{2}{j});
                prob_C3 = prob_C3 * prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{2}{j});
            end
        end
    else
        for j = 1:length(documentos_teste{i}{1})
            if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                prob_C1 = prob_C1 * prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j});
                prob_C2 = prob_C2 * prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j});
                prob_C3 = prob_C3 * prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{1}{j});
            end
        end
    end
    prob_testeC1 = prob_C1 * pC1;
    prob_testeC2 = prob_C2 * pC2;
    prob_testeC3 = prob_C3 * pC3;

    res = [res; prob_testeC1 prob_testeC2 prob_testeC3;];
end
end

end