%% Represent images using visual vocabulary
function [train_hist_cell] = sift2hist(train_feature_cell,C)
train_hist_cell = cell(size(train_feature_cell));

% For each image, for each feature, find closest 'word' in vocab
for i = 1:length(train_feature_cell)
    dataset_feature_cell = train_feature_cell{i};
    dataset_hist_cell = cell(size(dataset_feature_cell));
    for j = 1:round(length(dataset_feature_cell)/2)
        im_features = double(dataset_feature_cell{j});
        % Compute the distances between the vocabulary words and the
        % visual words in the image
        [~,hist] = min(pdist2(im_features',C)');
        
        % Normalize the histogram
        dataset_hist_cell{j} = hist./size(im_features,2)
    end
    train_hist_cell{i} = dataset_hist_cell;
end
end