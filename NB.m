function [classes_added, classes_corretas, video_IDs,titles,channel_names,categories,tags,descriptions] = NB(Data, teste_row, treino_row, Cat, flag_tags, flag_perm, n_max_word, flag_no_descript)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% Permutar Data
if flag_perm
    perm = randperm(height(Data));
    Data = Data(perm, :);
end

% Obter os DATASETs
[Data, DATASET_TESTE, AUX_dataset, classes_corretas] = NB_obter_dataset_teste(Data, Cat, teste_row);
[DATASET_TREINO, classes_treino] = NB_obter_dataset_treino(Data, AUX_dataset, Cat, teste_row+treino_row);

% Obter palavras individuais das descrições e títulos no mesmo índice
if flag_tags & ~flag_no_descript
    [documentos_treinoC1,documentos_treinoC2,palavras_unicas_treinoC1,palavras_unicas_treinoC2] = NB_obter_palavras_unicas(false,true,classes_treino, DATASET_TREINO(:,3), DATASET_TREINO(:,16), DATASET_TREINO(:,7));
    [documentos_teste,irrelevante1,palavras_unicas_teste,irrelevante2] = NB_obter_palavras_unicas(false,false,classes_treino, DATASET_TESTE(:,3), DATASET_TESTE(:,16), DATASET_TESTE(:,7));
elseif flag_no_descript
    [documentos_treinoC1,documentos_treinoC2,palavras_unicas_treinoC1,palavras_unicas_treinoC2] = NB_obter_palavras_unicas(false,true,classes_treino, DATASET_TREINO(:,3), DATASET_TREINO(:,7));
    [documentos_teste,irrelevante1,palavras_unicas_teste,irrelevante2] = NB_obter_palavras_unicas(false,false,classes_treino, DATASET_TESTE(:,3), DATASET_TESTE(:,7));
else
    [documentos_treinoC1,documentos_treinoC2,palavras_unicas_treinoC1,palavras_unicas_treinoC2] = NB_obter_palavras_unicas(false,true,classes_treino, DATASET_TREINO(:,3), DATASET_TREINO(:,16));
    [documentos_teste,irrelevante1,palavras_unicas_teste,irrelevante2] = NB_obter_palavras_unicas(false,false,classes_treino, DATASET_TESTE(:,3), DATASET_TESTE(:,16));
end

% Obter array de ocorrencia de palavras do documento treino(documento x palavras_unicas)
[OCORRENCIAS_treinoC1, OCORRENCIAS_treinoC2, palavras_unicas_treinoC1] = NB_obter_num_ocorrencias(documentos_treinoC1, documentos_treinoC2, palavras_unicas_treinoC1, palavras_unicas_treinoC2);

% Cálculo da Classe dos Documentos de Teste
classes_probs = NB_calculo_classes(classes_treino, Cat, OCORRENCIAS_treinoC1, OCORRENCIAS_treinoC2, documentos_teste, palavras_unicas_teste, palavras_unicas_treinoC1, palavras_unicas_treinoC2, n_max_word);
classes_added = cell(height(classes_probs),1);

for i = 1:height(classes_probs)
    if classes_probs(i,1) < classes_probs(i,2)
        classes_added{i,1} = Cat(2);
    else
        classes_added{i,1} = Cat(1);
    end
end

for i = 1:height(DATASET_TESTE)
    DATASET_TESTE{i,5} = classes_added{i,1};
end
Dataset = [Data ; DATASET_TESTE]; 

video_IDs = Dataset(:,1);
titles = Dataset(:,3);
channel_names = Dataset(:,4);
categories = Dataset(:,5);
tags = Dataset(:,7);
descriptions = Dataset(:,16);

end