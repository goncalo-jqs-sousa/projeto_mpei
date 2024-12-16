function [OCORRENCIA_C1, OCORRENCIA_C2, palavras_unicas_treino] = NB_obter_num_ocorrencias(documentosC1,documentosC2,palavras_unicasC1,palavras_unicasC2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
OCORRENCIA_C1 = zeros(length(documentosC1), length(palavras_unicasC1));
OCORRENCIA_C2 = zeros(length(documentosC2), length(palavras_unicasC2));
palavras_unicas_treino = palavras_unicasC1;

if length(documentosC1{1}) == 2
    for i = 1:length(documentosC1)
        rows1 = documentosC1{i}{1};
        rows2 = documentosC1{i}{2};

        for j = 1:length(palavras_unicasC1)
            aux = palavras_unicasC1{j};
            num_ocorrencias = sum(strcmpi(rows1, aux));
            num_ocorrencias = num_ocorrencias + sum(strcmpi(rows2, aux));
            if num_ocorrencias > 1
                num_ocorrencias = 1;
            end
            OCORRENCIA_C1(i, j) = num_ocorrencias;
        end
    end
else
    for i = 1:length(documentosC1)
        rows1 = documentosC1{i}{1};
        rows2 = documentosC1{i}{2};
        rows3 = documentosC1{i}{3};


        for j = 1:length(palavras_unicasC1)
            aux = palavras_unicasC1{j};
            num_ocorrencias = sum(strcmpi(rows1, aux));
            num_ocorrencias = num_ocorrencias + sum(strcmpi(rows2, aux));
            num_ocorrencias = num_ocorrencias + sum(strcmpi(rows3, aux));
            if num_ocorrencias > 1
                num_ocorrencias = 1;
            end
            OCORRENCIA_C1(i, j) = num_ocorrencias;
        end
    end
    for i = 1:length(documentosC2)
        rows1 = documentosC2{i}{1};
        rows2 = documentosC2{i}{2};
        rows3 = documentosC2{i}{3};


        for j = 1:length(palavras_unicasC2)
            aux = palavras_unicasC2{j};
            num_ocorrencias = sum(strcmpi(rows1, aux));
            num_ocorrencias = num_ocorrencias + sum(strcmpi(rows2, aux));
            num_ocorrencias = num_ocorrencias + sum(strcmpi(rows3, aux));
            if num_ocorrencias > 1
                num_ocorrencias = 1;
            end
            OCORRENCIA_C2(i, j) = num_ocorrencias;
        end
    end
end


end