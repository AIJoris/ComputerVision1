%% Loads train images and test images for all classes in cells.
function [trainset1, trainset2, testset] = load_data(n,r)
disp('Loading Images...');

% Delete non-color images
w = warning('off','all');
delete('../Caltech4/ImageData/motorbikes_train/img050.jpg');
delete('../Caltech4/ImageData/motorbikes_train/img400.jpg');
delete('../Caltech4/ImageData/motorbikes_train/img232.jpg');
delete('../Caltech4/ImageData/motorbikes_train/img296.jpg');
delete('../Caltech4/ImageData/motorbikes_train/img438.jpg')
warning(w);

airplanes_test = load_dir('../Caltech4/ImageData/airplanes_test/', n);
airplanes_train = load_dir('../Caltech4/ImageData/airplanes_train/', n);
cars_test = load_dir('../Caltech4/ImageData/cars_test/', n);
cars_train = load_dir('../Caltech4/ImageData/cars_train/', n);
faces_test = load_dir('../Caltech4/ImageData/faces_test/', n);
faces_train = load_dir('../Caltech4/ImageData/faces_train/', n);
motorbikes_test = load_dir('../Caltech4/ImageData/motorbikes_test/', n);
motorbikes_train = load_dir('../Caltech4/ImageData/motorbikes_train/', n);


trainset1 = {{airplanes_train{1:floor(n*r)}}, {cars_train{1:floor(n*r)}}, {faces_train{1:floor(n*r)}}, {motorbikes_train{1:floor(n*r)}}};
trainset2 = {{airplanes_train{1+floor(n*r):n}}, {cars_train{1+floor(n*r):n}}, {faces_train{1+floor(n*r):n}}, {motorbikes_train{1+floor(n*r):n}}};
testset = {airplanes_test, cars_test, faces_test, motorbikes_test};

end