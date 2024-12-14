function [dataset_treino, classes_treino] = NB_obter_dataset_treino(Dataset, Aux_dataset, Cat, Total_rows, flag_tag)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

dataset_treino = [];
classes_treino = [];

if flag_tag
    for i = 1:height(Dataset)
        for j = 1:length(Cat)
            if (strcmp(string(Dataset{i,5}),Cat(j)) & Aux_dataset(j) < Total_rows/length(Cat) )
                dataset_treino = [dataset_treino;Dataset(i,3) Dataset(i,16) Dataset(i,7)];
                Aux_dataset(j) = Aux_dataset(j) + 1;
                classes_treino = [classes_treino; categorical(Dataset{i,5})];
            end
        end
    end
else
    for i = 1:height(Dataset)
        for j = 1:length(Cat)
            if (strcmp(string(Dataset{i,5}),Cat(j)) & Aux_dataset(j) < Total_rows/length(Cat) )
                dataset_treino = [dataset_treino;Dataset(i,3) Dataset(i,16)];
                Aux_dataset(j) = Aux_dataset(j) + 1;
                classes_treino = [classes_treino; categorical(Dataset{i,5})];
            end
        end
    end
end

end