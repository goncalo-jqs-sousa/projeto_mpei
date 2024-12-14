function [n_samples,header,video_IDs,titles,channel_names,categories,tags,descriptions] = load_dataset(filename)
    Dataset = readcell(filename);
    header = Dataset(1,:);
    Data = Dataset(2:end,:);

    AUX_indices = [];
    Cat = ["Film & Animation", "Music", "Sports", "News & Politics"];

    for i = 1:length(Data)
        if(double(Data{i,5}) == 1 & ~ ismissing(Data{i,16})) & strcmp(string(Data{i,7}), "[none]")
            % cat1 - Film & Animation
            Data{i,5} = Cat(1);
        elseif(double(Data{i,5}) == 10 & ~ ismissing(Data{i,16})) & strcmp(string(Data{i,7}), "[none]")
            % cat10 - Music
            Data{i,5} = Cat(2);
        elseif(double(Data{i,5}) == 17 & ~ ismissing(Data{i,16})) & strcmp(string(Data{i,7}), "[none]")
            % cat17 - Sports
            Data{i,5} = Cat(3);
        elseif(double(Data{i,5}) == 25 & ~ ismissing(Data{i,16})) & strcmp(string(Data{i,7}), "[none]")
            % cat25 - News & Politics
            Data{i,5} = Cat(4);
        else
            AUX_indices = [i AUX_indices];
        end
    end

    % Remover rows de classes irrelevantes do dataset
    AUX_indices = sort(AUX_indices, 'descend');
    for i = 1:length(AUX_indices)
        Data(AUX_indices(i), :) = [];
    end

    
    video_IDs = Data(:,1);
    n_samples = length(video_IDs);
    
    titles = Data(:,3);
    channel_names = Data(:,4);
    categories = Data(:,5);
    tags = Data(:,7);
    descriptions = Data(:,16);
    
    save ('Dataset_reduzido', 'Data')
    %clear Dataset;
    %clear Data;
end