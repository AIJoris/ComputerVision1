addpath('tSNE_matlab/');

% visualize
X = reshape(pre_trained.net.layers{12}.weights{1},[],10)';
labels = double([1 2 3 4 5 6 7 8 9 10]');
mappedX = tsne(double(X), labels, 2, 10, 30);

% Plot results
scatter(mappedX(:,1), mappedX(:,2), labels);