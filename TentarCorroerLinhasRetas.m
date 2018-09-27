clear all
close all
clc

ferida = imread('7_c1.jpg');
figure, imshow(ferida);

[y, x, z] = size(ferida);
ferida = ferida(y/4:7*y/8,x/8:7*x/8,:);
%figure, imshow(ferida);

ferida = rgb2gray(ferida);
figure, imshow(ferida);


T = graythresh(ferida);
BW = im2bw(ferida, T);
BW = 1-BW;
%figure, imshow(BW);



nhood1 = [ones(60,1) ];
J1 = imerode(BW,nhood1);
%figure, imshow(J1);
nhood2 = [ones(1,60) ];
J2 = imerode(BW,nhood2);
%figure, imshow(J2);

J = J1 + J2 ;
figure, imshow(J);

bw = BW - J;

figure, imshow(bw);

se1 = strel('square', 3);
se2 = strel('square', 7);

c = imclose(bw, se1);      %fechamento

o = imopen(c, se2);

figure
imshow(o)