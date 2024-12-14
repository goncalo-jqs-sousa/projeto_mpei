function [documentos,palavras_unicas] = NB_obter_palavras_unicas(titles, descriptions, varargin)
% Obtem as palavras_unicas dos titulos e descrições da mesma linha.
% Tem como input os conjuntos dos titulos e descrições e retorna um conjunto de documentos com conjuntos de ambos dentro no formato de string, bem como um array de strings com as palavras unicas dos documentos  

stopWords = [
        "a", "an", "and", "are", "as", "at", "be", "for", "from", ...
        "has", "he", "in", "is", "it", "its", "of", "on", "that", ...
        "the", "to", "was", "were", "will", "with", "this", "out"
        ];
removeWords = [
        "patreon", "twitter", "merch", "instagram", "tiktok", ...
        "facebook", "twitch", "pinterest", "spotify", "subscribe" ...
        "like", "comment"
        ];

if isempty(varargin)
    palavras_titulo = {};
    palavras_descricao = {};

    for i = 1:length(titles)
        titles{i} = lower(titles{i});
        titles{i} = regexprep(titles{i}, 'http[s]?://\S+', ' ');
        titles{i} = regexprep(titles{i}, '\r?\n', ' ');
        titles{i} = regexprep(titles{i}, '[^a-zA-Z\s]', ' ');
        aux_titulo = split(titles{i}, " ");
        aux_titulo = aux_titulo(~ismember(aux_titulo, removeWords) & ~ismember(aux_titulo, stopWords) & strlength(aux_titulo) > 0);
        aux_titulo = aux_titulo.';
        palavras_titulo{end+1} = {aux_titulo};
    end 
    for i = 1:length(descriptions)
        descriptions{i} = lower(descriptions{i});
        descriptions{i} = regexprep(descriptions{i}, 'http[s]?://\S+', ' ');
        descriptions{i} = regexprep(descriptions{i}, '\r?\n', ' ');
        descriptions{i} = regexprep(descriptions{i}, '[^a-zA-Z\s]', ' ');
        aux_descricao = split(descriptions{i}, " ");
        aux_descricao = aux_descricao(~ismember(aux_descricao, removeWords) & ~ismember(aux_descricao, stopWords) & strlength(aux_descricao) > 0);
        aux_descricao = aux_descricao.';
        palavras_descricao{end+1} = {aux_descricao};
    end

    % para iterar conjunto de palavras titulo - palavras_titulo{i}{1}
    % para iterar conjunto de palavras descrição - palavras_descricao{i}{1}
    for i = 1:length(palavras_titulo)
        documentos{i} = {string(unique(palavras_titulo{i}{1})) string(unique(palavras_descricao{i}{1}))};
    end

    palavras_unicas = [];

    for i = 1:length(documentos)
        for j = 1:length(documentos{i}{1})
            palavras_unicas = [palavras_unicas string(documentos{i}{1}{j})];
        end
        for j = 1:length(documentos{i}{2})
            palavras_unicas = [palavras_unicas string(documentos{i}{2}{j})];
        end
    end

    palavras_unicas = unique(palavras_unicas);

else
    palavras_titulo = {};
    palavras_descricao = {};
    palavras_tag = {};

    for i = 1:length(titles)
        titles{i} = lower(titles{i});
        titles{i} = regexprep(titles{i}, 'http[s]?://\S+', ' ');
        titles{i} = regexprep(titles{i}, '\r?\n', ' ');
        titles{i} = regexprep(titles{i}, '[^a-zA-Z\s]', ' ');
        aux_titulo = split(titles{i}, " ");
        aux_titulo = aux_titulo(~ismember(aux_titulo, removeWords) & ~ismember(aux_titulo, stopWords) & strlength(aux_titulo) > 0);
        aux_titulo = aux_titulo.';
        palavras_titulo{end+1} = {aux_titulo};
    end 
    for i = 1:length(descriptions)
        descriptions{i} = lower(descriptions{i});
        descriptions{i} = regexprep(descriptions{i}, 'http[s]?://\S+', ' ');
        descriptions{i} = regexprep(descriptions{i}, '\r?\n', ' ');
        descriptions{i} = regexprep(descriptions{i}, '[^a-zA-Z\s]', ' ');
        aux_descricao = split(descriptions{i}, " ");
        aux_descricao = aux_descricao(~ismember(aux_descricao, removeWords) & ~ismember(aux_descricao, stopWords) & strlength(aux_descricao) > 0);
        aux_descricao = aux_descricao.';
        palavras_descricao{end+1} = {aux_descricao};
    end
    for i = 1:length(varargin{1})
        varargin{1}{i} = lower(varargin{1}{i});
        varargin{1}{i} = regexprep(varargin{1}{i}, 'http[s]?://\S+', ' ');
        varargin{1}{i} = regexprep(varargin{1}{i}, '\r?\n', ' ');
        varargin{1}{i} = regexprep(varargin{1}{i}, '[^a-zA-Z\s]', ' ');
        aux_tag = split(varargin{1}{i}, " ");
        aux_tag = aux_tag(~ismember(aux_tag, removeWords) & ~ismember(aux_tag, stopWords) & strlength(aux_tag) > 0);
        aux_tag = aux_tag.';
        palavras_tag{end+1} = {aux_tag};
    end

    % para iterar conjunto de palavras titulo - palavras_titulo{i}{1}
    % para iterar conjunto de palavras descrição - palavras_descricao{i}{1}
    for i = 1:length(palavras_titulo)
        documentos{i} = {palavras_titulo{i}{1} palavras_descricao{i}{1} palavras_tag{i}{1}};
    end

    palavras_unicas = [];

    for i = 1:length(documentos)
        documentos{i}{1} = string(unique(documentos{i}{1}));
        documentos{i}{2} = string(unique(documentos{i}{2}));
        documentos{i}{3} = string(unique(documentos{i}{3}));
        for j = 1:length(documentos{i}{1})
            palavras_unicas = [palavras_unicas string(documentos{i}{1}{j})];
        end
        for j = 1:length(documentos{i}{2})
            palavras_unicas = [palavras_unicas string(documentos{i}{2}{j})];
        end
        for j = 1:length(documentos{i}{3})
            palavras_unicas = [palavras_unicas string(documentos{i}{3}{j})];
        end
    end

    palavras_unicas = unique(palavras_unicas);
end


end