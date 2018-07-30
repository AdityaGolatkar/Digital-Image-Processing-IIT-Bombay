%% MyMainScript

tic;
i = 0;
%% Your code here
h = waitbar(0,'Please wait...');

I1 = '../data/barbara.png'
figure(1),imshow(I1);
colorbar;

I2 = '../data/TEM.png'
figure(2),imshow(I1);
colorbar;

I3 = '../data/canyon.png'
figure(3),imshow(I1);
colorbar;

i = i + 0.05;
waitbar(i);

% myLinearContrastStretching for all images linearly

TEM_lcs = myLinearContrastStretching('../data/TEM.png');
figure(4),imshow(TEM_lcs);
colorbar;
barbara_lcs = myLinearContrastStretching('../data/barbara.png');
figure(5),imshow(barbara_lcs);
colorbar;
canyon_lcs = myLinearContrastStretching('../data/canyon.png');
figure(6),imshow(canyon_lcs);
colorbar;

i = i + 0.2;
waitbar(i);

%----------------------------------------------------------------------------------------------

% Canyon CLAHE
% correct one followed by the one with alpha halved

canyon_clahe = myCLAHE('../data/canyon.png',75,0.4);
figure(7),imshow(canyon_clahe);
colorbar;

i = i + 0.07;
waitbar(i);

canyon_clahe_h = myCLAHE('../data/canyon.png',75,0.2);
figure(8),imshow(canyon_clahe_h);
colorbar;

i = i + 0.08;
waitbar(i);

%----------------------------------------------------------------------------------------------

% barbara CLAHE
% correct one followed by the one with alpha halved

barbara_clahe = myCLAHE('../data/barbara.png',75,0.2);
figure(9),imshow(barbara_clahe);
colorbar;

i = i + 0.08;
waitbar(i);

barbara_clahe_h = myCLAHE('../data/barbara.png',75,0.1);
figure(10),imshow(barbara_clahe_h);
colorbar;

i = i + 0.07;
waitbar(i);


%----------------------------------------------------------------------------------------------

% TEM CLAHE
% correct one followed by the one with alpha halved

TEM_clahe = myCLAHE('../data/TEM.png',75,0.3);
figure(11),imshow(TEM_clahe);
colorbar;

i = i + 0.08;
waitbar(i);

TEM_clahe_h = myCLAHE('../data/TEM.png',75,0.15);
figure(12),imshow(TEM_clahe_h);
colorbar;

i = i + 0.07;
waitbar(i);

%----------------------------------------------------------------------------------------------

% Canyon AHE
% correct one followed by large and small window sizes

canyon_ahe = myAHE('../data/canyon.png',75);
figure(13),imshow(canyon_ahe);
colorbar;

i = i + 0.05;
waitbar(i);

canyon_ahe_large = myAHE('../data/canyon.png',200);
figure(14),imshow(canyon_ahe_large);
colorbar;

i = i + 0.05;
waitbar(i);

canyon_ahe_small = myAHE('../data/canyon.png',30);
figure(15),imshow(canyon_ahe_small);
colorbar;

i = i + 0.05;
waitbar(i);

%----------------------------------------------------------------------------------------------

% barbara AHE
% correct one followed by large and small window sizes

barbara_ahe = myAHE('../data/barbara.png',75);
figure(16),imshow(barbara_ahe);
colorbar;

i = i + 0.05;
waitbar(i);

barbara_ahe_large = myAHE('../data/barbara.png',200);
figure(17),imshow(barbara_ahe_large);
colorbar;

i = i + 0.05;
waitbar(i);

barbara_ahe_small = myAHE('../data/barbara.png',30);
figure(18),imshow(barbara_ahe_small);
colorbar;

i = i + 0.05;
waitbar(i);

%----------------------------------------------------------------------------------------------

% TEM AHE
% correct one followed by large and small window sizes

TEM_ahe = myAHE('../data/TEM.png',75);
figure(19),imshow(TEM_ahe);
colorbar;

i = i + 0.05;
waitbar(i);

TEM_ahe_large = myAHE('../data/TEM.png',200);
figure(20),imshow(TEM_ahe_large);
colorbar;

i = i + 0.05;
waitbar(i);

TEM_ahe_small = myAHE('../data/TEM.png',30);
figure(21),imshow(TEM_ahe_small);
colorbar;

i = i + 0.05;
waitbar(i);


close(h) 

toc;
