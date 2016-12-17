% -*- coding: utf-8 -*-
% 本脚本测试用
% 張正軒 (bond@mindcont.com)
% 更多访问  http://blog.mindcont.com

% ffmpeg -i minh.mp4 -acodec copy -vcodec copy minh.avi 使用ffmpeg 将mp4 转码为　avi 封装，值得注意的这里的视频编码器　xvid

clear;
close all;

%% 视频文件读取，并将帧保存到当前文件夹　jpg 文件
% v = VideoReader('./sample_image/videos/minh_640_480.ogv');
% nFrames = v.NumberOfFrames;
% vidHeight = v.Height;
% vidWidth = v.Width;
%
% for k = 1 : nFrames
%     im = read(v, k);%读取第k帧，存入im中
%     imshow(im);
%     imwrite(im, ['frame_',num2str(k),'.jpg'], 'jpg');%把im存储成图片，并且存储的文件名根据序号改变
% end
%%

addpath('src/')
addpath('../dataset/FLIC/');

%% 加载lsp_dataset annotation 文件，并显示标注情况
load('../dataset/LEEDS/lsp_dataset/joints.mat', 'joints');
imgdir = '../dataset/LEEDS/lsp_dataset/images';

%% display a random image
%i = randi(length(joints));
i =1;
stickwidth = 4;

img = imread([imgdir,'/im',num2str(i,'%04i'),'.jpg']);
cla, imagesc(img), axis image, hold on;

limbs = [1 2;2 3;3 4;4 5;5 6;7 8;8 9;9 10;10 11;11 12;13 14;9 4;10 3];
joint = transpose(joints(1:2,:,i));% 这里将单个图像标注信息 2*14　维 转置　14*2　维

colors = hsv(length(limbs));


% 测试用
% for q = 1:size(joint,2)
%     x = joint(q,1);
%     y = joint(q,2);
%     plot(x,y,'-.r*');
%
% end

for p = 1:size(limbs,1)
    X = joint(limbs(p,:),1);
    Y = joint(limbs(p,:),2);
    hl = line(X, Y,'color', colors(p,: ));
    set(hl, 'LineWidth',stickwidth);
end

bodyHeight = max(joint(:,2)) - min(joint(:,2));
plot(joint(:,1), joint(:,2), 'k.', 'MarkerSize',bodyHeight/32);
