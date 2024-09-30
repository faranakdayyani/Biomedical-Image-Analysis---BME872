close all
clear all

% Lung CT %
imageFormat = 'mhd';
path = 'C:\Users\Owner\Desktop\image analysis\project\Lab1 - LungCT\Lab1 - LungCT\noise_0.5x_post.mhd';
[img_n, info_n] = imageRead(path, imageFormat);
volCT_n = img_n.data;
infoCT_n = info_n;
img = volCT_n(:,:,143);

figure;
subplot(1,2,1);
imshow(img,[]);
title('Lung CT image with 0.5x noise');
colorbar;
subplot(1,2,2);
histogram(img,'Normalization','probability');
title('Histogram of the Lung CT with 0.5x noise');
xlabel('Intensity');
ylabel('Normalized Number of Occurance (PDF)');

% Brain MRI2 %
% imageFormat = 'mat';
% path = 'C:\Users\Owner\Desktop\image analysis\project\Lab1 - BrainMRI2\Lab1 - BrainMRI2\brainMRI_1.mat';
% [img, info] = imageRead(path, imageFormat);
% volBrain = img.vol;
% img = volBrain;
% figure;
% subplot(1,2,1);
% imshow(img(:,:,100),[]);
% title('A slice of Brain MRI image');
% colorbar;
% subplot(1,2,2);
% histogram(img,'Normalization','probability');
% title('Histogram of Brain MRI volume');
% xlabel('Intensity');
% ylabel('Normalized Number of Occurance (PDF)');

% Measure noise-ness %
N = imageQuality_noise(img);

% Eliminating black area in Lung CT
img = volCT_n;
[x y z] = size(img);
for k = 1:z
    img1(:,:,k) = contrast_stretch(img(:,:,k)); %Image enhancment [0 255]
    img(:,:,k) = double(img1(:,:,k));
end

mask = img(:,:,143) > 30; 
props = regionprops(mask, 'BoundingBox');
img = imcrop(img(:,:,143), props.BoundingBox); % Crop the image to the bounding box.

% % Justify Quality of Contrast %
C = imageQuality_contrast(img);

% Justify Quality of Edge %
E = imageQuality_edge(img);

imageQuality(N, C, E);