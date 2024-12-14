function [classes_added, classes_corretas, DATASET_TESTE] = NB(Data, teste_row, treino_row, Cat, flag_tags, docs_col_n, perm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Permutar Data
if perm
    perm = randperm(height(Data));
    Data = Data(perm, :);
end

% Obter os DATASETs
[DATASET_TESTE, AUX_dataset, classes_corretas] = NB_obter_dataset_teste(Data, Cat, teste_row, flag_tags);
[DATASET_TREINO, classes_treino] = NB_obter_dataset_treino(Data, AUX_dataset, Cat, teste_row+treino_row, flag_tags);

% Obter palavras individuais das descrições e títulos no mesmo índice
if flag_tags
    [documentos_treino,palavras_unicas_treino] = NB_obter_palavras_unicas(DATASET_TREINO(:,1), DATASET_TREINO(:,2), DATASET_TREINO(:,3));
    [documentos_teste,palavras_unicas_teste] = NB_obter_palavras_unicas(DATASET_TESTE(:,1), DATASET_TESTE(:,2), DATASET_TESTE(:,3));
else
    [documentos_treino,palavras_unicas_treino] = NB_obter_palavras_unicas(DATASET_TREINO(:,1), DATASET_TREINO(:,2));
    [documentos_teste,palavras_unicas_teste] = NB_obter_palavras_unicas(DATASET_TESTE(:,1), DATASET_TESTE(:,2));
end

% Obter array de ocorrencia de palavras do documento treino(documento x palavras_unicas)
[OCORRENCIAS_treino, palavras_unicas_treino] = NB_obter_num_ocorrencias(documentos_treino, palavras_unicas_treino, docs_col_n);


% Cálculo da Classe dos Documentos de Teste
classes_probs = NB_calculo_classes(classes_treino, Cat, OCORRENCIAS_treino, documentos_teste, palavras_unicas_teste, palavras_unicas_treino);
classes_added = cell(height(classes_probs),1);

for i = 1:height(classes_probs)
    if classes_probs(i,1) < classes_probs(i,2)
        classes_added{i,1} = Cat(2);
    else
        classes_added{i,1} = Cat(1);
    end
end

DATASET_TESTE = [DATASET_TESTE classes_added];

end