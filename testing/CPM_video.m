%% Demo code of "Convolutional Pose Machines",
% Shih-En Wei, Varun Ramakrishna, Takeo Kanade, Yaser Sheikh
% In CVPR 2016
% Please contact Shih-En Wei at shihenw@cmu.edu for any problems or questions
%%
close all;
clear all;
addpath('src');
addpath('util');
addpath('util/ojwoodford-export_fig-5735e6d/');
param = config();
facealpha = 0.6; % for limb transparency

fprintf('Description of selected model: %s \n', param.model(param.modelID).description);

%% Edit this part
% put your own test image here
%test_image = 'sample_image/singer.jpg';
%test_image = 'sample_image/shihen.png';
%test_image = 'sample_image/roger.png';
%test_image = 'sample_image/nadal.png';
%test_image = 'sample_image/LSP_test/im1640.jpg';
%test_image = 'sample_image/CMU_panoptic/00000998_01_01.png';
%test_image = 'sample_image/CMU_panoptic/00004780_01_01.png';
%test_image = 'sample_image/FLIC_test/princess-diaries-2-00152201.jpg';
%test_image = 'sample_image/videos/jpg/original_frame37.jpg';
test_image = 'sample_image/test1.png';

%interestPart = 'Lwri'; % to look across stages. check available names in config.m

%v = VideoReader('sample_image/videos/handshake_left.avi');
%test_image = readFrame(v);

%% core: apply model on the image, to get heat maps and prediction coordinates
figure(1);
imshow(test_image);
hold on;
%title('Drag a bounding box');
%rectangle = getrect(1);
%[heatMaps, prediction] = applyModel(test_image, param, rectangle);
[heatMaps, prediction] = applyModel(test_image, param);

%% visualize, or extract variable heatMaps & prediction for your use
%visualize(test_image, heatMaps, prediction, param, rectangle, interestPart);


%imshow(im(y_start:y_end, x_start:x_end, :));
hold on;
bodyHeight = max(prediction(:,2)) - min(prediction(:,2));
model = param.model(param.modelID);

%plot_visible_limbs(model, facealpha, prediction, truncate, bodyHeight/30);
plot_visible_limbs(model, facealpha, prediction, bodyHeight/30);
plot(prediction(:,1), prediction(:,2), 'k.', 'MarkerSize', bodyHeight/32);
title('Full Pose');
