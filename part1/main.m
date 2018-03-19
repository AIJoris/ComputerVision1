%% TODO
% Classify using SVD
% Compute metircs (AP etc)

%% Specify paramters
n = 10;             % number of images to load
r = 0.5;           % ratio of train set to use for vocabbuilding/training
method = 'sift'; % feature extraction method
k = 400;            % number of words in visual vocabulary

%% Load images in cell structures, where each cell contains 4 data sets
[train1, train2, test, test_names] = load_data(n,r);

%% Extract SIFT features from images in train set
disp('Extracting features...');
sift_vocab = feature_extraction(train1, method);
sift_train = feature_extraction(train2, method);
sift_test = feature_extraction(test, method);

%% Build visual vocabulary
C = build_vocab(sift_vocab, k);

%% Represent second part of train set and test set using visual vocabulary
disp('Constructing histograms...');
hist_train = sift2hist(sift_train, C);
hist_test = sift2hist(sift_test, C);

%% Train Support Vector Machine using the histograms
models = train_SVM(train_hist_cell);

%% Make predictions
[predictions, qualitative] = predict_SVM(models, train_hist_cell, train_cell);

%% Evaluate results
[AP, MAP] = MeanAveragePrecision(predictions);
