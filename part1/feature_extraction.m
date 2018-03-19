%% Return a cell with variable number of SIFT features for each image (takes RGB)
function [train_feature_cell] = feature_extraction(train_cell, method)
run('vlfeat-0.9.21/toolbox/vl_setup')

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
            % Compute keypoint locations using the grayscale image
            f = vl_sift(gs_im);
            
            % Compute descriptors using f for R,B and G channels
            dR = vl_siftdescriptor(construct_grad(im(:,:,1),f),f);
            dG = vl_siftdescriptor(construct_grad(im(:,:,2),f),f);
            dB = vl_siftdescriptor(construct_grad(im(:,:,3),f),f);
            
            % Concatenate the descriptors for each channel
            d = [dR;dB;dB];
        elseif strcmp(method,'rgbsift')
            % Convert image to normalized RGB
            rgb_im = double(im) ./ sum(im,3);
            
            % Compute keypoint locations using the grayscale image
            f = vl_sift(gs_im);
            
            % Compute descriptors using f for R,B and G channels
            dr = vl_siftdescriptor(construct_grad(rgb_im(:,:,1),f),f);
            dg = vl_siftdescriptor(construct_grad(rgb_im(:,:,2),f),f);
            db = vl_siftdescriptor(construct_grad(rgb_im(:,:,3),f),f);
            
            % Concatenate the descriptors for each channel
            d = [dr;dg;db];
            
        elseif strcmp(method,'opsift')
            % Convert im to opponent color space
            R  = im(:,:,1);
            G  = im(:,:,2);
            B  = im(:,:,3);
            
            % Compute keypoint locations using the grayscale image
            f = vl_sift(gs_im);
            
            % Compute descriptors using f for all channels in the color
            % space
            dc1 = vl_siftdescriptor(construct_grad((R-G)./sqrt(2),f),f);
            dc2 = vl_siftdescriptor(construct_grad((R+G-2*B)./sqrt(6),f),f);
            dc3 = vl_siftdescriptor(construct_grad((R+G+B)./sqrt(3),f),f);
            
            % Concatenate the descriptors for each channel
            d = [dc1;dc2;dc3];
        end
        dataset_features_cell{j} = d;
    end
    train_feature_cell{i} = dataset_features_cell;
end
end