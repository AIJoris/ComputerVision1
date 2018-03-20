function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
%run(fullfile(fileparts(mfilename('fullpath')), ...
%  '..', '..', '..', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-caltech.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [1];


%% update model

net = update_model();

%% TODO: Implement getCaltechIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getCaltechIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

function imdb = getCaltechIMDB()
% -------------------------------------------------------------------------
% Prepare the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};

folder = 'data/Caltech4/ImageData';
type = {'/airplanes_train/','/cars_train/', '/faces_train/', '/motorbikes_train/', ...
    '/faces_test/', '/airplanes_test/', '/cars_test/', '/motorbikes_test/'}; 

%% Determine length of matrix (use all images)
n = 0;
for i=1:length(type)
    n = n + length(dir(strcat(folder,type{i},'/*.jpg')));
end

data = zeros(32, 32, 3, n, 'single');
labels = zeros(n, 1) ;
sets = zeros(n, 1);

% loop through directories
for i=1:length(type)
    % determine if data is train or test
    % determine what to what class data belongs
    switch i
        case 1
            class = 1;
            train = 1;
        case 2
            class = 2;
            train = 1;
        case 3
            class = 3;
            train = 1;
        case 4
            class = 4;
            train = 1;
        case 5
            class = 1;
            train = 0;
        case 6
            class = 2;
            train = 0;
        case 7
            class = 3;
            train = 0;
        case 8
            class = 4;
            train = 0;  
    end

    directory = dir(strcat(folder,type{i},'/*.jpg'));
    % per directory loop through images
    for fn=1:length(directory)
       im = imread(strcat(folder, type{i}, directory(fn).name));
       im = imresize(im, [32 32]);
       data(:,:,:,i) = single(im);
       sets(i) = train;  
       labels(i) = class;
    end
end


% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data;
imdb.images.labels = single(labels);
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'};
imdb.meta.classes = classes;

%% Randomize
perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);
end