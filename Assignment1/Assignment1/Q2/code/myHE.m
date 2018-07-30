function MO = myHE(I)
%I = '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q2/data/canyon.png';

MI = imread(I);
% figure(1),imshow(MI);
% colorbar
if(ndims(MI) == 3)

MIR = MI(:,:,1);
MIG = MI(:,:,2);
MIB = MI(:,:,3);
IN = cat(3,MIR,MIG,MIB);
s = size(MI);
Z = zeros(s(1),s(2),'uint8');
MOR = HE(MIR);
MORU = uint8(MOR);
MOG = HE(MIG);
MOGU = uint8(MOG);
MOB = HE(MIB);
MOBU = uint8(MOB);
MO = cat(3,MORU,MOGU,MOBU);

else
MOU = HE(MI);
MO = uint8(MOU);
end

% figure(2),imshow(MO);
% colorbar
%imwrite(MO, '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q2/output/TEM_he.png');
