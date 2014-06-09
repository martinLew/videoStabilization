clear all;close all;clc;

I = imread('D:\study\Frames\0006.jpg');
I = double(rgb2gray(I));
I = imresize(I, [256,512]);
uv = randn([size(I),2]);
x = 1:size(I, 1);
y = 1:size(I, 2);
Z = meshgrid(x, y);
Z = Z';
Z2 = meshgrid(y, x);
Z = cat(3, Z2, Z);
uv = uv + Z;

Ilat = myBilinear(I, uv, 4);
figure;
imshow(I, []);
figure;
imshow(Ilat, []);