%% ler dataset
clear all;
clc

T = readcell("USvideos.csv");
aux = T(2:end,:);


%% Alterar Dataset
% 1,10,17,22,23,24,25,26,27,28 categorias > 1000 vídeos
% Film & Animation, Music, Sports, People & Blogs, Comedy, Entertainment,
%   News & Politics, Howto & Style, Education, Science & Tech

% 2 datasets treino:
%   1º -> 1, 17, 23 e 27 = 105*4 = 420 
%   2º -> 10, 25 e 28 = 140*3 = 420

% 2 datasets teste:
%   1º -> 1, 17, 23 e 27 = 15*4 = 60 
%   2º -> 10, 25 e 28 = 20*3 = 60

DATASET_TREINO1 = [];
DATASET_TREINO2 = [];
DATASET_TESTE1 = [];
DATASET_TESTE2 = [];
AUX_dataset1 = zeros(1,4);
AUX_dataset2 = zeros(1,3);
AUX_indices = [];
Cat = ["Film & Animation","Music", "Sports", "Comedy", "News & Politics", "Education", "Science & Tech"];
Cat1 = ["Film & Animation", "Sports", "Comedy", "Education"];
Cat2 = ["Music", "News & Politics", "Science & Tech"];

for i = 1:length(aux)
    if(aux{i,5} == 1)
        % cat1
        % TODO: VERIFICAR SE TRING OU CHAR MELHOR
        aux{i,5} = Cat(1);
    elseif(aux{i,5} == 10)
        % cat10
        aux{i,5} = Cat(2);
    elseif(aux{i,5} == 17)
        % cat17
        aux{i,5} = Cat(3);
    elseif(aux{i,5} == 23)
        % cat23
        aux{i,5} = Cat(4);
    elseif(aux{i,5} == 25)
        % cat25
        aux{i,5} = Cat(5);
    elseif(aux{i,5} == 27)
        % cat27
        aux{i,5} = Cat(6);
    elseif(aux{i,5} == 28)
        % cat28
        aux{i,5} = Cat(7);
    end
end

% Obter os 2 datasets de teste (DATASET_TESTE1 e DATASET_TESTE2)
for i = 1:length(aux)
    if(strcmp(aux{i,5},Cat(1)) & AUX_dataset1(1) < 15)
        % cat1
        % TODO: VERIFICAR SE TRING OU CHAR MELHOR
        DATASET_TESTE1 = [DATASET_TESTE1;aux(i,:)];
        AUX_dataset1(1) = AUX_dataset1(1) + 1;
        AUX_indices = [i AUX_indices];
    elseif(strcmp(aux{i,5},Cat(2)) & AUX_dataset2(1) < 20)
        % cat10
        DATASET_TESTE2 = [DATASET_TESTE2;aux(i,:)];
        AUX_dataset2(1) = AUX_dataset2(1) + 1;
        AUX_indices = [i AUX_indices];
    elseif(strcmp(aux{i,5},Cat(3)) & AUX_dataset1(2) < 15)
        % cat17
        DATASET_TESTE1 = [DATASET_TESTE1;aux(i,:)];
        AUX_dataset1(2) = AUX_dataset1(2) + 1;
        AUX_indices = [i AUX_indices];
    elseif(strcmp(aux{i,5},Cat(4)) & AUX_dataset1(3) < 15)
        % cat23
        DATASET_TESTE1 = [DATASET_TESTE1;aux(i,:)];
        AUX_dataset1(3) = AUX_dataset1(3) + 1;
        AUX_indices = [i AUX_indices];
    elseif(strcmp(aux{i,5},Cat(5)) & AUX_dataset2(2) < 20)
        % cat25
        DATASET_TESTE2 = [DATASET_TESTE2;aux(i,:)];
        AUX_dataset2(2) = AUX_dataset2(2) + 1;
        AUX_indices = [i AUX_indices];
    elseif(strcmp(aux{i,5},Cat(6)) & AUX_dataset1(4) < 15)
        % cat27
        DATASET_TESTE1 = [DATASET_TESTE1;aux(i,:)];
        AUX_dataset1(4) = AUX_dataset1(4) + 1;
        AUX_indices = [i AUX_indices];
    elseif(strcmp(aux{i,5},Cat(7)) & AUX_dataset2(3) < 20)
        % cat28
        DATASET_TESTE2 = [DATASET_TESTE2;aux(i,:)];
        AUX_dataset2(3) = AUX_dataset2(3) + 1;
        AUX_indices = [i AUX_indices];
    end
end

% Remover rows de teste do dataset "completo"
AUX_indices = sort(AUX_indices, 'descend');
for i = 1:length(AUX_indices)
    aux(i,:) = [];
end


% TODO: REALIZAR PERMUTAÇÃO DE T PARA OBTER DATASETS TREINO DIFERENTES

for i = 1:length(aux)
    if(strcmp(aux{i,5},Cat(1)) & AUX_dataset1(1) < 120)
        % cat1
        DATASET_TREINO1 = [DATASET_TREINO1;aux(i,:)];
        AUX_dataset1(1) = AUX_dataset1(1) + 1;
    elseif(strcmp(aux{i,5},Cat(2)) & AUX_dataset2(1) < 160)
        % cat10
        DATASET_TREINO2 = [DATASET_TREINO2;aux(i,:)];
        AUX_dataset2(1) = AUX_dataset2(1) + 1;
    elseif(strcmp(aux{i,5},Cat(3)) & AUX_dataset1(2) < 120)
        % cat17
        DATASET_TREINO1 = [DATASET_TREINO1;aux(i,:)];
        AUX_dataset1(2) = AUX_dataset1(2) + 1;
    elseif(strcmp(aux{i,5},Cat(4)) & AUX_dataset1(3) < 120)
        % cat23
        DATASET_TREINO1 = [DATASET_TREINO1;aux(i,:)];
        AUX_dataset1(3) = AUX_dataset1(3) + 1;
    elseif(strcmp(aux{i,5},Cat(5)) & AUX_dataset2(2) < 160)
        % cat25
        DATASET_TREINO2 = [DATASET_TREINO2;aux(i,:)];
        AUX_dataset2(2) = AUX_dataset2(2) + 1;
    elseif(strcmp(aux{i,5},Cat(6)) & AUX_dataset1(4) < 120)
        % cat27
        DATASET_TREINO1 = [DATASET_TREINO1;aux(i,:)];
        AUX_dataset1(4) = AUX_dataset1(4) + 1;
    elseif(strcmp(aux{i,5},Cat(7)) & AUX_dataset2(3) < 160)
        % cat28
        DATASET_TREINO2 = [DATASET_TREINO2;aux(i,:)];
        AUX_dataset2(3) = AUX_dataset2(3) + 1;
    end
end


%% Naive Bayes - Separação dos documentos a analisar

% Obter palavras individuais das descrições e títulos no mesmo índice
titles_teste1 = DATASET_TESTE1(:,3);
titles_teste2 = DATASET_TESTE2(:,3);
titles_treino1 = DATASET_TREINO1(:,3);
titles_treino2 = DATASET_TREINO2(:,3);

descriptions_teste1 = DATASET_TESTE1(:,16);
descriptions_teste2 = DATASET_TESTE2(:,16);
descriptions_treino1 = DATASET_TREINO1(:,16);
descriptions_treino2 = DATASET_TREINO2(:,16);

[documentos_treino1,palavras_unicas_treino1] = NB_obter_palavras_unicas(titles_treino1, descriptions_treino1);
[documentos_treino2,palavras_unicas_treino2] = NB_obter_palavras_unicas(titles_treino2, descriptions_treino2);
[documentos_teste1,palavras_unicas_teste1] = NB_obter_palavras_unicas(titles_teste1, descriptions_teste1);
[documentos_teste2,palavras_unicas_teste2] = NB_obter_palavras_unicas(titles_teste2, descriptions_teste2);

% Obter array de ocorrencia de palavras do documento (documento x palavras_unicas)
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
valor_max = zeros(60, 1); 
indice_max = zeros(60, 1);
teste1 = [];
for i = 1:60
    [valor_max(i), indice_max(i)] = max(res1(i, :));
end

for i = 1:length(indice_max)
    if (string(DATASET_TESTE1{i,5}) == Cat1(indice_max(i)))
        teste1(i) = 1;
    else
        teste1(i) = 0;
    end
end

sum(teste1) / 60

% RES2
valor_max = zeros(60, 1); 
indice_max = zeros(60, 1);
teste2 = [];
for i = 1:60
    [valor_max(i), indice_max(i)] = max(res2(i, :));
end

for i = 1:length(indice_max)
    if (string(DATASET_TESTE1{i,5}) == Cat2(indice_max(i)))
        teste2(i) = 1;
    else
        teste2(i) = 0;
    end
end

sum(teste2) / 60

