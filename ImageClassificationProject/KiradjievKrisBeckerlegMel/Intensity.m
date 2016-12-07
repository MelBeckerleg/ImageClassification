function [a] = Intensity(k,n,p)
%INTENSITY Outputs the number of recognised labels 
%in the image classification of n test images, against p train images
%using the k-nearest neighbors algorithm. and Euclidean metric

if k>= n
    disp('cannot search more neighbours than test images')
    k=n-1
end

if n>10000
    disp('You are trying to test too many images! n set to 10000')
    n=10000
end

if p>50000
    disp('There are not that many train images in the database. p set to 50000')
    p=50000
end

%Read the binary files by converting them into .mat files:

trainimages = loadMNISTImages('train-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testimages = loadMNISTImages('t10k-images.idx3-ubyte');
testlabels = loadMNISTLabels('t10k-labels.idx1-ubyte');

%Start timing

tic

%Do a knn search:

Idx = knnsearch(trainimages(:,1:p)',testimages(:,1:n)','K',k);

%Initialize vectors to store the labels of the 
%matched images from within the training data:

Idx1 = zeros(n,k);

%Get labels:

for i = 1:n
    Idx1(i,:) = trainlabels(Idx(i,:));
end

%Calculate the most frequent:

a = (mode(Idx1,2));

%Do timing:

toc

end