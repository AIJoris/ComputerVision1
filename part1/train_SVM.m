function [models] = train_SVM(train_hist_cell)
addpath('../liblinear-2.1/matlab')

%% Find number of instances per class (these are not necessarily the same)
n = [size(train_hist_cell{1},1),
    size(train_hist_cell{2},1),
    size(train_hist_cell{3},1),
    size(train_hist_cell{4},1)];

%% Train SVM (one-vs-all)
models = cell(1,length(train_hist_cell));
ALL = 1:length(train_hist_cell);
for one=1:length(train_hist_cell)
    % pick one class, leave out the rest
    all = ALL;
    all(one) = [];
    
    labels = [ones(n(one),1);
              -1*ones(n(all(1)),1);
              -1*ones(n(all(2)),1);
              -1*ones(n(all(3)),1)];
          
    data = [train_hist_cell{one};
            train_hist_cell{all(1)};
            train_hist_cell{all(2)};
            train_hist_cell{all(3)}];

    models{one} = train(labels, sparse(data), '-c 1');
end
end