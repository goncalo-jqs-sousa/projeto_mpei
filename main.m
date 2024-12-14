FILE_NAME         = "USvideos_short.csv";
FILE_NAME_HISTORY = "USvideos_history.csv";

%[classes_added, classes_corretas, DATASET_TESTE] = NB(Data, teste_row, treino_row, Cat, flag_tags, docs_col_n, perm);

%
% Implementação NB
% Carregar dataset
%
t_begin = cputime;

[n_samples,header,video_IDs,titles,channel_names,categories,tags,descriptions] = load_dataset(FILE_NAME);

[hist_n_samples,hist_header,hist_video_IDs,...
 hist_titles,hist_channel_names,hist_categories,...
 hist_tags,hist_descriptions] = load_dataset(FILE_NAME_HISTORY);

% Parametros do BF
N_SAMPLE_MULTIPLIER = 8;
N = round(N_SAMPLE_MULTIPLIER*n_samples);
K = round(0.693*N/n_samples);

non_watched_videos = 0;
watched_videos = 0;

fprintf(1,"N: %d\n",N);
fprintf(1,"K: %d\n",K);
fprintf(1,"Vídeos para testar (M): %d\n",n_samples);
fprintf(1,"Vídeos presentes no histórico: %d\n",hist_n_samples);

BF = BF_initialize(N);

% Adicionar vídeos do histórico ao BF
for v = 1:length(hist_video_IDs)
    BF = BF_add(char(hist_video_IDs(v)),BF,K);
end

% Verificação dos vídeos categorizados no BF
BF_n_samples     = 0;
BF_video_IDs     = [];
BF_titles        = [];
BF_channel_names = [];
BF_categories    = [];
BF_tags          = [];
BF_descriptions  = [];

for v = 1:n_samples   
    if ~BF_isMember(video_IDs{v},BF,K)
        non_watched_videos = non_watched_videos+1;
        
        BF_n_samples                   = BF_n_samples+1;
        BF_video_IDs{BF_n_samples}     = video_IDs{v};
        BF_titles{BF_n_samples}        = titles{v};
        BF_channel_names{BF_n_samples} = channel_names{v};
        BF_categories{BF_n_samples}    = categories{v};
        BF_tags{BF_n_samples}          = tags{v};
        BF_descriptions{BF_n_samples}  = descriptions{v};
    else
       watched_videos = watched_videos+1;
    end
end
% Remoção dos videos por categorizar
clear n_samples;
clear video_IDs;
clear titles;
clear channel_names;
clear categories;
clear tags;
clear descriptions;

fprintf(1,"Vídeos já visualizados: %d\n",watched_videos);
fprintf(1,"Vídeos adicionados para recomendação: %d\n",non_watched_videos);

[recommended_category,views] = calculate_category(hist_categories,hist_n_samples);

fprintf(1,"Categoria recomendada: %s (%d)\n",recommended_category,views);
t_end = cputime - t_begin;
fprintf(1,"Calculado em %.3fs\n",t_end);
%%
%% Implementação MinHash
%%

