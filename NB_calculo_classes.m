function res = NB_calculo_classes(classes_treino, Cat, OCORRENCIAS_treino, documentos_teste, palavras_unicas_teste, palavras_unicas_treino)
% Função de cálculo das classes

palavras_aux_1 = {};
palavras_aux_2 = {};
palavras_aux_3 = {};
res = [];

if length(documentos_teste{1}) == 2
    if length(Cat) == 4
        pC1 = sum(double(classes_treino) == Cat(1)) / length(classes_treino);
        pC2 = sum(double(classes_treino) == Cat(2)) / length(classes_treino);
        pC3 = sum(double(classes_treino) == Cat(3)) / length(classes_treino);
        pC4 = sum(double(classes_treino) == Cat(4)) / length(classes_treino);

        docs_C1 = OCORRENCIAS_treino(double(classes_treino) == Cat(1),:);
        num_palavras_docs_C1 = sum(docs_C1);
        num = num_palavras_docs_C1 + 1;
        den = sum(sum(docs_C1)) + length(palavras_unicas_treino);
        prob_palavra_dado_C1 = num/den;

        docs_C2 = OCORRENCIAS_treino(double(classes_treino) == Cat(2),:);
        num_palavras_docs_C2 = sum(docs_C2);
        num = num_palavras_docs_C2 + 1;
        den = sum(sum(docs_C2)) + length(palavras_unicas_treino);
        prob_palavra_dado_C2 = num/den;

        docs_C3 = OCORRENCIAS_treino(double(classes_treino) == Cat(3),:);
        num_palavras_docs_C3 = sum(docs_C3);
        num = num_palavras_docs_C3 + 1;
        den = sum(sum(docs_C3)) + length(palavras_unicas_treino);
        prob_palavra_dado_C3 = num/den;

        docs_C4 = OCORRENCIAS_treino(double(classes_treino) == Cat(4),:);
        num_palavras_docs_C4 = sum(docs_C4);
        num = num_palavras_docs_C4 + 1;
        den = sum(sum(docs_C4)) + length(palavras_unicas_treino);
        prob_palavra_dado_C4 = num/den;

        for i=1:length(documentos_teste)
            for j = 1:length(documentos_teste{i}{1})
                if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                    % guarda indice i e j da palavra não pertencente às únicas
                    palavras_aux_1{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{1}{j}) = [];
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ ismember(documentos_teste{i}{2}{j}, palavras_unicas_treino)
                    palavras_aux_2{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{2}{j}) = [];
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

            for j = 1:length(documentos_teste{i}{1})
                if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C4 = log(prob_C4) + log(prob_palavra_dado_C4(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ strcmpi(string(documentos_teste{i}{2}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C4 = log(prob_C4) + log(prob_palavra_dado_C4(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                end
            end

            prob_testeC1 = prob_C1 * pC1;
            prob_testeC2 = prob_C2 * pC2;
            prob_testeC3 = prob_C3 * pC3;
            prob_testeC4 = prob_C4 * pC4;

            res = [res; prob_testeC1 prob_testeC2 prob_testeC3 prob_testeC4;];
        end
    elseif length(Cat) == 3
        pC1 = sum(double(classes_treino) == Cat(1)) / length(classes_treino);
        pC2 = sum(double(classes_treino) == Cat(2)) / length(classes_treino);
        pC3 = sum(double(classes_treino) == Cat(3)) / length(classes_treino);

        docs_C1 = OCORRENCIAS_treino(double(classes_treino) == Cat(1),:);
        num_palavras_docs_C1 = sum(docs_C1);
        num = num_palavras_docs_C1 + 1;
        den = sum(sum(docs_C1)) + length(palavras_unicas_treino);
        prob_palavra_dado_C1 = num/den;

        docs_C2 = OCORRENCIAS_treino(double(classes_treino) == Cat(2),:);
        num_palavras_docs_C2 = sum(docs_C2);
        num = num_palavras_docs_C2 + 1;
        den = sum(sum(docs_C2)) + length(palavras_unicas_treino);
        prob_palavra_dado_C2 = num/den;

        docs_C3 = OCORRENCIAS_treino(double(classes_treino) == Cat(3),:);
        num_palavras_docs_C3 = sum(docs_C3);
        num = num_palavras_docs_C3 + 1;
        den = sum(sum(docs_C3)) + length(palavras_unicas_treino);
        prob_palavra_dado_C3 = num/den;

        for i=1:length(documentos_teste)
            for j = 1:length(documentos_teste{i}{1})
                if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                    % guarda indice i e j da palavra não pertencente às únicas
                    palavras_aux_1{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{1}{j}) = [];
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ ismember(documentos_teste{i}{2}{j}, palavras_unicas_treino)
                    palavras_aux_2{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{2}{j}) = [];
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

            for j = 1:length(documentos_teste{i}{1})
                if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ strcmpi(string(documentos_teste{i}{2}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                end
            end

            prob_testeC1 = prob_C1 * pC1;
            prob_testeC2 = prob_C2 * pC2;
            prob_testeC3 = prob_C3 * pC3;

            res = [res; prob_testeC1 prob_testeC2 prob_testeC3;];
        end
    elseif length(Cat) == 2
        pC1 = sum(double(classes_treino) == Cat(1)) / length(classes_treino);
        pC2 = sum(double(classes_treino) == Cat(2)) / length(classes_treino);

        docs_C1 = OCORRENCIAS_treino(double(classes_treino) == Cat(1),:);
        num_palavras_docs_C1 = sum(docs_C1);
        num = num_palavras_docs_C1 + 1;
        den = sum(sum(docs_C1)) + length(palavras_unicas_treino);
        prob_palavra_dado_C1 = num/den;

        docs_C2 = OCORRENCIAS_treino(double(classes_treino) == Cat(2),:);
        num_palavras_docs_C2 = sum(docs_C2);
        num = num_palavras_docs_C2 + 1;
        den = sum(sum(docs_C2)) + length(palavras_unicas_treino);
        prob_palavra_dado_C2 = num/den;

        for i=1:length(documentos_teste)
            for j = 1:length(documentos_teste{i}{1})
                if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                    % guarda indice i e j da palavra não pertencente às únicas
                    palavras_aux_1{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{1}{j}) = [];
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ ismember(documentos_teste{i}{2}{j}, palavras_unicas_treino)
                    palavras_aux_2{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{2}{j}) = [];
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
    end
else
    if length(Cat) == 4
        pC1 = sum(double(classes_treino) == Cat(1)) / length(classes_treino);
        pC2 = sum(double(classes_treino) == Cat(2)) / length(classes_treino);
        pC3 = sum(double(classes_treino) == Cat(3)) / length(classes_treino);
        pC4 = sum(double(classes_treino) == Cat(4)) / length(classes_treino);

        docs_C1 = OCORRENCIAS_treino(double(classes_treino) == Cat(1),:);
        num_palavras_docs_C1 = sum(docs_C1);
        num = num_palavras_docs_C1 + 1;
        den = sum(sum(docs_C1)) + length(palavras_unicas_treino);
        prob_palavra_dado_C1 = num/den;

        docs_C2 = OCORRENCIAS_treino(double(classes_treino) == Cat(2),:);
        num_palavras_docs_C2 = sum(docs_C2);
        num = num_palavras_docs_C2 + 1;
        den = sum(sum(docs_C2)) + length(palavras_unicas_treino);
        prob_palavra_dado_C2 = num/den;

        docs_C3 = OCORRENCIAS_treino(double(classes_treino) == Cat(3),:);
        num_palavras_docs_C3 = sum(docs_C3);
        num = num_palavras_docs_C3 + 1;
        den = sum(sum(docs_C3)) + length(palavras_unicas_treino);
        prob_palavra_dado_C3 = num/den;

        docs_C4 = OCORRENCIAS_treino(double(classes_treino) == Cat(4),:);
        num_palavras_docs_C4 = sum(docs_C4);
        num = num_palavras_docs_C4 + 1;
        den = sum(sum(docs_C4)) + length(palavras_unicas_treino);
        prob_palavra_dado_C4 = num/den;

        for i=1:length(documentos_teste)
            for j = 1:length(documentos_teste{i}{1})
                if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                    % guarda indice i e j da palavra não pertencente às únicas
                    palavras_aux_1{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{1}{j}) = [];
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ ismember(documentos_teste{i}{2}{j}, palavras_unicas_treino)
                    palavras_aux_3{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{2}{j}) = [];
                end
            end
            for j = 1:length(documentos_teste{i}{3})
                if ~ ismember(documentos_teste{i}{3}{j}, palavras_unicas_treino)
                    palavras_aux_3{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{3}{j}) = [];
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
        for i=1:length(palavras_aux_3)
            j = palavras_aux_3{i};
            documentos_teste{j(1)}{3}{j(2)} = '';
        end

        for i=1:length(documentos_teste)
            prob_C1 = 1;
            prob_C2 = 1;
            prob_C3 = 1;
            prob_C4 = 1;

            for j = 1:length(documentos_teste{i}{1})
                if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C4 = log(prob_C4) + log(prob_palavra_dado_C4(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ strcmpi(string(documentos_teste{i}{2}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C4 = log(prob_C4) + log(prob_palavra_dado_C4(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                end
            end
            for j = 1:length(documentos_teste{i}{3})
                if ~ strcmpi(string(documentos_teste{i}{3}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{3}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{3}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{3}{j}));
                    prob_C4 = log(prob_C4) + log(prob_palavra_dado_C4(palavras_unicas_teste == documentos_teste{i}{3}{j}));
                end
            end

            prob_testeC1 = prob_C1 * pC1;
            prob_testeC2 = prob_C2 * pC2;
            prob_testeC3 = prob_C3 * pC3;
            prob_testeC4 = prob_C4 * pC4;

            res = [res; prob_testeC1 prob_testeC2 prob_testeC3 prob_testeC4;];
        end
    elseif length(Cat) == 3
        pC1 = sum(double(classes_treino) == Cat(1)) / length(classes_treino);
        pC2 = sum(double(classes_treino) == Cat(2)) / length(classes_treino);
        pC3 = sum(double(classes_treino) == Cat(3)) / length(classes_treino);

        docs_C1 = OCORRENCIAS_treino(double(classes_treino) == Cat(1),:);
        num_palavras_docs_C1 = sum(docs_C1);
        num = num_palavras_docs_C1 + 1;
        den = sum(sum(docs_C1)) + length(palavras_unicas_treino);
        prob_palavra_dado_C1 = num/den;

        docs_C2 = OCORRENCIAS_treino(double(classes_treino) == Cat(2),:);
        num_palavras_docs_C2 = sum(docs_C2);
        num = num_palavras_docs_C2 + 1;
        den = sum(sum(docs_C2)) + length(palavras_unicas_treino);
        prob_palavra_dado_C2 = num/den;

        docs_C3 = OCORRENCIAS_treino(double(classes_treino) == Cat(3),:);
        num_palavras_docs_C3 = sum(docs_C3);
        num = num_palavras_docs_C3 + 1;
        den = sum(sum(docs_C3)) + length(palavras_unicas_treino);
        prob_palavra_dado_C3 = num/den;

        for i=1:length(documentos_teste)
            for j = 1:length(documentos_teste{i}{1})
                if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                    % guarda indice i e j da palavra não pertencente às únicas
                    palavras_aux_1{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{1}{j}) = [];
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ ismember(documentos_teste{i}{2}{j}, palavras_unicas_treino)
                    palavras_aux_2{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{2}{j}) = [];
                end
            end
            for j = 1:length(documentos_teste{i}{3})
                if ~ ismember(documentos_teste{i}{3}{j}, palavras_unicas_treino)
                    palavras_aux_3{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{3}{j}) = [];
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
        for i=1:length(palavras_aux_3)
            j = palavras_aux_3{i};
            documentos_teste{j(1)}{3}{j(2)} = '';
        end

        for i=1:length(documentos_teste)
            prob_C1 = 1;
            prob_C2 = 1;
            prob_C3 = 1;

            for j = 1:length(documentos_teste{i}{1})
                if ~ strcmpi(string(documentos_teste{i}{1}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{1}{j}));
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ strcmpi(string(documentos_teste{i}{2}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{2}{j}));
                end
            end
            for j = 1:length(documentos_teste{i}{3})
                if ~ strcmpi(string(documentos_teste{i}{3}{j}), "")
                    prob_C1 = log(prob_C1) + log(prob_palavra_dado_C1(palavras_unicas_teste == documentos_teste{i}{3}{j}));
                    prob_C2 = log(prob_C2) + log(prob_palavra_dado_C2(palavras_unicas_teste == documentos_teste{i}{3}{j}));
                    prob_C3 = log(prob_C3) + log(prob_palavra_dado_C3(palavras_unicas_teste == documentos_teste{i}{3}{j}));
                end
            end

            prob_testeC1 = prob_C1 * pC1;
            prob_testeC2 = prob_C2 * pC2;
            prob_testeC3 = prob_C3 * pC3;

            res = [res; prob_testeC1 prob_testeC2 prob_testeC3;];
        end
    elseif length(Cat) == 2
        pC1 = sum(double(classes_treino) == Cat(1)) / length(classes_treino);
        pC2 = sum(double(classes_treino) == Cat(2)) / length(classes_treino);

        docs_C1 = OCORRENCIAS_treino(double(classes_treino) == Cat(1),:);
        num_palavras_docs_C1 = sum(docs_C1);
        num = num_palavras_docs_C1 + 1;
        den = sum(sum(docs_C1)) + length(palavras_unicas_treino);
        prob_palavra_dado_C1 = num/den;

        docs_C2 = OCORRENCIAS_treino(double(classes_treino) == Cat(2),:);
        num_palavras_docs_C2 = sum(docs_C2);
        num = num_palavras_docs_C2 + 1;
        den = sum(sum(docs_C2)) + length(palavras_unicas_treino);
        prob_palavra_dado_C2 = num/den;

        for i=1:length(documentos_teste)
            for j = 1:length(documentos_teste{i}{1})
                if ~ ismember(documentos_teste{i}{1}{j}, palavras_unicas_treino)
                    % guarda indice i e j da palavra não pertencente às únicas
                    palavras_aux_1{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{1}{j}) = [];
                end
            end
            for j = 1:length(documentos_teste{i}{2})
                if ~ ismember(documentos_teste{i}{2}{j}, palavras_unicas_treino)
                    palavras_aux_2{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{2}{j}) = [];
                end
            end
            for j = 1:length(documentos_teste{i}{3})
                if ~ ismember(documentos_teste{i}{3}{j}, palavras_unicas_treino)
                    palavras_aux_3{end+1} = [i,j];
                    palavras_unicas_teste(palavras_unicas_teste == documentos_teste{i}{3}{j}) = [];
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
        for i=1:length(palavras_aux_3)
            j = palavras_aux_3{i};
            documentos_teste{j(1)}{3}{j(2)} = '';
        end

        csvwrite('colunas_NB_2_Ocorrencias.csv', prob_palavra_dado_C1);

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

end