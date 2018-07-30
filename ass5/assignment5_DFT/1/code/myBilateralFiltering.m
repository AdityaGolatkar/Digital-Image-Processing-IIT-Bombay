function [] = myBilateralFiltering()

sigma_i=60;
sigma_s=40;
win= 7;
corrupted = imread('../data/barbara256.png');
orig = corrupted;
orig = double(orig);
corrupted = double(corrupted);
corrupted = corrupted + randn(size(corrupted))*20;

img = corrupted;
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
		diff = out - orig;
		diff = diff.*diff;
		diff = sum(diff(:))/(size(diff,1)*size(diff,2));
		error = sqrt(diff)
		
        
        
        subplot(2,2,2),subimage(uint8(corrupted)),title('Corrupted Image');
        subplot(2,2,3),subimage(uint8(out)),title('Resulting Image');
        %imwrite(uint8(out),'Bilateral_ResultBarbaraPart.png');
       
