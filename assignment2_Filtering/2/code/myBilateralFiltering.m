function [] = myBilateralFiltering(image,sigma_i,sigma_s,win)

img = imread(image);
img =  double(img);
noise = normrnd(0,12.5,size(img));
corrupted = round(img + noise);
w = (win-1)/2;

for i =1:size(img,1)
	for j=1:size(img,2)
		rows = max(1,i-w):min(size(img,1),i+w);
		cols = max(1,j-w):min(size(img,2),j+w);	
		imgwindow = corrupted(rows,cols);
		intensities = abs(imgwindow - corrupted(i,j));
		
		cols = cols';
		xcoordinates = rows(ones(length(cols),1),:)';
		ycoordinates = cols(:,ones(1,length(rows)))'; 
		xcoordiff = xcoordinates - i;
		ycoordiff = ycoordinates - j;
		xcoorsqr = xcoordiff.*xcoordiff;
		ycoorsqr = ycoordiff.*ycoordiff;
		distsqr = xcoorsqr + ycoorsqr;
		sqrdist = sqrt(distsqr);
		space = sqrdist;
     	cols = cols';

		gaussian_intensities = normpdf(intensities,0,sigma_i);
		gaussian_space = normpdf(space,0,sigma_s);
		weight = gaussian_intensities.*gaussian_space;
		res = imgwindow.*weight;
		out(i,j) = sum(res(:))/sum(weight(:));
	end
end
		diff = out - img;
		diff = diff.*diff;
		diff = sum(diff(:))/(size(diff,1)*size(diff,2));
		RMSD = sqrt(diff)
		
        
        subplot(2,2,1),subimage(uint8(img)),title('Original Image');
        subplot(2,2,2),subimage(uint8(corrupted)),title('Corrupted Image');
        subplot(2,2,3),subimage(uint8(out)),title('Resulting Image');
        %subplot(2,2,4),colorbar
    %imshow(uint8(img));
    %imshow(uint8(corrupted));
	%imshow(uint8(out));
