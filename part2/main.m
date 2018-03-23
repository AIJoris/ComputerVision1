%% visualize network
% original_net = load('data/pre_trained_model.mat');
% vl_simplenn_display(original_net);

%% fine-tune cnn
[net, info, expdir] = finetune_cnn();
% expdir = 'data/cnn_assignment-lenet';

%% extract features and train svm
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-50.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-caltech.mat'));

%% Visualize features in last conv layer for all images
visualize_features(data, nets.pre_trained);

%% Train SVM using pre-trained and fine-tuned network features
train_svm(nets, data);
