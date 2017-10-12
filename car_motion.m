clear;
close all;
car = im2double(imread('car.bmp'));     %����ԭͼ
a = im2double(imread('a.bmp'));         %a�Ƕ�ֵͼ��������ȡ����
b = imcomplement(a);                    %b��a�Ķ�ֵ����ͼ
e2 = im2double(imread('e2.bmp'));       %e2����һ����ֵͼ������ȡ����
f2 = imcomplement(e2);                  %f2��a�Ķ�ֵ����ͼ
imwrite(b,'b.bmp');
imwrite(f2,'f2.bmp');

car0 = f2.*car;
back0 = e2.*car;
imwrite(car0,'car0.bmp');
imwrite(back0,'back0.bmp');             %��ȡ�����ͱ���

car1 = b.*car;
back1 = a.*car;
imwrite(car1,'car1.bmp');
imwrite(back1,'back1.bmp');             %��һ����ֵͼ��ȡ���ͱ���

PSF1 = fspecial('motion',30,0);
car2 = imfilter(car0,PSF1,'circular');  %����ͷ����ڳ������˶����ƶ�30������
res1 = car2 + back0;
imwrite(car2,'car2.bmp');
imwrite(res1,'res1.bmp');               %��ϲ����ı����õ������˶��ĳ���ͼ

PSF2 = fspecial('motion',30,180);
back2 = imfilter(back1,PSF2,'circular');%����ͷ����ڱ��������˶����ƶ�30������
res2 = back2 + car1;
imwrite(back2,'back2.bmp');
imwrite(res2,'res2.bmp');               %��ϲ����ĳ��õ������˶��ı���ͼ