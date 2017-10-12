clear;
close all;
car = im2double(imread('car.bmp'));     %读入原图
a = im2double(imread('a.bmp'));         %a是二值图，用来提取背景
b = imcomplement(a);                    %b是a的二值反向图
e2 = im2double(imread('e2.bmp'));       %e2是另一个二值图用来提取背景
f2 = imcomplement(e2);                  %f2是a的二值反向图
imwrite(b,'b.bmp');
imwrite(f2,'f2.bmp');

car0 = f2.*car;
back0 = e2.*car;
imwrite(car0,'car0.bmp');
imwrite(back0,'back0.bmp');             %提取出车和背景

car1 = b.*car;
back1 = a.*car;
imwrite(car1,'car1.bmp');
imwrite(back1,'back1.bmp');             %另一个二值图提取车和背景

PSF1 = fspecial('motion',30,0);
car2 = imfilter(car0,PSF1,'circular');  %摄像头相对于车向右运动，移动30个像素
res1 = car2 + back0;
imwrite(car2,'car2.bmp');
imwrite(res1,'res1.bmp');               %结合不动的背景得到向左运动的车的图

PSF2 = fspecial('motion',30,180);
back2 = imfilter(back1,PSF2,'circular');%摄像头相对于背景向左运动，移动30个像素
res2 = back2 + car1;
imwrite(back2,'back2.bmp');
imwrite(res2,'res2.bmp');               %结合不动的车得到向右运动的背景图