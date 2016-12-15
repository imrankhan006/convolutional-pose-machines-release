%ffmpeg -i minh.mp4 -acodec copy -vcodec copy minh.avi

clear;
close all;

v = VideoReader('./sample_image/videos/minh_640_480.ogv');
nFrames = v.NumberOfFrames;
vidHeight = v.Height;
vidWidth = v.Width;

for k = 1 : nFrames
    im = read(v, k);%读取第k帧，存入im中
    imshow(im);
    imwrite(im, ['original_frame',num2str(k),'.jpg'], 'jpg');%把im存储成图片，并且存储的文件名根据序号改变
end
