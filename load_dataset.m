function [n_samples,header,video_IDs,titles,channel_names,categories,tags,descriptions] = load_dataset(filename)

Dataset = readcell(filename);
header = Dataset(1,:);
Data = Dataset(2:end,:);

video_IDs = Data(:,1);
n_samples = size(video_IDs,1);
titles = Data(:,3);
channel_names = Data(:,4);
categories = Data(:,5);
tags = Data(:,7);
descriptions = Data(:,16);

clear Dataset;
clear Data;
end