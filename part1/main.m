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

%% Train SVM on second half of train set to classify images
% model = train(training_label_vector, training_instance_matrix [,'liblinear_options', 'col']);
% [predicted_label, accuracy, decision_values/prob_estimates] = predict(testing_label_vector, testing_instance_matrix, model [, 'liblinear_options', 'col']);