FILE_NAME = "USvideos_short.csv";
N_SAMPLE_MULTIPLIER = 5;

% Carregar dataset
[n_samples,header,video_IDs,titles,channel_names,categories,tags,descriptions] = load_dataset(FILE_NAME);

% Parametros do BF 
N = round(N_SAMPLE_MULTIPLIER*n_samples)
K = round(0.693*N/n_samples)

fprintf("Número de amostras: %d\n",n_samples)

% Categorias possíveis 
% cat_list = unique(cell2mat(categories)');
cat_list = [22 23 24];%teste

n_cat = length(cat_list);

% Inicializar BF
BF_cat1 = BF_initialize(n_samples);
BF_cat2 = BF_initialize(n_samples);
BF_cat3 = BF_initialize(n_samples);

categories = cell2mat(categories)

cat_error = 0;
for v = 1:n_samples
    switch categories(v)
        case 22
            if ~BF_isMember(char(video_IDs(v)),BF_cat1,K)
                BF_cat1 = BF_add(char(video_IDs(v)),BF_cat1,K);
            end
        case 23
            if ~BF_isMember(char(video_IDs(v)),BF_cat2,K)
                BF_cat2 = BF_add(char(video_IDs(v)),BF_cat2,K);
            end
        case 24
           if ~BF_isMember(char(video_IDs(v)),BF_cat3,K)
                BF_cat3 = BF_add(char(video_IDs(v)),BF_cat3,K);
           end
        otherwise
            cat_error = cat_error+1;
            fprintf(1,"Categoria %d inválida\n",categories(v))
    end
end
n_members_unknown_cat = cat_error;
n_members = sum(BF_cat1)+sum(BF_cat2)+sum(BF_cat3)

fprintf("Número de membros nos BF: %d\n",sum(n_members))

