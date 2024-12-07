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
Cat = ["Film & Animation", "Music", "Sports", "Comedy", "News & Politics", "Education", "Science & Tech"];

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

[documentos_treino1,palavras_unicas_treino1] = obter_palavras_unicas(titles_treino1, descriptions_treino1);
[documentos_treino2,palavras_unicas_treino2] = obter_palavras_unicas(titles_treino2, descriptions_treino2);
[documentos_teste1,palavras_unicas_teste1] = obter_palavras_unicas(titles_teste1, descriptions_teste1);
[documentos_teste2,palavras_unicas_teste2] = obter_palavras_unicas(titles_teste2, descriptions_teste2);

% Obter array de ocorrencia de palavras do documento (documento x palavras_unicas)
OCORRENCIAS_treino1 = obter_num_ocorrencias(documentos_treino1, palavras_unicas_treino1);
OCORRENCIAS_treino2 = obter_num_ocorrencias(documentos_treino2, palavras_unicas_treino2);

% Obter classes dos documentos de treino
classes_treino1 = [];
for i = 1:length(DATASET_TREINO1)
    classes_treino1 = [classes_treino1 categorical(DATASET_TREINO1{i,5})];
end

classes_treino2 = [];
for i = 1:length(DATASET_TREINO2)
    classes_treino2 = [classes_treino2 categorical(DATASET_TREINO2{i,5})];
end


%% TODO: FINALIZAR COM CÁLCULOS
palavras_aux_1 = {};
palavras_aux_2 = {};
res = [];
prob_C1 = 1;
prob_C2 = 1;
pC1 = sum(classes_treino1 == 'Film & Animation') / length(classes_treino1);
pC2 = sum(classes_treino1 == 'Comedy') / length(classes_treino1);

docs_C1 = OCORRENCIAS_treino1(classes_treino1 == "Film & Animation",:);
num_palavras_docs_C1 = sum(docs_C1);
num = num_palavras_docs_C1 + 1;
den = sum(sum(docs_C1)) + length(palavras_unicas_teste1);
prob_palavra_dado_C1 = num/den;

docs_C2 = OCORRENCIAS_treino1(classes_treino1 == "Comedy",:);
num_palavras_docs_C2 = sum(docs_C2);
num = num_palavras_docs_C2 + 1;
den = sum(sum(docs_C2)) + length(palavras_unicas_teste1);
prob_palavra_dado_C2 = num/den;

for i=1:length(documentos_teste1)
    if (isa(documentos_teste1{i}{2}, 'cell'))
        for j = 1:length(documentos_teste1{i}{1})
            if ~ ismember(documentos_teste1{i}{1}{j}, palavras_unicas_treino1)
                % guarda indice i e j da palavra não pertencente às únicas
                palavras_aux_1{end+1} = [i,j];
            end
        end
        for j = 1:length(documentos_teste1{i}{2})
            if ~ ismember(documentos_teste1{i}{2}{j}, palavras_unicas_treino1)
                palavras_aux_2{end+1} = [i,j];
            end
        end
    else
        for j = 1:length(documentos_teste1{i}{1})
            if ~ ismember(documentos_teste1{i}{1}{j}, palavras_unicas_treino1)
                palavras_aux_1{end+1} = [i,j];
            end
        end
    end
end

for i=1:length(palavras_aux_1)
    j = palavras_aux_1{i};
    documentos_teste1{j(1)}{1}{j(2)} = '';
end

for i=1:length(palavras_aux_2)
    j = palavras_aux_2{i};
    documentos_teste1{j(1)}{2}{j(2)} = '';
end

% TODO: ADICIONAR AS RESTANTES CATEGORIAS E COLOCAR CÓDIGO REPETITIVO EM
%           FUNÇÕES
for i=1:length(documentos_teste1)
    prob_C1 = 1;
    prob_C2 = 1;
    if (isa(documentos_teste1{i}{2}, 'cell') )
        for j = 1:length(documentos_teste1{i}{1})
            if ~ strcmpi(string(documentos_teste1{i}{1}{j}), "")
                prob_C1 = prob_C1 * prob_palavra_dado_C1(palavras_unicas_teste1 == documentos_teste1{i}{1}{j});
                prob_C2 = prob_C2 * prob_palavra_dado_C2(palavras_unicas_teste1 == documentos_teste1{i}{1}{j});
            end
        end
        for j = 1:length(documentos_teste1{i}{2})
            if ~ strcmpi(string(documentos_teste1{i}{2}{j}), "")
                prob_C1 = prob_C1 * prob_palavra_dado_C1(palavras_unicas_teste1 == documentos_teste1{i}{2}{j});
                prob_C2 = prob_C2 * prob_palavra_dado_C2(palavras_unicas_teste1 == documentos_teste1{i}{2}{j});
            end
        end
    else
        for j = 1:length(documentos_teste1{i}{1})
            if ~ strcmpi(string(documentos_teste1{i}{1}{j}), "")
                prob_C1 = prob_C1 * prob_palavra_dado_C1(palavras_unicas_teste1 == documentos_teste1{i}{1}{j});
                prob_C2 = prob_C2 * prob_palavra_dado_C2(palavras_unicas_teste1 == documentos_teste1{i}{1}{j});
            end
        end
    end
    prob_testeC1 = prob_C1 * pC1;
    prob_testeC2 = prob_C2 * pC2;

    res = [res; prob_testeC1 prob_testeC2;];
end


%% SECÇÃO DE TESTES

