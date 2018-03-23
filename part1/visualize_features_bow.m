%% Visualize the visual vocabulary histogram of all images in the test and train set.
function visualize_features_bow(hist_train, hist_test)  
addpath('../part2/tSNE_matlab/');

features = [];
labels = [];
for i = 1:length(hist_train)
    features = [features; hist_train{i}; hist_test{i}];
    labels = [labels; ones(size(hist_train{i},1),1)*i; ones(size(hist_test{i},1),1)*i ];
end

    
mappedX = tsne(features, labels, 2, 30, 30);
gscatter(mappedX(:,1), mappedX(:,2),labels);
end