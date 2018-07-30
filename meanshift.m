function [output] = meanshift(img,mean)
%img = imread(image);
%img = imgaussfilt(img,1);
%img = img(1:2:size(img,1),1:2:size(img,2),:);
x = zeros(65536,5);
ct = 1;
for j=1:256
    for i=1:256
        x(ct,:) = [i,j,img(i,j,1),img(i,j,2),img(i,j,3)];
        ct = ct+1;
    end
end
%mean = [128,128,img(128,128,1),img(128,128,2),img(128,128,3)];
x = double(x);
mean = double(mean);
for l = 1:20
    diff = zeros(65536,1);
    diff = double(diff);
    for q=1:65536
        temp = (x(q,:)-mean).*(x(q,:)-mean);
        diff(q,1) = sqrt(sum(temp(:)));
    end
    subcluster = find(diff<90);
    hs = 16;
    hr = 16;
    denominator = 0;
    new_mean = 0;
    for k = 1:size(subcluster,1)
        vector_diff = mean - x(subcluster(k),:); 
        xs = vector_diff(1:2);
        xr = vector_diff(3:5);
        xs = sum(xs.*xs);
        xr = sum(xr.*xr);
        new_mean = new_mean + x(subcluster(k),:)*exp(-xs/(hs*hs))*exp(-xr/(hr*hr));
        denominator = denominator + exp(-xs/(hs*hs))*exp(-xr/(hr*hr));
    end
        new_mean = new_mean/denominator;
        mean = new_mean;
end    
mean = round(mean);

for q=1:65536
    temp = (x(q,:)-mean).*(x(q,:)-mean);
    diff(q,1) = sqrt(sum(temp(:)));
end
subcluster = find(diff<90);
output_img = img;
I1 = mean(3);
I2 = mean(4);
I3 = mean(5);
%size(x)
%x(277,:)
%point = [0,0,0,0,0];
for k = 1:size(subcluster,1)
 %   disp(subcluster(k));
    %temps = subcluster(k);
 %   x(subcluster(k),:)
   % point = x(subcluster(k),:);
   % point = round(point);
    %point = uint8(point);
    %x = point(1);
    %y = point(2);
    x1 = x(subcluster(k),1);
    y1 = x(subcluster(k),2);
    output_img(x1,y1,1) = I1;
    output_img(x1,y1,2) = I2;
    output_img(x1,y1,3) = I3;
    %disp(output_img(point(1),point(2),:));
end
%disp(mean);
d = output_img - img;
%sum(d(:));
%i = 1:256;
%j = 1:256;
%if(d(i,j) ~= 0)
%    disp(d(i,j));
%end
%output_img = uint8(output_img);
%imshow(output_img);
output = output_img;
%imwrite(img,'baboonI.png');
%imwrite(output_img,'baboonS.png');