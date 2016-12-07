%find the difference of training images form mean

trainimagesdiff=trainimages-repmat(Xmean, [1 60000]);

%try to visualise
%for i=1:60000
%diffmean(i)=reshape(trainimages(:,i),28,28)
diffmean=reshape(trainimagesdiff(:,1),28,28);
imshow(diffmean)

% Work with test images

testimagesdiff=testimages-repmat(Xmean, [1 10000]);

test=testimagesdiff(1)

IDX = knnsearch(trainimagesdiff,testimagesdiff(1)) %comparing one