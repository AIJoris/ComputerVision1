%% Build visual vocabulary
function [C] = build_vocab(sift_cell,k)
disp('Building vocabulary...');
% Take half images of each class and throw SIFT features together
feature_bag = [];
for i = 1:length(sift_cell)
    dataset_cell = sift_cell{i};
    for j = 1:length(dataset_cell)
        feature_bag = [feature_bag; dataset_cell{j}'];
    end
end

% Use kmeans to cluster the SIFT features, where nclusters is vocab size
[idx,C] = kmeans(double(feature_bag),k);
end