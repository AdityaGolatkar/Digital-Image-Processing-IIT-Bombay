function [res] = myUnsharpMasking(img)

imageOrig = imread(img);
imshow(imageOrig);
copyimg = imageOrig;
%size(copyimg)
%imshow(imageOrig);
gaussian = fspecial('gaussian',[3 3],0.9);
mask = imageOrig - imfilter(copyimg,gaussian);
%size(mask)
k = 4 ;
temp = imageOrig + k*mask;
%size(temp)
minimum = min(temp(:));
maximum = max(temp(:));
temp = temp - minimum;
diff = maximum - minimum;
coeff = round(255/diff)
temp = coeff*temp;
imshow(temp);
imwrite(temp,'out.png');
%size(temp)
%res = 255*(temp)/(maximum - minimum);
%size(temp)

%imshow(res);



