%% Demo code of "Convolutional Pose Machines",
% Shih-En Wei, Varun Ramakrishna, Takeo Kanade, Yaser Sheikh
% In CVPR 2016
% Please contact Shih-En Wei at shihenw@cmu.edu for any problems or questions
%%


close all;
clear ;
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
%test_image = 'sample_image/LSP_test/im1640.jpg';
%test_image = 'sample_image/FLIC_test/princess-diaries-2-00152201.jpg';
%test_image = 'sample_image/7.jpg';
%test_image = 'sample_image/dancer.png';
%test_image = 'sample_image/103429.jpg';
%test_image = 'sample_image/nadal.png';
%test_image= 'sample_image/videos/hope.jpg'
%test_image = 'sample_image/ours/xuan2.jpg';
%test_image = 'sample_image/vlcsnap-2017-01-01-15h45m09s142.png';
test_image = 'sample_image/ours/xuan/xuan_9.png';

%interestPart = 'head'; % to look across stages. check available names in config.m

v = VideoReader('./sample_image/ours/V61218-161421.ogv');
nFrames = v.NumberOfFrames;
fprintf('video Name is:%s \nHeight: %d\nWidth: %d\nFrameRate: %d\nVideoFormat: %s\ntotalFrames: %d\n',v.Name,v.Height,v.Width,v.FrameRate,v.VideoFormat,v.NumberOfFrames);
model = param.model(param.modelID);
net = caffe.Net(model.deployFile, model.caffemodel, 'test');

% for k = 1 : nFrames
%     test_image = read(v, k);
%
%     %% core: apply model on the image, to get heat maps and prediction coordinates
%     figure(1);
%     imshow(test_image);
%     hold on;
%
%     [heatMaps, prediction] = applyNet(test_image,net,param);
%     bodyHeight = max(prediction(:,2)) - min(prediction(:,2));
%
%     plot_visible_skeleton(model, facealpha, prediction, bodyHeight/30);
%     draw_skeleton(prediction,test_image);
%     title('Full Pose');
%
% end

%% core: apply model on the image, to get heat maps and prediction coordinates
figure(1);
imshow(test_image);
hold on;
img = imread(test_image);

[heatMaps, prediction] = applyNet(img,net,param);
bodyHeight = max(prediction(:,2)) - min(prediction(:,2));

plot_visible_skeleton(model, facealpha, prediction, bodyHeight/30);
draw_skeleton(prediction,img);
title('Full Pose');
