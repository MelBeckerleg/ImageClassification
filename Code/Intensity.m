function [a] = Intensity(k,n)
%INTENSITY Outputs the number of recognised labels 
%in the image classification of n test images, 
%using the k-nearest neighbors algorithm. and Euclidean metric

%Read the binary files by converting them into .mat files:

trainimages = loadMNISTImages('train-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testimages = loadMNISTImages('t10k-images.idx3-ubyte');
testlabels = loadMNISTLabels('t10k-labels.idx1-ubyte');

%Start timing

tic

%Do a knn search:

Idx = knnsearch(trainimages',testimages(:,1:n)','K',k);

%Initialize vectors to store the labels of the 
%matched images from within the training data:

Idx1 = zeros(n,k);

%Get labels:

for i = 1:n
    Idx1(i,:) = trainlabels(Idx(i,:));
end

%Calculate the most frequent:

a = (mode(Idx1'))';

%Do timing:

toc

end

