function MO = HE(MI)

s = size(MI);
CDF = myCDF(MI);
i = 1:1:s(1);
j = 1:1:s(2);
MO(i,j) = uint8(255*CDF(MI(i,j)+1)/CDF(256));
