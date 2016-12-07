% First, open the data and label so that work can begin!
%"loadMNIST..." requires the database files to be stored in a local folder.

trainimages = loadMNISTImages('train-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testimages= loadMNISTImages('t10k-images.idx3-ubyte');
testlabels= loadMNISTLabels('t10k-labels.idx1-ubyte');

%make sure the paths of the files you need are added (if in doubt, just run
%the function)

%Now we're going to check that we can see the images. 

firstpic=trainimages(:,59992);
firstpic=reshape(firstpic,28,28);
imshow(firstpic);