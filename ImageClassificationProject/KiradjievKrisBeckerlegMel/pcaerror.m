    function[w] = pcaerror(k,n,p,m,d) %PCA Outputs the number of errors in the image classification of n test
%images, keepingthe first m feature vectors and using k-nearest neighbors
%algorithm.

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

%set default if d (number of early feature vectors to disregard) is not
%set. 

if nargin < 5
 d = 1;
end

%Read the binary files by converting them into .mat files:
trainimages = loadMNISTImages('train-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testimages = loadMNISTImages('t10k-images.idx3-ubyte');
testlabels = loadMNISTLabels('t10k-labels.idx1-ubyte');

%find the mean of the trainimages and subtract from the original set
%create the mean image
Xmean=sum(trainimages(:,1:p),2)/p;

%subtract the mean
trainimagesdiff=trainimages(:,1:p)-repmat(Xmean, [1 p]);
testimagesdiff=testimages(:,1:n)-repmat(Xmean, [1 n]);

%Start timing

tic

%Set up the covariance matrix for the trainimages:
Covariance = trainimagesdiff*trainimagesdiff';

%Do an eigendecomposition:

[V D] = eig(Covariance);

%We project onto the space, spanned by first m vectors from V (for train 
%images and test images:

Xf = V'*trainimagesdiff(:,1:p);
Xf = flipud(Xf);
Xf = Xf(d:m,:);
Xft = V'*testimagesdiff(:,1:n);
Xft = flipud(Xft);
Xft = Xft(d:m,:);

%Do a knn search:
q=m-d+1;
Idxpca = knnsearch(Xf',Xft(:,1:n)','K',k);
size(Idxpca)
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

%Outputs the proportion of errors:
disp('Error proportion for pca is:')
w=nnz(v1)/n
end