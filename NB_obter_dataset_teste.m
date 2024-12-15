function [Dataset, dataset_teste, aux_dataset, classes_corretas] = NB_obter_dataset_teste(Dataset, Cat, Total_rows)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dataset_teste = [];
aux_indices = [];
aux_dataset = zeros(1,length(Cat));
classes_corretas = [];


for i = 1:height(Dataset)
    for j = 1:length(Cat)
        if (double(Dataset{i,5}) == Cat(j) && aux_dataset(j) < (Total_rows/length(Cat)))
            dataset_teste = [dataset_teste ; Dataset(i,:)];
            aux_dataset(j) = aux_dataset(j) + 1;
            aux_indices = [i aux_indices];
            classes_corretas = [classes_corretas; categorical(Dataset{i,5})];
        end
    end
end

% Remover rows de teste1 do Data
AUX_indices = sort(aux_indices, 'descend');
for i = 1:length(AUX_indices)
    Dataset(AUX_indices(i),:) = [];
end

end