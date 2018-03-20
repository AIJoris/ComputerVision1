%% Run and compile matconvnet
% run('matconvnet/matlab/vl_setupnn.m')
% vl_compilenn('EnableImreadJpeg',false);

%% visualize network
% load('data/pre_trained_model.mat');
% vl_simplenn_display(net)

%% fine-tune cnn
[net, info, expdir] = finetune_cnn();

%% extract features and train svm
nets.fine_tuned = load(fullfile(expdir, 'imdb-caltech.mat')); 
nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); 
nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-caltech.mat'));


%%
% train_svm(nets, data);
