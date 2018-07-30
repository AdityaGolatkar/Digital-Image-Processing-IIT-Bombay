function [sharpimage] = UnsharpMasking(image)

mat = imread(image);
kernel = [1,2,1;2,4,2;1,2,1];

t = zeros(size(mat,1)+2*(size(kernel,1)-1),size(mat,2)+2*(size(kernel,2)-1));		%giving the extra padding to the input matrix
r = t;
t(size(kernel,1):size(kernel,1)+size(mat,1)-1,size(kernel,2):size(kernel,2)+size(mat,2)-1)=mat;
%adding the image to the zeros matrix
for i=1:1:size(kernel,2)-1+size(mat,2)		%iterating along the rows for a fixed column
	for j=1:1:size(kernel,1)-1+size(mat,1)	%iterating along the rows
		rows = j:j+size(kernel,1)-1;
		cols = i:i+size(kernel,2)-1;
		w = t(rows,cols);
		w = w(:)';
		k = kernel(:);
		sop = w*k;
		r(mean(rows),mean(cols))=sop;
	end
end
	
blurredimage = r(size(kernel,1):size(kernel,1)+size(mat,1)-1,size(kernel,2):size(kernel,2)+size(mat,2)-1);
%so now in r you have the filtered image

unsharpmask = mat - blurredimage;
sharpimage = mat + k*unsharpmask;% k is used to control the sharpening of the image.
mini = min(sharpimage(:));%this is done because the pixels values may become negative so to ensure they stay in the limit of 0 to 255 this is done.
maxi = max(sharpimage(:));
sharpimage = round(255*(sharpimage - mini)/(maxi-mini));
imshow(sharpimage);
