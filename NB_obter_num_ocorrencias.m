function [OCORRENCIA, palavras_unicas_treino] = NB_obter_num_ocorrencias(documentos,palavras_unicas, docs_col_n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

OCORRENCIA = zeros(length(documentos), length(palavras_unicas));
palavras_unicas_treino = palavras_unicas;

if length(documentos{1}) == 2
    for i = 1:length(documentos)
        rows1 = documentos{i}{1};
        rows2 = documentos{i}{2};

        for j = 1:length(palavras_unicas)
            aux = palavras_unicas{j};
            num_ocorrencias = sum(strcmpi(rows1, aux));
            num_ocorrencias = num_ocorrencias + sum(strcmpi(rows2, aux));
            if num_ocorrencias > 1
                num_ocorrencias = 1;
            end
            OCORRENCIA(i, j) = num_ocorrencias;
        end
    end

    if docs_col_n > 1
        % Ficar só com palavras com n palavras em pelo menos 1 documento
        aux = [];
        OCORRENCIA_aux = OCORRENCIA;
        % iterar pelas linhas e colunas e ficar com colunas com n palavras para pelo menos 1 linha
        for i = 1:height(OCORRENCIA_aux)
            for j = 1:width(OCORRENCIA_aux)
                if OCORRENCIA_aux(i,j) >= docs_col_n
                    aux = [aux j];
                end
            end
        end

        aux = unique(aux);
        OCORRENCIA = [];
        palavras_unicas_treino = [];

        for j = 1:length(aux)
            palavras_unicas_treino = [palavras_unicas_treino palavras_unicas(aux(j))];
            OCORRENCIA = [OCORRENCIA OCORRENCIA_aux(:,aux(j))];
        end
        palavras_unicas_treino = unique(palavras_unicas_treino);
    end
else
    for i = 1:length(documentos)
        rows1 = documentos{i}{1};
        rows2 = documentos{i}{2};
        rows3 = documentos{i}{3};


        for j = 1:length(palavras_unicas)
            aux = palavras_unicas{j};
            num_ocorrencias = sum(strcmpi(rows1, aux));
            num_ocorrencias = num_ocorrencias + sum(strcmpi(rows2, aux));
            num_ocorrencias = num_ocorrencias + sum(strcmpi(rows3, aux));
            if num_ocorrencias > 1
                num_ocorrencias = 1;
            end
            OCORRENCIA(i, j) = num_ocorrencias;
        end
    end

    if docs_col_n > 1
        % Ficar só com palavras com n palavras em pelo menos 1 documento
        aux = [];
        OCORRENCIA_aux = OCORRENCIA;
        % iterar pelas linhas e colunas e ficar com colunas com n palavras para pelo menos 1 linha
        for i = 1:height(OCORRENCIA_aux)
            for j = 1:width(OCORRENCIA_aux)
                if OCORRENCIA_aux(i,j) >= docs_col_n
                    aux = [aux j];
                end
            end
        end

        aux = unique(aux);
        OCORRENCIA = [];
        palavras_unicas_treino = [];

        for j = 1:length(aux)
            palavras_unicas_treino = [palavras_unicas_treino palavras_unicas(aux(j))];
            OCORRENCIA = [OCORRENCIA OCORRENCIA_aux(:,aux(j))];
        end
        palavras_unicas_treino = unique(palavras_unicas_treino);
    end
end

end