function [im2] = myPCADenoising2()
variance = 1000;
im = imread('../data/barbara256.png');                           %Reading the image.
im = double(im);
im1 = im + randn(size(im))*20;				%Adding noise to the image.
sz = size(im1);								%Get the size of the image.
N = 1;
previmg = zeros(sz);
currimg = previmg;
count = currimg;
for i = 1 : sz(1)-6						%Storing the patches in the P matrix.
	for j = 1 : sz(2)-6

		temp = im1(i:i+6,j:j+6);
		P(:,N) = temp(:);
		row = max(1,i-15):min(i+15,sz(2));
		col = max(1,j-15):min(j+15,sz(1));
		patchwind = im1(row,col);

		M=1;
		for k=1:size(patchwind,1)-6
			for l=1:size(patchwind,2)-6
				temp1 = patchwind(k:k+6,l:l+6);
				neigh(:,M) = temp1(:);
				M=M+1;
			end
		end
		M=M-1;

		differ = bsxfun(@minus,neigh,P(:,N));
		differ1 = differ.*differ;
		sumdiffer1 = sum(differ1,1);
		storesummdiffer1 = sumdiffer1;
		sorted = sort(sumdiffer1);
        size(neigh);
		for m=1:min(200,M)
			pos = find(sumdiffer1==sorted(m));
			Q(:,m) = neigh(:,pos(1));
			sumdiffer1(pos(1)) = -1;
		end

		Q1 = Q*(Q');
		[V eigv] = eig(Q1);
        size(V);
		%for n = 1 : min(200,M)
			n = 1 : min(200,M); 
			alpha(:,n) = (V')*Q(:,n);
		%end

		n=1:size(temp(:));
		avgsq_eig(n) = max(0,sum(alpha(n,:)*(alpha(n,:)'))*(1/min(200,M)) - variance);
		alpharef = (V')*P(:,N);
        size(alpharef);
        for n=1:size(temp(:))
            betaref(n,1) = (1/(1+(variance/avgsq_eig(n))))*alpharef(n);
        end
        size(betaref);
        
		Qrefden = V*betaref;
		for o=1:7
			temp2(:,o)=Qrefden(o:o+6);
		end
		previmg(i:i+6,j:j+6) = temp2;
		currimg = currimg + previmg;
		previmg(i:i+6,j:j+6) = zeros(7,7);
        count(i:i+6,j:j+6) = count(i:i+6,j:j+6) + ones(7,7);
	end
end
N=N-1;
im2 = currimg./count;
im2 = double(im2);
diff = im - im2;
diff = diff.*diff;
sqerror = sum(diff(:));
errormean = sqerror/(sz(1)*sz(2));
error = sqrt(errormean)
%subplot(2,2,1), imshow(uint8(im1)),title('Corrupted Image');
%subplot(2,2,2), imshow(uint8(im2)),title('Reconstructed Image');
%imwrite(uint8(im2),'PCADenoising_2_ResultBarbaraPart.png');