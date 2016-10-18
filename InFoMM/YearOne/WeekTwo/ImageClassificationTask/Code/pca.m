function [w] = pca(k,m,n)
%PCA Outputs the number of errors in the image classification of n test
%images, keepingthe first m feature vectors and using k-nearest neighbors
%algorithm.

%Read the binary files by converting them into .mat files:

trainimages = loadMNISTImages('train-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testimages = loadMNISTImages('t10k-images.idx3-ubyte');
testlabels = loadMNISTLabels('t10k-labels.idx1-ubyte');

%Start timing

tic

%Set up the covariance matrix for the trainimages:

Covariance = trainimages*trainimages';

%Do an eigendecomposition:

[V D] = eig(Covariance);

%We project onto the space, spanned by first m vectors from V (for train 
%images and test images:

Xf = V'*trainimages;
Xf = flipud(Xf);
Xf = Xf(1:m,:);
Xft = V'*testimages(:,1:n);
Xft = flipud(Xft);
Xft = Xft(1:m,:);

%Do a knn search:

Idxpca = knnsearch(Xf',Xft(:,1:n)','K',k);

%Initialize vectors to store the train labels, error and the mode for each
%image:

Idx1pca = zeros(n,k);
v1 = zeros(n,1);
apca = zeros(n,1);

%Get train labels, take the most frequent and compare it to the test
%label:

for i = 1:1000
    Idx1pca(i,:) = trainlabels(Idxpca(i,:));
    apca(i) = mode(Idx1pca(i,:)');
    v1(i) = apca(i)-testlabels(i);
end

%Do timing:

toc

%Outputs the number of errors:

w=nnz(v1);
end

