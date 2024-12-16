function Set = MH_criar_conjunto(recommended_category_titles_from_history,k_shingle)
    
    nomes = recommended_category_titles_from_history;
    Set = {};

    for i = 1:length(nomes)
        Set{end+1} = nomes{1,i};
    end
    
    for i = 1:length(nomes)
        string = char(nomes{i}{1});
        lista_shingles = {};
        length(string)
        for pos = 1:length(string)-k_shingle+1
            shingle = string(pos:(pos+k_shingle-1));
            lista_shingles{end+1} = shingle;
            if length(shingle) ~= k_shingle
                fprintf(1,"Tamanho do shingle diferentes");
                return
            end
        end
        Set{i} = lista_shingles;
    end
end