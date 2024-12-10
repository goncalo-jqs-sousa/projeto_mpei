function OCORRENCIA = NB_obter_num_ocorrencias(documentos,palavras_unicas)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

OCORRENCIA = zeros(length(documentos), length(palavras_unicas));

for i = 1:length(documentos)
    rows1 = documentos{i}{1};
    rows2 = documentos{i}{2};

    for j = 1:length(palavras_unicas)
        aux = palavras_unicas{j};
        num_ocorrencias = sum(strcmpi(rows1, aux));
        num_ocorrencias = num_ocorrencias + sum(strcmpi(rows2, aux));
        OCORRENCIA(i, j) = num_ocorrencias;
    end
end

end