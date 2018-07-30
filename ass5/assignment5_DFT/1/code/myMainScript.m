%% MyMainScript
a = myPCADenoising1();
b = myPCADenoising2();
subplot(1,2,1), imshow(uint8(a)),title('PCADenoising 1 Result ');
subplot(1,2,2), imshow(uint8(b)),title('PCADenoising 2 Result ');
tic;
%% Your code here

toc;
