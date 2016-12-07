function [kmeanserror] = kmeanserror(n)
    % clusters m images, assigns a cluster label according to the mode
    % and returns the error between assigned label and the actual label.

if n>10000
    disp('You are trying to test too many images! n set to 10000')
    n=10000
end
    
%Read the binary files by converting them into .mat files:

trainimages = loadMNISTImages('train-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testimages = loadMNISTImages('t10k-images.idx3-ubyte');
testlabels = loadMNISTLabels('t10k-labels.idx1-ubyte');

tic
    
%% First, we apply the kmeans method to cluster our images

idx=kmeans(testimages(:,1:n)',10);


%% Reassinging labels
%initialise vector to store the original labels of each image in each
%cluster
class=zeros(10,n);
j=1;

%find labels, storing them in a matrix where successive columns are generated 
%when elements within a cluster have different original labels
for i=1:n
   if class(idx(i),j) == 0
    class(idx(i),j)=testlabels(i)+1;
   else j=j+1;    
   end
end
%allocate label according to the mode 
for i=1:10
    vec=class(i,:);
    tempvec=vec(vec>0);
    mmc(i)=mode(tempvec,2);
end

%% Looking at the error
error=zeros(1,n);
for i=1:n
error(i)=mmc(idx(i))-testlabels(i)-1;
end

disp('cluster error proportion is:')
kmeanserror=nnz(error)/n

toc

%% Visualising the assignment of labels

% for each i we have the label co-ordinate which gives the original 
% label and the cluster it was assigned to:
labcor=zeros(n,2);   
for i=1:n
        labcor(i,:)=[testlabels(i)+1 idx(i)-1];
end 
 labcor=[ 10*labcor(:,1)+ labcor(:,2)];
 % We want to create a cluster matrix where the cluster(i,j) gives the 
 % number of elements with original label i that are allocated to cluster 
 % j.
 
 %initial cluster matrix
 cluster=zeros(10,10);

 %allocate values
 for i=1:10
     for j=1:10
    cluster(i,j)=length(labcor(labcor==10*i+j));
     end
 end
 %Visualise on a colour grid, where the higher frequency values are darker
 %shade
 
 imagesc(cluster);
 colormap(flipud(gray));
xlabel('cluster')
ylabel('Original Label')
shg