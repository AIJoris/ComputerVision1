%% Return a cell with variable number of SIFT features for each image (takes RGB)
function [train_feature_cell] = feature_extraction(train_cell, method)
run('vlfeat-0.9.21/toolbox/vl_setup')
disp('Extracting features...');

% Obtain SIFT features for every image in cell and place in new cell
train_feature_cell = cell(1,length(train_cell));

% Loop over data sets
for i = 1:length(train_cell)
    dataset_cell = train_cell{i};
    
    % Get number of images in dataset, create new cell to put features in
    n = length(dataset_cell);
    dataset_features_cell = cell(1,n);
    
    % Loop over images
    for j=1:n
        im = dataset_cell{j};
        gs_im = single(rgb2gray(im));
        
        % Extract features
        if strcmp(method,'sift')
            [f, d] = vl_sift(gs_im);
        elseif strcmp(method,'dsift')
            [f, d] = vl_dsift(gs_im,'step',10);
        elseif strcmp(method,'RGBsift')
            f = v1_sift(gs_im);
            
        elseif strcmp(method,'rgbsift')
            disp('rgbSIFT');
        elseif strcmp(method,'opponentsift')
            disp('opponentSIFT');
        end
        dataset_features_cell{j} = d;
    end
    train_feature_cell{i} = dataset_features_cell;
end
end