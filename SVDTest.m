%A = dlmread('matA.txt');
A = [11 7 5 1 5; 2 31 71 39 7; 33 18 19 80 23];
[U,V,S] = mySVD(A)
%[U,S,V] = svd(A);
T = U*S;
B = T*V'
%B = uint16(B)
%C = U2*S2*V2'

if(A == B)
    disp('Correct');
else
    disp('Incorrect');
end