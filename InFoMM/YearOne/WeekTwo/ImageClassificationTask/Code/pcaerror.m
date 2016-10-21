function [w] = pca(k,m,n,d)
%PCA Outputs the number of errors in the image classification of n test
%images, keepingthe first m feature vectors and using k-nearest neighbors
%algorithm.

 %Check number of inputs.
if nargin > 4
    error('myfuns:somefun2:TooManyInputs', ...
       'requires at most 1 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 2
     d=1;
end


%Read the binary files by converting them into .mat files:

trainimages = loadMNISTImages('train-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testimages = loadMNISTImages('t10k-images.idx3-ubyte');
testlabels = loadMNISTLabels('t10k-labels.idx1-ubyte');

%find the mean of the trainimages and subtract from the original set
%create the mean image
Xmean=sum(trainimages,2)/60000;

%subtract the mean
trainimagesdiff=trainimages-repmat(Xmean, [1 60000]);
testimagesdiff=testimages-repmat(Xmean, [1 10000]);

%Start timing

tic

%Set up the covariance matrix for the trainimages:
Covariance = trainimagesdiff*trainimagesdiff';

%Do an eigendecomposition:

[V D] = eig(Covariance);

%We project onto the space, spanned by first m vectors from V (for train 
%images and test images:

Xf = V'*trainimagesdiff;
Xf = flipud(Xf);
Xf = Xf(d:m,:);
Xft = V'*testimagesdiff(:,1:n);
Xft = flipud(Xft);
Xft = Xft(d:m,:);

%Do a knn search:

Idxpca = knnsearch(Xf',Xft(:,1:n)','K',k);

%Initialize vectors to store the train labels, error and the mode for each
%image:

Idx1pca = zeros(n,k);
v1 = zeros(n,1);
apca = zeros(n,1);

%Get train labels, take the most frequent and compare it to the test
%label:

for i = 1:n
    Idx1pca(i,:) = trainlabels(Idxpca(i,:));
    apca(i) = mode(Idx1pca(i,:)');
    v1(i) = apca(i)-testlabels(i);
end

%Do timing:

toc

%Outputs the number of errors:

w=nnz(v1);
end

