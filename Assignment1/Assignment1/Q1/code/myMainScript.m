%% MyMainScript

tic;
%% Your code here
i = 0;
h = waitbar(0,'Please wait...');
I1 = '../data/circles_concentric.png'
figure(1),imshow(I1)
colorbar

circles_concentric_d2 = myShrinkImageByFactorD('../data/circles_concentric.png',2)
figure(2),imshow(circles_concentric_d2)
colorbar
i = i + 1;
waitbar(i/4)


circles_concentric_d3 = myShrinkImageByFactorD('../data/circles_concentric.png',3)
figure(3),imshow(circles_concentric_d3)
colorbar
i = i + 1;
waitbar(i/4)

I2 = '../data/barbaraSmall.png'
figure(4),imshow(I2)
colorbar

barbaraSmall_nni = myNearestNeighborInterpolation('../data/barbaraSmall.png')
figure(5),imshow(barbaraSmall_nni)
colorbar
i = i + 1;
waitbar(i/4)

barbaraSmall_bi = myBilinearInterpolation('../data/barbaraSmall.png')
figure(6),imshow(barbaraSmall_bi)
colorbar
i = i + 1;
waitbar(i/4)


close(h) 

toc;
