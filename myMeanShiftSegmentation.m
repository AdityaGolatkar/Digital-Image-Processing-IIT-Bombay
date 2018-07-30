function img = myMeanShiftSegmentation()
%load('baboon.mat');
%img = imageOrig;
%imwrite(img,'OriginalImage.png');
image = 'einstein1.jpg';
img = imread(image);
img = imgaussfilt(img,1);
%img = img(1:2:size(img,1),1:2:size(img,2),:);


m=0;
for i = 1:64:256
    for j=1:64:256
        mean = [i,j,img(i,j,1),img(i,j,2),img(i,j,3)];
        img = meanshift(img,mean);
        m=m+1;
    end
end

imshow(img);

%imwrite(img,'../images/baboonSegments.png');
