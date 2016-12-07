function [w] = Intensitymetric(k,n,p,metric)
%INTENSITY Outputs the number of errors in the image classification of n
%test images against p train images, using the k-nearest neighbors 
% algorithm and the specified metric, ie 'correlation' 
%(metric must be entered as a string).

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

Idx = knnsearch(trainimages',testimages(:,1:n)', 'distance',metric,'K',k);

%Initialize vectors to store the labels of the matched 
% images from within the training set:

Idx1 = zeros(n,k);

%Get labels:

for i = 1:n
    Idx1(i,:) = trainlabels(Idx(i,:));
end

%Calculate the most frequent:

a = (mode(Idx1,2));

%Do timing:

toc

%Initialize a vector for storing the error:

v = zeros(n,1);

%Compare with the test labels:

for i =1:n
    v(i) = a(i)-testlabels(i);
end

%Output the proportion of errors:
disp('Error proportion for metric is:')
w = nnz(v)/n

end