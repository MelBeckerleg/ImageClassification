%map to k nearest
%pick the image to test
distance=zeros(10,6000);

for i=1:10
    for j=1:6000
        distance(i,j) = abs(testimages(:,i)-trainimages(:,j)); 
    end
end

%measuring the distance from the mean image

%choose the k largest for each vector
k=3;
%create  a vector to store the k images for each test
distancek= zeros(10, k);
for i=1:10000
   [~,position] = sort(distance(i,:));
   distancek(i,:)= distance(i,position(1:k));
end

for i=1:10000
for j=1:60000
distance(i,j) = abs(testimages(i)-trainimages(j));
end
end

%mean
%pca

