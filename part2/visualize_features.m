function visualize_features(imdb, net)  
addpath('tSNE_matlab/');

net.layers{end}.type = 'softmax';
res = vl_simplenn(net, imdb.images.data);
labels = double(imdb.images.labels);
features = double(squeeze(res(12).x)');

len = length(features);
mappedX = tsne(features(1:len,:), labels(1:len), 2, 30, 30);
gscatter(mappedX(:,1), mappedX(:,2),labels(1:len));

end