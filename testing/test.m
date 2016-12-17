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

addpath('../dataset/FLIC/');
%% 加载lsp_dataset annotation 文件，并显示标注情况
load('../dataset/LEEDS/lsp_dataset/joints.mat', 'joints');
imgdir = '../dataset/LEEDS/lsp_dataset/images';
%% display a random image
i = randi(length(joints));

img = imread([imgdir,'/im',num2str(i,'%04i'),'.jpg']);
cla, imagesc(img), axis image, hold on;

%display torso detected by berkeley poselets
%plotbox(joints(:,:,i),'w--')
limbs = [1 2; 3 4; 4 5; 6 7; 7 8; 9 10; 10 11; 12 13; 13 14];

joint = transpose(joints(1:2,:,i));% 这里将标注文件中　2*14 转置　14*2

DrawStickman(sticks, img, colors, thickness, drawidx, drawfullskeleton)

colors = hsv(length(limbs));

  for p = 1:size(limbs,1)

    X = joint(limbs(p,:),1);
    Y = joint(limbs(p,:),2);

    %x = (X(1)+X(2))/2;
    %y = (Y(1)+Y(2))/2 ;
    %h = patch(x,y,colors(p,:));
    %set(h,'FaceAlpha',0.6);
    %set(h,'EdgeAlpha',0);

    %hl = line(X, Y);
    %set(hl, 'LineWidth', 0.5);

    %x = joint(1,p);
    %y = joint(2,p);
    %plot(x,y,'-.r*');
    %plot(predict(:,1), predict(:,2), 'k.', 'MarkerSize', bodyHeight/32);

  end
