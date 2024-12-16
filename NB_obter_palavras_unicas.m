function [documentos_C1,documentos_C2,palavras_unicas_C1,palavras_unicas_C2, Data] = NB_obter_palavras_unicas(flag_filter, flag_treino, classes_treino, titles, descriptions, varargin)
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
        "like", "comment", "website", "itunes", "newsletter"
        ];

documentos_C1 = {};
documentos_C2 = {};
palavras_unicas_C1 = [];
palavras_unicas_C2 = [];

if flag_filter
    for i = 1:height(varargin{1})
        varargin{1}{i,3} = lower(varargin{1}{i,3});
        varargin{1}{i,3} = regexprep(varargin{1}{i,3}, 'http[s]?://\S+', ' ');
        varargin{1}{i,3} = convertCharsToStrings(varargin{1}{i,3});
        varargin{1}{i,3} = regexprep(varargin{1}{i,3}, '[\r\n]+', ' ');
        varargin{1}{i,3} = regexprep(varargin{1}{i,3}, '\\n', ' ');
        varargin{1}{i,3} = regexprep(varargin{1}{i,3}, '[^a-zA-Z\s]', ' ');
        varargin{1}{i,3} = regexprep(varargin{1}{i,3},'\s+',' ');
    end
    for i = 1:height(varargin{1})
        varargin{1}{i,16} = lower(varargin{1}{i,16});
        varargin{1}{i,16} = regexprep(varargin{1}{i,16}, 'http[s]?://\S+', ' ');
        varargin{1}{i,16} = convertCharsToStrings(varargin{1}{i,16});
        varargin{1}{i,16} = regexprep(varargin{1}{i,16}, '[\r\n]+', ' ');
        varargin{1}{i,16} = regexprep(varargin{1}{i,16}, '\\n', ' ');
        varargin{1}{i,16} = regexprep(varargin{1}{i,16}, '[^a-zA-Z\s]', ' ');
        varargin{1}{i,16} = regexprep(varargin{1}{i,16},'\s+',' ');
    end
    for i = 1:height(varargin{1})
        varargin{1}{i,7} = lower(varargin{1}{i,7});
        varargin{1}{i,7} = regexprep(varargin{1}{i,7}, 'http[s]?://\S+', ' ');
        varargin{1}{i,7} = convertCharsToStrings(varargin{1}{i,7});
        varargin{1}{i,7} = regexprep(varargin{1}{i,7}, '[\r\n]+', ' ');
        varargin{1}{i,7} = regexprep(varargin{1}{i,7}, '\\n', ' ');
        varargin{1}{i,7} = regexprep(varargin{1}{i,7}, '[^a-zA-Z\s]', ' ');
        varargin{1}{i,7} = regexprep(varargin{1}{i,7},'\s+',' ');    
    end
    Data = varargin{1};
else
    if isempty(varargin)
        palavras_titulo = {};
        palavras_descricao = {};
        documentos = {};

        for i = 1:height(titles)
            titles{i} = lower(titles{i});
            titles{i} = regexprep(titles{i}, 'http[s]?://\S+', ' ');
            titles{i} = convertCharsToStrings(titles{i});
            titles{i} = regexprep(titles{i}, '[\r\n]+', ' ');
            titles{i} = regexprep(titles{i}, '\\n', ' ');
            titles{i} = regexprep(titles{i}, '[^a-zA-Z\s]', ' ');
            aux_titulo = split(titles{i}, " ");
            aux_titulo = aux_titulo(~ismember(aux_titulo, removeWords) & ~ismember(aux_titulo, stopWords) & strlength(aux_titulo) > 0);
            aux_titulo = aux_titulo.';
            palavras_titulo{end+1} = {aux_titulo};
        end
        for i = 1:height(descriptions)
            descriptions{i} = lower(descriptions{i});
            descriptions{i} = regexprep(descriptions{i}, 'http[s]?://\S+', ' ');
            descriptions{i} = convertCharsToStrings(descriptions{i});
            descriptions{i} = regexprep(descriptions{i}, '[\r\n]+', ' ');
            descriptions{i} = regexprep(descriptions{i}, '\\n', ' ');
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
        documentos_C1 = {};
        documentos_C2 = {};

        if flag_treino
            for i = 1:length(documentos)
                if classes_treino(i) == 10
                    documentos_C1{end+1} = documentos{i};
                else
                    documentos_C2{end+1} = documentos{i};
                end
            end
            palavras_unicas_C1 = [];
            palavras_unicas_C2 = [];

            for i = 1:length(documentos_C1)
                documentos_C1{i}{1} = string(unique(documentos_C1{i}{1}));
                documentos_C1{i}{2} = string(unique(documentos_C1{i}{2}));
                for j = 1:length(documentos_C1{i}{1})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos_C1{i}{1}{j})];
                end
                for j = 1:length(documentos_C1{i}{2})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos_C1{i}{2}{j})];
                end
            end

            for i = 1:length(documentos_C2)
                documentos_C2{i}{1} = string(unique(documentos_C2{i}{1}));
                documentos_C2{i}{2} = string(unique(documentos_C2{i}{2}));
                for j = 1:length(documentos_C2{i}{1})
                    palavras_unicas_C2 = [palavras_unicas_C2 string(documentos_C2{i}{1}{j})];
                end
                for j = 1:length(documentos_C2{i}{2})
                    palavras_unicas_C2 = [palavras_unicas_C2 string(documentos_C2{i}{2}{j})];
                end
            end

            palavras_unicas_C1 = unique(palavras_unicas_C1);
            palavras_unicas_C2 = unique(palavras_unicas_C2);
        else
            palavras_unicas_C1 = [];
            palavras_unicas_C2 = [];

            for i = 1:length(documentos)
                documentos{i}{1} = string(unique(documentos{i}{1}));
                documentos{i}{2} = string(unique(documentos{i}{2}));
                for j = 1:length(documentos{i}{1})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos{i}{1}{j})];
                end
                for j = 1:length(documentos{i}{2})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos{i}{2}{j})];
                end
            end
            documentos_C1 = documentos;
            documentos_C2 = [];
            palavras_unicas_C1 = unique(palavras_unicas_C1);
        end
    else
        palavras_titulo = {};
        palavras_descricao = {};
        palavras_tag = {};
        documentos = {};

        for i = 1:height(titles)
            titles{i} = lower(titles{i});
            titles{i} = regexprep(titles{i}, 'http[s]?://\S+', ' ');
            titles{i} = convertCharsToStrings(titles{i});
            titles{i} = regexprep(titles{i}, '[\r\n]+', ' ');
            titles{i} = regexprep(titles{i}, '\\n', ' ');
            titles{i} = regexprep(titles{i}, '[^a-zA-Z\s]', ' ');
            aux_titulo = split(titles{i}, " ");
            aux_titulo = aux_titulo(~ismember(aux_titulo, removeWords) & ~ismember(aux_titulo, stopWords) & strlength(aux_titulo) > 0);
            aux_titulo = aux_titulo.';
            palavras_titulo{end+1} = {aux_titulo};
        end
        for i = 1:height(descriptions)
            descriptions{i} = lower(descriptions{i});
            descriptions{i} = regexprep(descriptions{i}, 'http[s]?://\S+', ' ');
            descriptions{i} = convertCharsToStrings(descriptions{i});
            descriptions{i} = regexprep(descriptions{i}, '[\r\n]+', ' ');
            descriptions{i} = regexprep(descriptions{i}, '\\n', ' ');
            descriptions{i} = regexprep(descriptions{i}, '[^a-zA-Z\s]', ' ');
            aux_descricao = split(descriptions{i}, " ");
            aux_descricao = aux_descricao(~ismember(aux_descricao, removeWords) & ~ismember(aux_descricao, stopWords) & strlength(aux_descricao) > 0);
            aux_descricao = aux_descricao.';
            palavras_descricao{end+1} = {aux_descricao};
        end
        for i = 1:height(varargin{1})
            varargin{1}{i} = lower(varargin{1}{i});
            varargin{1}{i} = regexprep(varargin{1}{i}, 'http[s]?://\S+', ' ');
            varargin{1}{i} = convertCharsToStrings(varargin{1}{i});
            varargin{1}{i} = regexprep(varargin{1}{i}, '[\r\n]+', ' ');
            varargin{1}{i} = regexprep(varargin{1}{i}, '\\n', ' ');
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
        documentos_C1 = {};
        documentos_C2 = {};

        if flag_treino
            for i = 1:length(documentos)
                if classes_treino(i) == 10
                    documentos_C1{end+1} = documentos{i};
                else
                    documentos_C2{end+1} = documentos{i};
                end
            end
            palavras_unicas_C1 = [];
            palavras_unicas_C2 = [];

            for i = 1:length(documentos_C1)
                documentos_C1{i}{1} = string(unique(documentos_C1{i}{1}));
                documentos_C1{i}{2} = string(unique(documentos_C1{i}{2}));
                documentos_C1{i}{3} = string(unique(documentos_C1{i}{3}));
                for j = 1:length(documentos_C1{i}{1})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos_C1{i}{1}{j})];
                end
                for j = 1:length(documentos_C1{i}{2})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos_C1{i}{2}{j})];
                end
                for j = 1:length(documentos_C1{i}{3})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos_C1{i}{3}{j})];
                end
            end

            for i = 1:length(documentos_C2)
                documentos_C2{i}{1} = string(unique(documentos_C2{i}{1}));
                documentos_C2{i}{2} = string(unique(documentos_C2{i}{2}));
                documentos_C2{i}{3} = string(unique(documentos_C2{i}{3}));
                for j = 1:length(documentos_C2{i}{1})
                    palavras_unicas_C2 = [palavras_unicas_C2 string(documentos_C2{i}{1}{j})];
                    % palavras unicas titulo
                end
                for j = 1:length(documentos_C2{i}{2})
                    palavras_unicas_C2 = [palavras_unicas_C2 string(documentos_C2{i}{2}{j})];
                    % palavras unicas descrição
                end
                for j = 1:length(documentos_C2{i}{3})
                    palavras_unicas_C2 = [palavras_unicas_C2 string(documentos_C2{i}{3}{j})];
                    % palavras unicas tags
                end
            end

            palavras_unicas_C1 = unique(palavras_unicas_C1);
            palavras_unicas_C2 = unique(palavras_unicas_C2);
        else
            palavras_unicas_C1 = [];
            palavras_unicas_C2 = [];

            for i = 1:length(documentos)
                documentos{i}{1} = string(unique(documentos{i}{1}));
                documentos{i}{2} = string(unique(documentos{i}{2}));
                documentos{i}{3} = string(unique(documentos{i}{3}));
                for j = 1:length(documentos{i}{1})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos{i}{1}{j})];
                end
                for j = 1:length(documentos{i}{2})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos{i}{2}{j})];
                end
                for j = 1:length(documentos{i}{3})
                    palavras_unicas_C1 = [palavras_unicas_C1 string(documentos{i}{3}{j})];
                end
            end
            documentos_C1 = documentos;
            documentos_C2 = [];
            palavras_unicas_C1 = unique(palavras_unicas_C1);
        end
    end
end

end