function [] = NB_test_func(Data, Cat, vp_str, teste_row, treino_row, flag_tags, docs_col_n, nome_fich)
% Testes do Naive Bayes (utiliza a matriz de confusão para obter recall, precision e F1) 
%   TODO: EXPLICAR ARGUMENTOS

% Permutar Data
perm = randperm(height(Data));
Data = Data(perm, :);

% tp - 1, fp - 2, tn - 3, fn - 4
confusion_M = zeros(1,4);

id = fopen(fullfile('testes', nome_fich), 'a');
if id == -1
    error('Failed to open file: %s', nome_fich);
end

try
    fprintf(id, "\n ----- Novo Teste -----\n");
catch e
    fclose(id);
    rethrow(e);
end

for j = 1:length(teste_row)
    for k = 1:length(treino_row)
        [classes_added, classes_corretas] = NB(Data, teste_row(j), treino_row(k), Cat, flag_tags, docs_col_n, false);
        for i = 1:height(classes_added)
            if strcmp(string(classes_added{i}), string(classes_corretas(i))) & strcmp(string(classes_added{i}), string(vp_str))
                confusion_M(1) = confusion_M(1) + 1;    %tp
            elseif strcmp(string(classes_added{i}), string(classes_corretas(i))) & ~ strcmp(string(classes_added{i}), string(vp_str))
                confusion_M(3) = confusion_M(3) + 1;    %tn
            elseif ~ strcmp(string(classes_added{i}), string(classes_corretas(i))) & strcmp(string(classes_added{i}), string(vp_str))
                confusion_M(4) = confusion_M(4) + 1;    %fn
            else
                confusion_M(2) = confusion_M(2) + 1;    %fp
            end
        end

        recall = confusion_M(1)/(confusion_M(1)+confusion_M(4));
        precision = confusion_M(1)/(confusion_M(1)+confusion_M(2));
        F1 = 2*recall*precision/(precision+recall);

        try
            fprintf(id, "\nlinhas de teste = %d e linhas de treino = %d\n", teste_row(j),treino_row(k));
            fprintf(id, "recall: %f; precision: %f; F1: %f\n", recall,precision,F1);
            fprintf(id, "-----\n");
        catch e
            fclose(id);
            rethrow(e);
        end
    end
end

fclose(id);


end