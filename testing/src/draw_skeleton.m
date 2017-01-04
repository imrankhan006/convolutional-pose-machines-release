function draw_skeleton(joint,img,stickwidth)
% Overlays segments in 'sticks' on image 'img'
%
% Input:
%  - joint: matrix [2, nparts]. sticks(:,i) --> (x1,y1)'
%  - img: image to show. Can be [].
%  - colors - vector 3x1 then use the specified color for all sticks
%              or 3xN then color per body part
%  - stickwidth - stickwidth of sticks (default 4)
%
% Output:
%  -
% Useage:
%  -
%   load('../dataset/LEEDS/lsp_dataset/joints.mat', 'joints');
%   imgdir = '../dataset/LEEDS/lsp_dataset/images';
%   i = randi(length(joints));
%   img = imread([imgdir,'/im',num2str(i,'%04i'),'.jpg']);
%
% 張正軒 (bond@mindcont.com)
% 更多访问  http://blog.mindcont.com


if nargin < 4 || isempty(stickwidth)
  stickwidth = 4;
end

cla, imagesc(img), axis image, hold on;

limbs = [1 2;3 4;4 5;6 7;7 8;9 10;10 11;12 13;13 14;3 6;9 12;3 12;6 9];% MPII annotation which is cpm used
%limbs = [1 2;2 3;3 4;4 5;5 6;7 8;8 9;9 10;10 11;11 12;13 14;9 4;10 3];% person-center annotation

%joint = transpose(joints(1:2,:,i));% 原始标注信息　3*14*2000 这里将单个图像标注信息 3*14　维 转置　14*2　维
%joint = transpose(joint);
colors = hsv(length(limbs));

for p = 1:size(limbs,1)
    X = joint(limbs(p,:),1);
    Y = joint(limbs(p,:),2);
    hl = line(X, Y,'color', colors(p,: ));
    set(hl, 'LineWidth',stickwidth);
end

bodyHeight = max(joint(:,2)) - min(joint(:,2));
axis off;
plot(joint(:,1), joint(:,2), 'k.', 'MarkerSize',bodyHeight/32);