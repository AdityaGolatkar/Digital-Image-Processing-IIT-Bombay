function = myBilateralFiltering(img)

%load(img);
img = imread(img);
noise = normrnd(0,12.5,size(img));
corrupted = img + noise;
w = 5;
sigma_i = 1;
sigma_s = 1;

for i =1:size(img,1)
	for j=1:size(img,2)
		rows = max(1,i-w):min(size(img,1),i+w);
		cols = max(1,j-w):min(size(img,2),j+w);	
		imgwindow = img(rows,cols);
		intensities = imgwindow - img(i,j);
		
		cols = cols';
		xcoordinates = rows(ones(length(cols,1),:));
		ycoordinates = cols(:,ones(1,length(rows))); 
		xcoordiff = xcoordinates - i;
		ycoordiff = ycoordinates - j;
		xcoorsqr = xcoordiff.*xcoordiff;
		ycoorsqr = ycoordiff.*ycoordiff;
		distsqr = xcoorsqr + ycoorsqr;
		sqrdist = sqrt(distsqr);
		space = sqrdist;

		cols = cols';

		gaussian_intensities = normpdf(intensities,img(i,J),sigma_i);
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
		

	imshow(out);
