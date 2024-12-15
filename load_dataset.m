function [n_samples,header,video_IDs,titles,channel_names,categories,tags,descriptions] = load_dataset(filename, Cat, flag_save)
    Dataset = readcell(filename);
    header = Dataset(1,:);
    Data = Dataset(2:end,:);

    AUX_indices = [];
    Calc_ind = [];
    Data_hist = [];
    cnt1 = 0;
    cnt2 = 0;
    v1 = 15;
    while v1 == 15
        v1 = randi([1, 30-1]);
    end
    v2 = 30 - v1;

    for i = 1:length(Data)
        if(double(Data{i,5}) == 1 & ~ ismissing(Data{i,16})) & ~ strcmp(string(Data{i,7}), "[none]")
            % cat1 - Film & Animation
        elseif(double(Data{i,5}) == 10 & ~ ismissing(Data{i,16})) & ~ strcmp(string(Data{i,7}), "[none]")
            % cat10 - Music
            if cnt1 < v1
                Calc_ind = [i Calc_ind];
                cnt1 = cnt1 + 1;
            end
        elseif(double(Data{i,5}) == 17 & ~ ismissing(Data{i,16})) & ~ strcmp(string(Data{i,7}), "[none]")
            % cat17 - Sports
        elseif(double(Data{i,5}) == 25 & ~ ismissing(Data{i,16})) & ~ strcmp(string(Data{i,7}), "[none]")
            % cat25 - News & Politics
            if cnt2 < v2
                Calc_ind = [i Calc_ind];
                cnt2 = cnt2 + 1;
            end
        else
            AUX_indices = [i AUX_indices];
        end
    end

    AUX_indices = sort(AUX_indices, 'descend');
    Calc_ind = sort(Calc_ind, 'descend');

    % Remover rows do dataset e criar Calc_cat
    i = 1;
    j = 1;
    while (i < length(AUX_indices)+1 & j < length(Calc_ind)+1)
        if AUX_indices(i) < Calc_ind(j)
            Data_hist = [Data_hist ; Data(Calc_ind(j), :)];
            Data(Calc_ind(j), :) = [];
            j = j + 1;
        else
            Data(AUX_indices(i), :) = [];
            i = i + 1;
        end
    end

    
    video_IDs = Data(:,1);
    n_samples = length(video_IDs);
    
    titles = Data(:,3);
    channel_names = Data(:,4);
    categories = Data(:,5);
    tags = Data(:,7);
    descriptions = Data(:,16);
    
    if flag_save
        save ('Dataset_reduzido', 'Data')
        save ('Dataset_historico', 'Data_hist');
    end
    
    clear Data;
end