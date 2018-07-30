function [] = notchFilterImplementation()
load('../data/image_low_frequency_noise.mat')
img = zeros(512,512);
img(129:128+256,129:128+256) = Z;
fft_img = fftshift(fft2(img));
log_fft_img = log(abs(fft_img)+1);

%imwrite(log_fft_img,'LogFFTImg.png');
%imshow(log_fft_img,[-1 10]);
bar = imread('../../1/data/barbara256.png');
%imshow(uint8(bar));
temp = zeros(512,512);
temp(129:128+256,129:128+256) = bar;
%temp = temp - img;
fftb = fftshift(fft2(temp));
logb = log(abs(fftb)+1);

%imshow(log_fft_img,[-1 10]) ,colormap(jet) ,colorbar;
%subplot(1,2,2), imshow(logb,[-1 10]), colormap(jet),colorbar,title('ActualFFT');

[notch_filter1] = myIdealNotchFilter(21,33,75,[512,512]);
[notch_filter2] = myIdealNotchFilter(23,-31,-77,[512,512]);
[notch_filter3] = myIdealNotchFilter(30,33,185,[512,512]);
[notch_filter4] = myIdealNotchFilter(10,-5,185,[512,512]);
[notch_filter5] = myIdealNotchFilter(18,78,181,[512,512]);
[notch_filter6] = myIdealNotchFilter(20,-33,-175,[512,512]);
%effective_notchfilter= notch_filter1 + notch_filter2;

%fft_img = fft_img.*notch_filter0;
fft_img = fft_img.*notch_filter1;
fft_img = fft_img.*notch_filter2;
fft_img = fft_img.*notch_filter3;
fft_img = fft_img.*notch_filter4;
fft_img = fft_img.*notch_filter5;
fft_img = fft_img.*notch_filter6;
%fft_img(rn+35,cn+35)= fft_img(rn+35,cn+35)+100;
  
log_fft_img = log(abs(fft_img)+1);

%subplot(1,2,1), imshow(log_fft_img,[-1 10]) ,colormap(jet) ,colorbar, title('NewFFT');
%subplot(1,2,2), imshow(logb,[-1 10]), colormap(jet),colorbar,title('OldFFT');

finalimage = ifft2(ifftshift(fft_img));
size(finalimage);
result = finalimage(129:128+256,129:128+256);
%imwrite(uint8(result),'RestoredImage.png');
imshow(uint8(result));
%imshow(uint8(Z));
    