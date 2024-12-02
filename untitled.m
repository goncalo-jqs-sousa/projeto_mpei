FILE_NAME = "USvideos_short.csv";

[n_samples,header,video_IDs,titles,channel_names,categories,tags,descriptions] = load_dataset(FILE_NAME);

N = round(5*n_samples)
K = round(0.693*N/n_samples)

fprintf("Número de amostras: %d\n",n_samples)

BF = BF_initialize(n_samples*2);

for i = 1:n_samples
    BF = BF_add(char(video_IDs(i)),BF,K);
end

sum(BF)
