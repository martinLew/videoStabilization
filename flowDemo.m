clear all;close all;clc;

frameDir = 'D:\study\Frames';
frames = dir(frameDir);
frames = frames(3:end);
Fnums = length(frames);          % the num of frames
Fnames = {};                     % contain the names of frames, such as '0001.jpg'
for i=1:Fnums
    Fnames = [Fnames, frames(i).name];
end

%%  here's the main loop
%    deal with every frames

for i=1:Fnums-1;
    im1 = imread([frameDir, '\', Fnames{i}]);
    im2 = imread([frameDir, '\', Fnames{i+1}]);
    im1 = double(rgb2gray(im1));
    im2 = double(rgb2gray(im2));
    im1 = imresize(im1, [256,512], 'bicubic');
    im2 = imresize(im2, [256,512], 'bicubic');
    imgs = cat(3, im1, im2);
    
    % get the texture image to exclude the effect of light
    txeImg = structure_texture_decomposition_rof(imgs); % use default param 
    M = optical_flow(txeImg);        % two matrix u and v
    
end