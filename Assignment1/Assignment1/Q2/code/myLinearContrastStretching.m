function O = myLinearContrastStretching(I)
%I = '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q2/data/canyon.png';
MI = imread(I);


ndims(MI)
size(MI)
%imhist(MI);
m = min(MI(:));
M = max(MI(:));
MO = (255/(M-m))*(MI-m);
O = mat2gray(MO);
%imwrite(O, '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q2/output/canyon_lcs.png');

% figure(2), imshow(O);
% colorbar
end