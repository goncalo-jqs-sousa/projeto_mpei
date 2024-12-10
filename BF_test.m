FILE_NAME = "USvideos.csv";
HISTORY_FILE_NAME = "USvideos_short.csv";

[n_samples,header,video_IDs,titles,channel_names,categories,tags,descriptions] = load_dataset(FILE_NAME);

[hist_n_samples,hist_header,hist_video_IDs,...
 hist_titles,hist_channel_names,hist_categories,...
 hist_tags,hist_descriptions] = load_dataset(HISTORY_FILE_NAME);

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
for v = 1:n_samples
    if ~BF_isMember(char(video_IDs(v)),BF,K)
       non_watched_videos = non_watched_videos+1;
    else
       watched_videos = watched_videos+1;
    end
end
fprintf(1,"Vídeos já visualizados: %d\n",watched_videos)
fprintf(1,"Vídeos adicionados para recomendação: %d\n",non_watched_videos)
