% -*- coding: utf-8 -*-
% 本脚本测试用
% 張正軒 (bond@mindcont.com)
% 更多访问  http://blog.mindcont.com

% ffmpeg -i minh.mp4 -acodec copy -vcodec copy minh.avi 使用ffmpeg 将mp4 转码为　avi 封装，值得注意的这里的视频编码器　xvid

%clear;
close all;

addpath('src');
addpath('util');
addpath('util/ojwoodford-export_fig-5735e6d/');
param = config();
facealpha = 0.6; % for limb transparency

fprintf('Description of selected model: %s \n', param.model(param.modelID).description);


% shuttleVideo = VideoReader('shuttle.avi');
% ii = 1;
% 
% while hasFrame(shuttleVideo)
%    img = readFrame(shuttleVideo);
%    filename = [sprintf('%03d',ii) '.jpg'];
%    fullname = fullfile(workingDir,'images',filename);
%    imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
%    ii = ii+1;
% end

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

% addpath('src/')
% addpath('../dataset/FLIC/');
%
% %% 加载lsp_dataset annotation 文件，并显示标注情况
% load('../dataset/LEEDS/lsp_dataset/joints.mat', 'joints');
% imgdir = '../dataset/LEEDS/lsp_dataset/images';
%
% %% display a random image
% %i = randi(length(joints));
% i =1;
% stickwidth = 4;
%
% img = imread([imgdir,'/im',num2str(i,'%04i'),'.jpg']);
% cla, imagesc(img), axis image, hold on;
%
% limbs = [1 2;2 3;3 4;4 5;5 6;7 8;8 9;9 10;10 11;11 12;13 14;9 4;10 3];
% joint = transpose(joints(1:2,:,i));% 这里将单个图像标注信息 2*14　维 转置　14*2　维
%
% colors = hsv(length(limbs));
%
%
% % 测试用
% % for q = 1:size(joint,2)
% %     x = joint(q,1);
% %     y = joint(q,2);
% %     plot(x,y,'-.r*');
% %
% % end
%
% for p = 1:size(limbs,1)
%     X = joint(limbs(p,:),1);
%     Y = joint(limbs(p,:),2);
%     hl = line(X, Y,'color', colors(p,: ));
%     set(hl, 'LineWidth',stickwidth);
% end
%
% bodyHeight = max(joint(:,2)) - min(joint(:,2));
% plot(joint(:,1), joint(:,2), 'k.', 'MarkerSize',bodyHeight/32);

% function show_skeleton(videofilename,imscale,frameids,locs,secs)
% 
%     vidobj = VideoReader(videofilename);
%     figure
%     img = imresize(read(vidobj,frameids(1)),imscale);
%     h_img = imagesc(img); axis image; hold on
%     h_plot = plot_skeleton(zeros(2,size(locs,2)),inf(2,size(locs,2)),1,[],[]);
%     h_title = title(sprintf('Showing frame %d of %d',1,numel(frameids)));
% 
%     for i = 1:numel(frameids)
%         img = imresize(read(vidobj,frameids(i)),imscale);
%         set(h_img,'cdata',img);
%         plot_skeleton(locs(:,:,i),inf(2,size(locs,2)),1,[],h_plot);
%         set(h_title,'string',sprintf('Showing frame %d of %d',i,numel(frameids)));
%         drawnow
%         if secs < 0
%             pause
%         else
%             pause(secs)
%         end
%     end
 
model = param.model(param.modelID);
net = caffe.Net(model.deployFile, model.caffemodel, 'test');

imgdir = '/home/pi/data/test-of/taichi_xuan_0/';
savedir =  '/home/pi/data/test-of/prediction/';
imgnum = length(dir(strcat(imgdir,'*.jpg')))/3;

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
	%bodyHeight = max(prediction(:,2)) - min(prediction(:,2));
	    
	%plot_visible_skeleton(model, facealpha, prediction, bodyHeight/30);
	 draw_skeleton(RELEASE_predicted(:,:,i) ,oriImg);
	 saveas(gcf,[savedir,'pre_',num2str(i,'%05i'),'.jpg'])
 end
