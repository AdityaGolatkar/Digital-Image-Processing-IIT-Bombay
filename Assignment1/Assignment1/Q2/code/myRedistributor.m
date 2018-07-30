function CDF = myRedistributor(I,alpha)
H = imhist(I);
M = max(H(:));
threshold = alpha*M;
cut = 0;
for i = 1:1:256
    if(H(i) > threshold)
        cut = cut + (H(i)-threshold);
        H(i) = threshold;
    end
end
add = cut/256;
H = H + add;
CDF = zeros(1,256);
CDF(1) = H(1);
for i = 2:1:256
    CDF(i) = CDF(i-1)+H(i);
end;
%end