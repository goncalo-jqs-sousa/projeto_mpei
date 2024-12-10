function [dataset_teste, aux_dataset, aux_indices] = NB_obter_dataset_teste(Dataset, Cat, Total_rows)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dataset_teste = [];
aux_indices = [];
aux_dataset = zeros(1,length(Cat));

for i = 1:length(Dataset)
    for j = 1:length(Cat)
        if(strcmp(string(Dataset{i,5}),Cat(j)) & aux_dataset(j) < (Total_rows/length(Cat)) )
            dataset_teste = [dataset_teste;Dataset(i,:)];
            aux_dataset(j) = aux_dataset(j) + 1;
            aux_indices = [i aux_indices];
        end
    end
end

end