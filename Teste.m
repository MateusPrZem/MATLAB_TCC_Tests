clear all
close all
clc

ferida = imread('1_c3.jpg');
figure, imshow(ferida);

[y, x, z] = size(ferida);

ferida = ferida(y/4:7*y/8,x/8:7*x/8,:);
figure, imshow(ferida);

ferida = rgb2gray(ferida);
figure, imshow(ferida);

T = graythresh(ferida);

BW = im2bw(ferida, T);
BW = 1-BW;
figure, imshow(BW);

[H, T, R]  = hough(BW);
P = houghpeaks(H,100);
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(ferida), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% 
%    % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end
end

for k = 1:length(lines)
    if lines(k).theta == -90
        BW(lines(k).point1(1),lines(k).point1(2):lines(k).point2(2)) = 0;
    end
end

figure, imshow(BW);