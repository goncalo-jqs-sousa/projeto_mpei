function [documentos,palavras_unicas] = NB_obter_palavras_unicas(titles,descriptions)
% Obtem as palavras_unicas dos titulos e descrições da mesma linha.
% Tem como input os conjuntos dos titulos e descrições e retorna um conjunto de documentos com conjuntos de ambos dentro no formato de string, bem como um array de strings com as palavras unicas dos documentos  

palavras_titulo = {};
palavras_descricao = {};

both = [titles; descriptions];
removeWords = ["patreon", "Patreon", "twitter", "Twitter", "Merch", "merch", "Instagram", "instagram", "TikTok", "tiktok", "Facebook", "facebook", "Twitch", "twitch", "Pinterest", "pinterest", "Spotify", "spotify"];

for i = 1:length(both)/2
    both{i} = regexprep(both{i}, 'http[s]?://\S+', ' ');
    both{i} = regexprep(both{i}, '\r?\n', ' ');
    both{i} = regexprep(both{i}, '[^a-zA-Z0-9#]', ' ');
    aux_titulo = split(both{i}, " ");
    aux_titulo(ismember(aux_titulo, removeWords) | strlength(aux_titulo) == 0) = [];
    aux_titulo = aux_titulo.';
    palavras_titulo{end+1} = {aux_titulo};
    if (~ismissing(both{length(both)/2+i}))
        both{length(both)/2+i} = regexprep(both{length(both)/2+i}, 'http[s]?://\S+', ' ');
        both{length(both)/2+i} = regexprep(both{length(both)/2+i}, '\r?\n', ' ');
        both{length(both)/2+i} = regexprep(both{length(both)/2+i}, '[^a-zA-Z0-9#]', ' ');
        aux_descricao = split(both{length(both)/2+i}, " ");
        aux_descricao(ismember(aux_descricao, removeWords) | strlength(aux_descricao) == 0) = [];
        aux_descricao = aux_descricao.';
        palavras_descricao{end+1} = {aux_descricao};
    else
        palavras_descricao{end+1} = 0;
    end
end

% para iterar conjunto de palavras titulo - palavras_titulo{i}{1} 
% para iterar conjunto de palavras descrição - palavras_descricao{i}{1}
for i = 1:length(palavras_titulo)
    if (isa(palavras_descricao{i}, 'cell'))
        documentos{i} = {palavras_titulo{i}{1} palavras_descricao{i}{1}};
    else
        documentos{i} = {palavras_titulo{i}{1} 0};
    end
end

palavras_unicas = [];

for i = 1:length(documentos)
    if (isa(documentos{i}{2}, 'cell'))
        documentos{i}{1} = string(unique(documentos{i}{1}));
        documentos{i}{2} = string(unique(documentos{i}{2}));
        for j = 1:length(documentos{i}{1})
            palavras_unicas = [palavras_unicas string(documentos{i}{1}{j})];
        end
        for j = 1:length(documentos{i}{2})
            palavras_unicas = [palavras_unicas string(documentos{i}{2}{j})];
        end
    else
        documentos{i}{1} = string(unique(documentos{i}{1}));
        for j = 1:length(documentos{i}{1})
            palavras_unicas = [palavras_unicas string(documentos{i}{1}{j})];
        end
    end
end

palavras_unicas = unique(palavras_unicas);

end