function [] = notchFilterImplementation()
load('../data/image_low_frequency_noise.mat')
img = zeros(512,512);
img(129:128+256,129:128+256) = Z;

%imshow(uint8(Z));
bar = imread('../../1/data/barbara256.png');
%imshow(uint8(bar));
temp = zeros(512,512);
temp(129:128+256,129:128+256) = bar;
fftb = fftshift(fft2(temp));
logb = log(abs(fftb)+1);

fft_img = fftshift(fft2(img));
log_fft_img = log(abs(fft_img)+1);
cp = log_fft_img;
size(log_fft_img);

%subplot(1,2,1), imshow(log_fft_img,[-1 10]) ,colormap(jet) ,colorbar, title('NewFFT');
%subplot(1,2,2), imshow(logb,[-1 10]), colormap(jet),colorbar,title('OldFFT');

s = size(img);
size(log_fft_img);
[m i] = max(log_fft_img);
m1 = max(m);
pos = find(m==m1);
rowofmax= pos;
colofmax= i(pos);
copyimg = log_fft_img;
log_fft_img(rowofmax-50:rowofmax+50,colofmax-50:colofmax+50) = zeros(101,101);
M=1;
for r=1:256-40
    for c=1:256-40
        patch = log_fft_img(r:r+40,c:c+40);
        patch = patch(:);
        k = find(patch>10);
        data(M,1)= r;
        data(M,2)= c;
        data(M,3)= size(k,1);
        M=M+1;
    end
end
[maxi ind]= max(data(:,3));
rn = data(ind,1);
cn = data(ind,2)+5;
log_fft_img(rn-30:rn+100,cn-30:cn+100) = zeros(131,131);


M=1;
for r=257:512-40
    for c=257:512-40
        patch1 = log_fft_img(r:r+40,c:c+40);
        patch1 = patch1(:);
        k1 = find(patch1>10);
        data1(M,1)= r;
        data1(M,2)= c;
        data1(M,3)= size(k1,1);
        M=M+1;
    end
end
[maxi ind]= max(data1(:,3));
rn1 = data1(ind,1);
cn1 = data1(ind,2)+5;
log_fft_img(rn1-60:rn1+70,cn1-60:cn1+70) = zeros(131,131);

%[notch_filter0] = myGaussianNotchFilter(70,0,0,[512,512]);
[notch_filter1] = myIdealNotchFilter(15,33,78,[512,512]);
[notch_filter2] = myIdealNotchFilter(23,-31,-77,[512,512]);
[notch_filter3] = myIdealNotchFilter(85,0,256,[512,512]);
[notch_filter4] = myIdealNotchFilter(85,0,-256,[512,512]);
[notch_filter5] = myIdealNotchFilter(85,256,0,[512,512]);
[notch_filter6] = myIdealNotchFilter(85,-256,0,[512,512]);
%effective_notchfilter= notch_filter1 + notch_filter2;

%fft_img = fft_img.*notch_filter0;
fft_img = fft_img.*notch_filter1;
fft_img = fft_img.*notch_filter2;
%fft_img = fft_img.*notch_filter3;
%fft_img = fft_img.*notch_filter4;
%fft_img = fft_img.*notch_filter5;
%fft_img = fft_img.*notch_filter6;
%fft_img(rn+35,cn+35)= fft_img(rn+35,cn+35)+100;
  
log_fft_img = log(abs(fft_img)+1);

%subplot(1,2,1), imshow(log_fft_img,[-1 10]) ,colormap(jet) ,colorbar, title('NewFFT');
%subplot(1,2,2), imshow(logb,[-1 10]), colormap(jet),colorbar,title('OldFFT');

finalimage = ifft2(ifftshift(fft_img));
size(finalimage);
result = finalimage(129:128+256,129:128+256);
imshow(uint8(result));
imshow(uint8(Z));
    
    
