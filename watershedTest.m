clear all
close all
clc

ferida = imread('1_c3.jpg');
%figure, imshow(ferida);

[y, x, z] = size(ferida);
ferida = ferida(y/4:7*y/8,x/8:7*x/8,:);
%figure, imshow(ferida);

ferida = rgb2gray(ferida);
%figure, imshow(ferida);


T = graythresh(ferida);
BW = im2bw(ferida, T);
BW = 1-BW;
%figure, imshow(BW);

nhood1 = ones(60,1);
J1 = imerode(BW,nhood1);
%figure, imshow(J1);
nhood2 = ones(1,60);
J2 = imerode(BW,nhood2);
%figure, imshow(J2);
J = J1 + J2;
figure, imshow(J);

bw = BW - J;

figure, imshow(bw);

L = watershed(bw);
L(~bw) = 0;
rgb = label2rgb(L,'jet',[.5 .5 .5]);
figure
imshow(rgb,'InitialMagnification','fit')

