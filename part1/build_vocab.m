%% Build visual vocabulary
function [C] = build_vocab(train_feature_cell,k)
disp('Building vocabulary...');
% Take half images of each class and throw SIFT features together
feature_bag = [];
for i = 1:length(train_feature_cell)
    dataset_cell = train_feature_cell{i};
    for j = 1:round(length(dataset_cell)/2)
        feature_bag = [feature_bag; dataset_cell{i}'];
    end
end

% Use kmeans to cluster the SIFT features, where nclusters is vocab size
[idx,C] = kmeans(double(feature_bag),k);
end