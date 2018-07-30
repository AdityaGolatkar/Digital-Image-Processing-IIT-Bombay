function MO = AHE(MI,windowSize)
%MI = imread(I);
s = size(MI);
delta = (windowSize-1)/2;
MO = zeros(s);
for i = 1:1:s(1)
    wi = max(1,i-delta):1:min(s(1),i+delta);
    for j = 1:1:s(2)
        wj = max(1,j-delta):1:min(s(2),j+delta);
        AI = MI(wi,wj);
        CDF = myCDF(AI);
        MO(i,j) = uint8(255*CDF(MI(i,j)+1)/CDF(256));
    end
end

%O = mat2gray(MO);
%figure(1), imshow(O);