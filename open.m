function [] = open()
cd s1;
for i=1:10
  temp = imread(i+'.pgm');
  a(:,i) = temp(:);
end