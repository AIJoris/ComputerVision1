%% Loads train images and test images for all classes in cells.
function [trainset, testset] = load_data(p)
disp('Loading Images...');

w = warning('off','all');
delete('../Caltech4/ImageData/motorbikes_train/img050.jpg');
delete('../Caltech4/ImageData/motorbikes_train/img400.jpg');
delete('../Caltech4/ImageData/motorbikes_train/img232.jpg');
delete('../Caltech4/ImageData/motorbikes_train/img296.jpg');
delete('../Caltech4/ImageData/motorbikes_train/img438.jpg')
warning(w);

airplanes_test = load_dir('../Caltech4/ImageData/airplanes_test/', p);
airplanes_train = load_dir('../Caltech4/ImageData/airplanes_train/', p);
cars_test = load_dir('../Caltech4/ImageData/cars_test/', p);
cars_train = load_dir('../Caltech4/ImageData/cars_train/', p);
faces_test = load_dir('../Caltech4/ImageData/faces_test/', p);
faces_train = load_dir('../Caltech4/ImageData/faces_train/', p);
motorbikes_test = load_dir('../Caltech4/ImageData/motorbikes_test/', p);
motorbikes_train = load_dir('../Caltech4/ImageData/motorbikes_train/', p);

trainset = {airplanes_train, cars_train, faces_train, motorbikes_train};
testset = {airplanes_test, cars_test, faces_test, motorbikes_test};

end