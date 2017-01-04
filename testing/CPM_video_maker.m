% -*- coding: utf-8 -*-
% 本脚本 实现将视频分割成帧，后对每帧图片进行预测，并将预测结果合成视频
% 張正軒 (bond@mindcont.com)
% 更多访问  http://blog.mindcont.com

clc;
clear;
close all;

addpath('src');
addpath('util');
addpath('util/ojwoodford-export_fig-5735e6d/');
param = config();
facealpha = 0.6; % for limb transparency

fprintf('Description of selected model: %s \n', param.model(param.modelID).description);


%% 视频文件读取，并将帧保存到当前文件夹　jpg 文件
% video = VideoReader('./sample_image/videos/minh_640_480.ogv');
% nFrames = video.NumberOfFrames;
% vidHeight = video.Height;
% vidWidth = video.Width;
% ii = 1;
%
% for k = 1 : nFrames
%    img = read(video, k); %读取第k帧，存入im中
%    filename = ['img_',num2str(k,'%05i'),'.jpg'];
%    fullname = fullfile(pwd,'images',filename);
%    imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
%    ii = ii+1;
% end

%% 加载caffe deployprototxt 和训练好的caffemodel 对提取的每帧图片进行预测，并将预测结果保存 .mat
model = param.model(param.modelID);
net = caffe.Net(model.deployFile, model.caffemodel, 'test');

imgdir = '/home/pi/data/test-of/taichi_xuan_0/'; %待预测视频帧
savedir =  '/home/pi/data/test-of/prediction/';  %可视化预测结果，每帧的保存路径
imgnum = length(dir(strcat(imgdir,'*.jpg')))/3;  % optical flow x ,y oriImg 各占三分之一

% RELEASE_predicted = zeros(14,2,imgnum);
% for i = 1:imgnum
%
% 	% load image, objpos, and scale, but might fail
% 	try
% 	    oriImg = imread([imgdir,'img_',num2str(i,'%05i'),'.jpg']);
% 	catch
% 	    error('image cannot be loaded, make sure you have %s', imgdir);
%     end
% 	 [heatMaps, prediction] = applyNet(oriImg,net,param);
% 	 RELEASE_predicted(:,:,i) = prediction;
% end
% save('RELEASE_predicted.mat', 'RELEASE_predicted');

for i = 1:imgnum
    oriImg = imread([imgdir,'img_',num2str(i,'%05i'),'.jpg']);
    draw_skeleton(RELEASE_predicted(:,:,i) ,oriImg);
    saveas(gcf,[savedir,'pre_',num2str(i,'%05i'),'.jpg'])
end

%%将可视化后的各帧重新合并为avi 文件
%Find all the JPEG file names in the images folder. Convert the set of image names to a cell array.

savedir =  '/home/pi/data/test-of/prediction/';
imageNames = dir(fullfile(savedir,'*.jpg'));
imageNames = {imageNames.name};

%创建新的视频图像序列
%Construct a VideoWriter object, which creates a Motion-JPEG AVI file by default.

outputVideo = VideoWriter(fullfile(pwd,'taichi_xuan.avi'));
outputVideo.FrameRate = 8; %视频帧率
open(outputVideo);

%Loop through the image sequence, load each image, and then write it to the video.

for ii = 1:length(imageNames)
   img = imread(fullfile(savedir,imageNames{ii}));
   writeVideo(outputVideo,img)
end

close(outputVideo);
