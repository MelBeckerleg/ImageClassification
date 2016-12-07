%% Example for 500 test images, against the full training database (50000)
k=1; n=1000;p=50000;  m=20;
% Find the error of the unaltered dataset
Intensityerror(k,n,p);
% Change the metric 
Intensitymetric(k,n,p,'correlation');
% Find apply pca
pcaerror(k,n,p,m);
% Find the error with kmeans clustering
kmeanserror(n);