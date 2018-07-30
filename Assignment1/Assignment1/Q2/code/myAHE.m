function  MO = myAHE(I,WindowSize)

WindowSize = uint8(WindowSize);
MI = imread(I);

if(ndims(MI) == 3)

MIR = MI(:,:,1);
MIG = MI(:,:,2);
MIB = MI(:,:,3);
IN = cat(3,MIR,MIG,MIB);
s = size(MI);
Z = zeros(s(1),s(2),'uint8');
MOR = AHE(MIR,WindowSize);
MORU = uint8(MOR);
MOG = AHE(MIG,WindowSize);
MOGU = uint8(MOG);
MOB = AHE(MIB,WindowSize);
MOBU = uint8(MOB);
MO = cat(3,MORU,MOGU,MOBU);

else
MOU = AHE(MI,WindowSize);
MO = uint8(MOU);
end



%imwrite(MO, '/home/nocktowl/Softwares/Files/Matlab/Assignment1/Q2/output/canyon_ahe_large.png');

