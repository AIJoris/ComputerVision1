%% Loads all images in a given path into a cell.
function [images] = load_dir(path, n)
files = dir([path '*.jpg']);

if n <= length(files)
    images = cell(1,n);
    rand_indices = randperm(length(files), n);
else
    images = cell(1,length(files));
    rand_indices = randperm(length(files), length(files));

end






for i=1:length(rand_indices)
    images{i} = imread(strcat(path,files(rand_indices(i)).name));
end
end