%% Loads all images in a given path into a cell.
function [images, names] = load_dir(path, n)
files = dir([path '*.jpg']);

% Initialize data structure
if n <= length(files)
    images = cell(1,n);
    names = cell(1,n);
    rand_indices = randperm(length(files), n);
else
    images = cell(1,length(files));
    names = cell(1,length(files));
    rand_indices = randperm(length(files), length(files));
end

% Put images and filenames into cells
for i=1:length(rand_indices)
    images{i} = imread(strcat(path,files(rand_indices(i)).name));
    names{i} = strcat(path(4:end),files(rand_indices(i)).name);
end
end