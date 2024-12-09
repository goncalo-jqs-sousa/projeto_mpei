function dataset_treino = NB_obter_dataset_treino(Dataset, Aux_dataset, Cat, Total_rows)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

dataset_treino = [];

for i = 1:length(Dataset)
    for j = 1:length(Cat)
        if(strcmp(string(Dataset{i,5}),Cat(j)) & Aux_dataset(j) < Total_rows/length(Cat) )
            dataset_treino = [dataset_treino;Dataset(i,:)];
            Aux_dataset(j) = Aux_dataset(j) + 1;
        end
    end
end

end