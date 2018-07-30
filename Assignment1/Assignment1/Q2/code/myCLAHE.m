function  MO = myCLAHE(I,windowSize,alpha)

MI = imread(I);
windowSize = uint8(windowSize);
alpha = double(alpha);

% figure(1),imshow(MI);
% colorbar

if(ndims(MI) == 3)
MIR = MI(:,:,1);
MIG = MI(:,:,2);
MIB = MI(:,:,3);
IN = cat(3,MIR,MIG,MIB);
s = size(MI);
Z = zeros(s(1),s(2),'uint8');
MOR = CLAHE(MIR,windowSize,alpha);
MORU = uint8(MOR);
MOG = CLAHE(MIG,windowSize,alpha);
MOGU = uint8(MOG);
MOB = CLAHE(MIB,windowSize,alpha);
MOBU = uint8(MOB);
MO = cat(3,MORU,MOGU,MOBU);
 

else
MOU = CLAHE(MI,windowSize,alpha);
MO = uint8(MOU);

end


%imwrite(MO, '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q2/output/canyon_clahe.png');