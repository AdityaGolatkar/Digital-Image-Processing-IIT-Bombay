function O = myShrinkImageByFactorD(I,d)
%I = '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q1/data/circles_concentric.png';
MI = imread(I);
[s1,s2] = size(MI);
%s1=s2=512
%d = 2 or 3;

MO = zeros(floor(s1/d),floor(s2/d));
for i = 1:s1/d
    for j = i:s2/d
        MO(d*j , d*i) = MI(d*j , d*i);
        MO(d*i , d*j) = MI(d*i , d*j);
    end;
end;
O = mat2gray(MO);



%figure(2),imshow(O);
%colorbar


%imwrite(O,'/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q1/output/circles_concentric_d3.png')