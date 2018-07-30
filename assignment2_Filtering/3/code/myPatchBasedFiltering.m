function [] = myPatchBasedFiltering(image)

img = imread(image);
img = double(img);
noise = mormrnd(0,12.5,size(img));
corrupted = round(img+noise);
w = 14;
wp = 4;

for i=1:size(img,1)
	for j=1:size(img,2)
		rows = max(1,i-w):min(size(img,1),i+w);
		cols = max(1,j-w):min(size(img,2),j+w);
		imgwindow = corrupted(rows,cols);
		
		currProws = max(1,i-wp):min(size(img,1)),i+wp);
		currPcols = max(1,j-wp):min(size(img,2)),j+wp);
		for k=rows
			for l=cols
				prows = max(rows(1),k-wp):min(rows(size(rows,2)),k+wp);
				pcols = max(cols(1),l-wp):min(cols(size(cols,2)),l+wp);
				patch = corrupted(p
