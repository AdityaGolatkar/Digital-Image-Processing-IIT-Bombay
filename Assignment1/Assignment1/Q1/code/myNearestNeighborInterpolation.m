function O = myNearestNeighborInterpolation(I)
%I = '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q1/data/barbaraSmall.png';
MI = imread(I);
[m,n] = size(MI);
MO = zeros(3*m-2,2*n-1);



% Putting the input pixels in the appropriate positions
i = 1:3:3*m-2;
j = 1:2:2*n-1;
MO(i , j) = MI((i+2)/3 , (j+1)/2);

% Filling pixels in all positions except bottom and right corner
i = 1:3:3*m-5;
j = 1:2:2*n-3;
MO(i , j+1) = MO(i , j);
MO(i+1, j) = MO(i , j);
MO(i+2, j) = MO(i+3 , j);
MO(i+1, j+1) = MO(i , j);
MO(i+2, j+1) = MO(i+3 , j);

% right corner adjustment
j = 1:2:2*n-3;
MO(3*m-2 , j+1) = MO(3*m-2 , j);

% bottom adjustment
i = 1:3:3*m-5;
MO(i+1 , 2*n-1) = MO(i , 2*n-1);
MO(i+2, 2*n-1) = MO(i+3 , 2*n-1);

O = mat2gray(MO);
%imwrite(O,'/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q1/output/barbaraSmall_nni.png');


end