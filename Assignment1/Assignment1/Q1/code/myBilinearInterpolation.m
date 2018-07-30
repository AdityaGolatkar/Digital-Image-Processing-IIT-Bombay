function O = myBilinearInterpolation(I)
%I = '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q1/data/barbaraSmall.png';
MI = imread(I);
[m,n] = size(MI);
%s1=s2=512


MO = zeros(3*m-2,2*n-1);

i = 1:3:3*m-2
j = 1:2:2*n-1
MO(i , j) = MI((i+2)/3 , (j+1)/2);

i = 1:3:3*m-5
j = 1:2:2*n-3
MO(i , j+1) = (MO(i , j) + MO(i , j+2))/2;
MO(i+1, j) = (2*MO(i , j) + MO(i+3 , j))/3;
MO(i+2, j) = (MO(i , j) + 2*MO(i+3 , j))/3;

% right corner adjustment
j = 1:2:2*n-3
MO(3*m-2 , j+1) = (MO(3*m-2 , j) + MO(3*m-2 , j+2))/2;

% bottom adjustment
i = 1:3:3*m-5
MO(i+1 , 2*n-1) = (2*MO(i , 2*n-1) + MO(i+3 , 2*n-1))/3;
MO(i+2, 2*n-1) = (MO(i , 2*n-1) + 2*MO(i+3 , 2*n-1))/3;


% remaining interpolations
i = 1:3:3*m-5
j = 1:2:2*n-3
MO(i+1, j+1) = (MO(i+1 , j) + MO(i+1 , j+2))/2;
MO(i+2, j+1) = (MO(i+2 , j) + MO(i+2 , j+2))/2;


O = mat2gray(MO);
%imwrite(O, '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q1/output/barbaraSmall_bi.png');

end