%% Loads all images in a given path into a cell.
function [images] = load_dir(path, p)
files = dir([path '*.jpg']);

n = round(p*length(files));

images = cell(1,n);
rand_indices = randperm(length(files), n);

for i=1:length(rand_indices)
    images{i} = imread(strcat(path,files(rand_indices(i)).name));
end
end