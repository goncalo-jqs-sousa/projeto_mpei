%% ler dataset
% TODO: SEPARAR ESTE FICHEIRO EM 2 FUNÇÕES E ADICIONAR O RESPETIVO CODIGO
%           NO MAIN
clear all;
clc

T = readcell("USvideos.csv");
DATASET = T(2:end,:);


%% Alterar Dataset
% 1,10,17,22,23,24,25,26,27,28 categorias > 1000 vídeos
% Film & Animation, Music, Sports, People & Blogs, Comedy, Entertainment,
%   News & Politics, Howto & Style, Education, Science & Tech
teste1_row = 800;
teste2_row = 800;
treino1_row = 200;
treino2_row = 50;

AUX_indices = [];

Cat = ["Film & Animation","Music", "Sports", "Comedy", "News & Politics", "Education", "Science & Tech"];
Cat1 = ["Film & Animation", "Sports", "Comedy", "Education"];
Cat2 = ["Music", "News & Politics", "Science & Tech"];
% Cat2 = ["Music", "News & Politics"];
% Cat2 = ["Music", "Comedy"];

for i = 1:length(DATASET)
    if(double(DATASET{i,5}) == 1)
        % cat1 - Film & Animation
        DATASET{i,5} = Cat(1);
    elseif(double(DATASET{i,5}) == 10)
        % cat10 - Music
        DATASET{i,5} = Cat(2);
    elseif(double(DATASET{i,5}) == 17)
        % cat17 - Sports
        DATASET{i,5} = Cat(3);
    elseif(double(DATASET{i,5}) == 23)
        % cat23 - Comedy
        DATASET{i,5} = Cat(4);
    elseif(double(DATASET{i,5}) == 25)
        % cat25 - News & Politics
        DATASET{i,5} = Cat(5);
    elseif(double(DATASET{i,5}) == 27)
        % cat27 - Education
        DATASET{i,5} = Cat(6);
    elseif(double(DATASET{i,5}) == 28)
        % cat28 - Science & Tech
        DATASET{i,5} = Cat(7);
    else
        AUX_indices = [i AUX_indices];
    end
end

% % Remover rows de classes irrelevantes do dataset "completo"
% AUX_indices = sort(AUX_indices, 'descend');
% for i = 1:length(AUX_indices)
%     DATASET(AUX_indices(i), :) = [];
% end

% Obter os 2 datasets de teste (DATASET_TESTE1 e DATASET_TESTE2)
[DATASET_TESTE1, AUX_dataset1, AUX_indices1] = NB_obter_dataset_teste(DATASET, Cat1, teste1_row);
[DATASET_TESTE2, AUX_dataset2, AUX_indices2] = NB_obter_dataset_teste(DATASET, Cat2, teste2_row);


% Remover rows de teste do dataset "completo"
AUX_indices = sort(AUX_indices1, 'descend');
for i = 1:length(AUX_indices)
    DATASET(AUX_indices(i),:) = [];
end

AUX_indices = sort(AUX_indices2, 'descend');
for i = 1:length(AUX_indices)
    DATASET(AUX_indices(i),:) = [];
end


% TODO: REALIZAR PERMUTAÇÃO DE T PARA OBTER DATASETS TREINO DIFERENTES

DATASET_TREINO1 = NB_obter_dataset_treino(DATASET, AUX_dataset1, Cat1, teste1_row+treino1_row);
DATASET_TREINO2 = NB_obter_dataset_treino(DATASET, AUX_dataset2, Cat2, teste2_row+treino2_row); 


%% Naive Bayes - Separação dos documentos a analisar

% Obter palavras individuais das descrições e títulos no mesmo índice
[documentos_treino1,palavras_unicas_treino1] = NB_obter_palavras_unicas(DATASET_TREINO1(:,3), DATASET_TREINO1(:,16));
[documentos_treino2,palavras_unicas_treino2] = NB_obter_palavras_unicas(DATASET_TREINO2(:,3), DATASET_TREINO2(:,16));
[documentos_teste1,palavras_unicas_teste1] = NB_obter_palavras_unicas(DATASET_TESTE1(:,3), DATASET_TESTE1(:,16));
[documentos_teste2,palavras_unicas_teste2] = NB_obter_palavras_unicas(DATASET_TESTE2(:,3), DATASET_TESTE2(:,16));

% Obter array de ocorrencia de palavras do documento treino(documento x palavras_unicas)
OCORRENCIAS_treino1 = NB_obter_num_ocorrencias(documentos_treino1, palavras_unicas_treino1);
OCORRENCIAS_treino2 = NB_obter_num_ocorrencias(documentos_treino2, palavras_unicas_treino2);

% Obter classes dos documentos de treino
classes_treino1 = [];
for i = 1:length(DATASET_TREINO1)
    classes_treino1 = [classes_treino1 categorical(DATASET_TREINO1{i,5})];
end

classes_treino2 = [];
for i = 1:length(DATASET_TREINO2)
    classes_treino2 = [classes_treino2 categorical(DATASET_TREINO2{i,5})];
end


%% Naive Bayes - Cálculo da Classe dos Documentos de Teste
res1 = NB_calculo_classes(classes_treino1, Cat1, OCORRENCIAS_treino1, documentos_teste1, palavras_unicas_teste1, palavras_unicas_treino1);
res2 = NB_calculo_classes(classes_treino2, Cat2, OCORRENCIAS_treino2, documentos_teste2, palavras_unicas_teste2, palavras_unicas_treino2);


%% SECÇÃO DE TESTES

% RES1
valor_max = zeros(length(DATASET_TESTE1), 1); 
indice_max = zeros(length(DATASET_TESTE1), 1);
teste1 = [];
for i = 1:length(DATASET_TESTE1)
    [valor_max(i), indice_max(i)] = max(res1(i, :));
end

for i = 1:length(indice_max)
    if (string(DATASET_TESTE1{i,5}) == Cat1(indice_max(i)))
        teste1(i) = 1;
    else
        teste1(i) = 0;
    end
end

sum(teste1) / length(DATASET_TESTE1)

% RES2
valor_max = zeros(length(DATASET_TESTE2), 1); 
indice_max = zeros(length(DATASET_TESTE2), 1);
teste2 = [];
for i = 1:length(DATASET_TESTE2)
    [valor_max(i), indice_max(i)] = max(res2(i, :));
end

for i = 1:length(indice_max)
    if (string(DATASET_TESTE2{i,5}) == Cat2(indice_max(i)))
        teste2(i) = 1;
    else
        teste2(i) = 0;
    end
end

sum(teste2) / length(DATASET_TESTE2)

