%% TODO
% Use images for classification that have NOT been used for building vocab
% dsift with stepsize = 10
% rgbsift, RGBsift, opponentsift with concatenation of color channels 
% Classify using SVD
% Compute metircs (AP etc)

%% Specify paramters
n = 5;              % number of images to load
method = 'sift';    % feature extraction method
k = 10;             % number of words in visual vocabulary

%% Load images
[train_cell, test_cell] = load_data(n);

%% Extract SIFT features from images
train_feature_cell = feature_extraction(train_cell, method);

%% Build visual vocabulary
C = build_vocab(train_feature_cell,k);

%% Represent images using visual vocabulary
% TODO "Take images from the training set of the
% related class (but the ones which you did not use for dictionary calculation)"
train_hist_cell = sift2hist(train_feature_cell,C);

%% Train Support Vector Machine using the histograms
models = train_SVM(train_hist_cell);

%% Make predictions
[predictions, qualitative] = predict_SVM(models, train_hist_cell, train_cell);

%% Evaluate results
[AP, MAP] = MeanAveragePrecision(predictions);