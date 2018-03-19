function [predictions, qual_names] = predict_SVM(models, data, test_names)
predictions = cell(1,length(data));
qual_names = cell(1,length(data));
filenames = [test_names{1}'; test_names{2}'; test_names{3}'; test_names{4}'];

%% Make predictions
for i=1:length(data)
    decision_values = zeros(size(data{1},1),length(models));
    % find decision values for all 4 models
    for j=1:length(models)
        [~, ~, decision_values(:,j)] = predict(ones(size(data{i},1),1), sparse(data{i}),models{j});
    end
    % max row value is class prediction
    [~,predictions{i}] = max(decision_values,[],2);
        
    scores = reshape(decision_values,[],1);
    [~,indices] = sort(scores,'ascend');
    qual_names{i} = filenames(indices);  
end
end