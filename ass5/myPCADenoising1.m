function [] = myPCADenoising1()
variance = 1000;
im = imread('../data/barbara256.png');                           %Reading the image.
im = double(im);
im1 = im + randn(size(im))*20;				%Adding noise to the image.
sz = size(im1);								%Get the size of the image.
N = 1;										%Patch No
for i = 1 : sz(1)-6						%Storing the patches in the P matrix.
	for j = 1 : sz(2)-6
		temp = im1(i:i+6,j:j+6);
		P(:,N) = temp(:);
		N = N+1;
	end
end

N = N-1;
P1 = P*(P');
[V eigv] = eig(P1);
for i = 1 : N
	alpha(:,i) = (V')*P(:,i);
end

i=1:size(temp(:));
avgsq_eig(i) = max(0,sum(alpha(i,:)*(alpha(i,:)'))*(1/N) - variance);

for k = 1 : size(temp(:))
	for l = 1 : N
		alpha_denoised(k,l) = alpha(k,l)/(1+(variance/avgsq_eig(k)));
	end
end

k = 1:N;
P_reconst(:,k) = V*alpha_denoised(:,k);

M = 1;
previmg = zeros(sz);
currimg = previmg;
count = currimg;
for i = 1 : sz(1)-6						
	for j = 1 : sz(2)-6
		for q = 1 : 7
			temp1(:,q) = P_reconst(q:q+6,M);
		end
		previmg(i:i+6,j:j+6) = temp1;
		currimg = currimg + previmg;
		previmg(i:i+6,j:j+6) = zeros(7,7);
        count(i:i+6,j:j+6) = count(i:i+6,j:j+6) + ones(7,7);
		M=M+1;
	end
end


im2 = currimg./count;
im2 = double(im2);
%imshow(uint8(im2))

diff = im - im2;
diff = diff.*diff;
sqerror = sum(diff(:));
sqerrormean = sqerror/(sz(1)*sz(2))


subplot(2,2,1), imshow(uint8(im1)),title('Corrupted Image');
subplot(2,2,2), imshow(uint8(im2)),title('Reconstructed Image');
subplot(2,2,3), imshow(uint8(im)), title('Original Image');