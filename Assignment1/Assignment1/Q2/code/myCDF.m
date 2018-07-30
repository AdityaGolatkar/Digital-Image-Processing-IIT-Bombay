function CDF = myCDF(MI)
%I = '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q2/data/TEM.png';
H = imhist(MI);
%h = histogram(H)
CDF = zeros(1,256);
CDF(1) = H(1);
for i = 2:1:256
    CDF(i) = CDF(i-1)+H(i);
end;
