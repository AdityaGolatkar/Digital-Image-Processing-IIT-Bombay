function [ncc] = NormalizedCrossCorrelation(image,kernel)

mat = imread(image);

nmat = mat - mean(mat(:));
sqnmat = nmat.*nmat;
nmat = nmat/(sqrt(sum(sqnmat(:))));

nkernel = kernel - mean(kernel(:));
sqkernel = nkernel.*nkernel;
nkernel = nkernel/(sqrt(sum(sqkernel(:))));

mat = nmat;
kernel = nkernel;

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
	
r = r(size(kernel,1):size(kernel,1)+size(mat,1)-1,size(kernel,2):size(kernel,2)+size(mat,2)-1);
ncc = r;	
