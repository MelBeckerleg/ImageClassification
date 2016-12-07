% First, open the data and label so that work can begin!

trainimages = loadMNISTImages('train-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testimages= loadMNISTImages('t10k-images.idx3-ubyte');
testlabels= loadMNISTLabels('t10k-labels.idx1-ubyte');

%make sure the paths of the files you need are added (if in doubt, just run
%the function)

%Now we're going to check that we can see the images. 

firstpic=trainimages(:,3);
firstpic=reshape(firstpic,28,28);
imshow(firstpic);
%% Difference from intensity
k=3
IDX=knnsearch(trainimages',testimages(:,1:1000)','K',k);
%then train(IDX(i,j)) is the jth closest image to the ith test image
%takes a long time!
%let's visualise the matched images for a particular test image.
matchedpic1=zeros(784,4)
for j=1:k
matchedpic1(:,j)=trainimages(:,IDX(1,j));
end
pic1=reshape(testimages(:,1),28,28);
imshow(pic1);
matchedpic1=reshape(matchedpic1(:,1),28,28);
imshow(matchedpic1);


% Find the best using mode &See how well we've done for the nearest we've found:
for i=1:1000
    IDX1(i,:)= trainlabels(IDX(i,:));
    matching(i)=mode(IDX1(i,:)); %matching is the prediction for what the images are.
v(i)=matching(i)-testlabels(i);

end

%what about a picture of one that went wrong?
select=find(v);
s=select(1);
matchedpic2=zeros(784,4);
for j=1:k
matchedpic2(:,j)=trainimages(:,IDX(s,j));
end
pic2=reshape(testimages(:,s),28,28);
imshow(pic2);
ermatchedpic2=reshape(matchedpic2(:,2),28,28);
imshow(ermatchedpic2);


nnz(v) %gives the number of inaccurate values. 


%% taking the mean off

%create the mean image
Xmean=sum(trainimages,2)/60000;
%what does it look like?
Xmeanpic=reshape(Xmean,28,28);
imshow(Xmeanpic);
%subtract the mean
trainimagesdiff=trainimages-repmat(Xmean, [1 60000]);
testimagesdiff=testimages-repmat(Xmean, [1 60000]);


%try to visualise what we've done
%for i=1:60000
for i=1:3
diffmean(i)=reshape(trainimages(:,i),28,28)
end
imshow(diffmean)

% Work with test images
k=3
IDX=knnsearch(trainimagesdiff',testimagesdiff(:,1:1000)','K',k);
%then train(IDX(i,j)) is the jth closest image to the ith test image
%takes a long time!

% Find the best using mode &See how well we've done for the nearest we've found:
for i=1:10000
    IDX1(i,:)= trainlabels(IDX(i,:));
    matching(i)=mode(IDX1(i,:)); %matching is the prediction for what the images are.
v2(i)=matching(i)-testlabels(i);

end

nnz(v2) %gives the number of inaccurate values. 


%% Principal Components Case
%eigendecomposition of the covariance matrix
f=100; %number of features 
[V D]=eig(trainimages*trainimages');
%project onto the space spanned by 
Xftrain=V'*trainimages;
Xftrain=flipud(Xftrain);
Xftrain=Xftrain(1:f,:);

Xftest=V'*testimages;
Xftest=flipud(Xftest);
Xftest=Xftest(1:f,:);

%knn algorithm for pca

k=4
idx=knnsearch(Xftrain',Xftest(:,1:1000)','K',k);
%then trainlabels(IDX(:,j)) is the jth closest image to the ith test image



% Find the best using mode &See how well we've done for the nearest we've found:
w=zeros(1000,1);
idx1=zeros(1000,k);
for i=1:1000
    idx1(i,:)= trainlabels(idx(i,:));
    matching(i)=mode(idx1(i,:)'); %matching is the prediction for what the images are.
    w(i)=matching(i)-testlabels(i);

end

nnz(w)

% 2.7% error
%k=1 we get 
%k=





%% Principal Components Case with subtracted mean
%eigendecomposition of the covariance matrix
f=100 %number of features 
[V D]=eig(trainimagesdiff*trainimagesdiff');
%project onto the space spanned by 
Xftraindiff=V'*trainimagesdiff;
Xftraindiff=flipud(Xftraindiff);
Xftraindiff=Xftraindiff(1:f);

Xftestdiff=V'*testimagesdiff;
Xftestdiff=flipud(Xftestdiff);
Xftestdiff=Xftestdiff(1:k);

%knn algorithm for pca

k=3
idx=knnsearch(Xftraindiff,xftestdiff(:,1:10)','K',k);
%then train(IDX(i,j)) is the jth closest image to the ith test image
%takes a long time!

% Find the best using mode &See how well we've done for the nearest we've found:
for i=1:10
    idx1(i,:)= trainlabels(idx(i,:))
    matching(i)=mode(idx1(i)'); %matching is the prediction for what the images are.
wm(i)=matching(i)-testlabels(i);

end

nnz(wm)

%% Matching an image from outside the test images

myimage='myseven.xcf'






