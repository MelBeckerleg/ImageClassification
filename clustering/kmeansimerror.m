%Returns the error from kmeans clustering applied to m images
function [errormain errormean] = @kmeansimerror(m)

idx=kmeans(testimages(:,1:m)',9) 
%apply the kmeans algorithm. 
%Note, we know that we have 10 classes (one for each digit!)

%Now our images are clustered, but we need to reassign the clusters to 
%the correct digits.

for i=1:100
    class(idx(i))=testlabels(i)
    hold on
    plot(class)
end

for i=1:100
error(i)=mmc(idx(i))-testlabels(i);
end
error=nnz(error)

% This is rudimentary, and

% Another method, allocating the most common value for class:

class=zeros(100);
j=1;
for i=1:100
   if class(idx(i),j) == 0
    class(idx(i),j)=testlabels(i)+1;
   else j=j+1;    
   end
end

vec=zeros(j)
for i=1:100
    vec=class(i,:);
    tempvec=vec(vec>0)-1;
    mmc(i)=mode(tempvec,2);
end

% Note, that we now end up with some labels unused!

% Can we visualise the distribution instead to see if 
% there is a better way to assign every label?


% a(i,j)= the number of i labels associated with j cluster

% for each i we have the difference co-ordinate:
diffcor=zeros(100,2)   
for i=1:100
        diffcor(i,:)=[testlabels(i)+1 idx(i)-1]
end
 %start by finding the profile of cluster one. 
 
 diffcor=[ 10*diffcor(:,1)+ diffcor(:,2)]
 %Then if the diffcor is 10*a    
 
 cluster=zeros(10,10)

 for i=1:10
     for j=1:10
    cluster(i,j)=length(diffcor(diffcor==10*i+j));
     end
 end
 
 imagesc(cluster)
 colormap(flipud(gray));
 
%then count the frequency of each
 
 
 
 
    