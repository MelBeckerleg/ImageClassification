function [kmeanserror] = kmeanserror(m)
    % clusters m images, assigns a cluster label according to the mode
    % and returns the error between assigned label and the actual label.

    
%Read the binary files by converting them into .mat files:

trainimages = loadMNISTImages('train-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testimages = loadMNISTImages('t10k-images.idx3-ubyte');
testlabels = loadMNISTLabels('t10k-labels.idx1-ubyte');

    
%% First, we apply the kmeans method to cluster our images

idx=kmeans(testimages(:,1:m)',10);


%% Reassinging labels
%initialise vector to store the original labels of each image in each
%cluster
class=zeros(10,m);
j=1;

%find labels
for i=1:m
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
error=zeros(1,m);
for i=1:m
error(i)=mmc(idx(i))-testlabels(i)-1;
end
kmeanserror=nnz(error);

%This error is pretty high though!


%% Visualising the assignment of labels

% This way we end up with some labels unused!
% Can we visualise the distribution instead to see if 
% there is a better way to assign every label?

% for each i we have the label co-ordinate which gives the original 
% label and the cluster it was assigned to:
labcor=zeros(m,2);   
for i=1:100
        labcor(i,:)=[testlabels(i)+1 idx(i)-1];
end 
 labcor=[ 10*labcor(:,1)+ labcor(:,2)];
 % We want to create a cluster matrix where the cluster(i,j) gives the 
 % number of elements with original label i that are allocated to cluster 
 % j.
 
 cluster=zeros(10,10);

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






 



