
function visualize_features(imdb, net)
net.layers{end}.type = 'softmax';
res = vl_simplenn(net, imdb.images.data);
features = squeeze(res(12).x);

end