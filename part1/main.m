%% TODO
% Change r into an integer to specify how many images of each set to take
% Use images for classification that have NOT been used for building vocab
% dsift with stepsize = 10
% rgbsift, RGBsift, opponentsift with concatenation of color channels 
% Classify using SVD
% Compute metircs (AP etc)

%% Specify paramters
r = 0.01;           % ratio of images to load
method = 'sift';    % feature extraction method
k = 400;            % number of words in visual vocabulary

%% Load images
[train_cell, test_cell] = load_data(r);

%% Extract SIFT features from images
train_feature_cell = feature_extraction(train_cell, method);

%% Build visual vocabulary
C = build_vocab(train_feature_cell,k);

%% Represent images using visual vocabulary
% TODO "Take images from the training set of the
% related class (but the ones which you did not use for dictionary calculation)"
train_hist_cell = sift2hist(train_feature_cell,C);

%% Use SVM to classify images
% model = train(training_label_vector, training_instance_matrix [,'liblinear_options', 'col']);
% [predicted_label, accuracy, decision_values/prob_estimates] = predict(testing_label_vector, testing_instance_matrix, model [, 'liblinear_options', 'col']);