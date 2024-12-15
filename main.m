clear all;
clc;

FILE_NAME         = "USvideos.csv";
FILE_NAME_HISTORY = "USvideos_short.csv";
Cat = [1, 10, 17, 25];

[n_samples,header] = load_dataset(FILE_NAME, Cat, true);

load_t_begin = cputime;
% load ('Dataset_historico', 'Data_hist');
[hist_n_samples,hist_header,hist_video_IDs,...
 hist_titles,hist_channel_names,hist_categories,...
 hist_tags,hist_descriptions] = load_dataset(FILE_NAME_HISTORY, Cat, false);
load_time = cputime - Load_t_begin;
fprintf(1,"Dataset carregado em %.3f s",load_time)

NB_t_begin = cputime;
%
% Implementação NB
load("Dataset_reduzido.mat", 'Data');
teste_row = 400;
treino_row = 200;
Cat = [10, 25];
flag_tags = true;
docs_col_n = 1;
flag_perm = true;

[irrelevante1,irrelevante2,video_IDs,titles,channel_names,categories,tags,descriptions]= NB(Data, 400, 50, Cat, true, 1, true);
% Carregar dataset
%

NB_time = cputime - NB_t_begin;
fprintf(1,"Classificador NB carregado em %.3f s",NB_time)

BF_t_begin = cputime;

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
BF_time = cputime - BF_t_begin;
fprintf(1,"Categoria calculada  em %.3f s",BF_time)
%%
%% Implementação MinHash
%%

