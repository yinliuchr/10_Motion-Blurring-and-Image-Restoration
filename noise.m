close all;
noise_mean = 0;                                                         % 噪声均值为0
[M,N] = size(res1);
a = zeros(M,N,10);                                                      % 存储添加了高斯噪声的图像 
b = zeros(size(a));                                                     % 存储逆滤波后的图像
c = zeros(size(a));                                                     % 存储维纳滤波后的图像

temp = 0;
for noise_var = 0.0005:0.0005:0.0025
    blurred_noisy1 = imnoise(res1, 'gaussian', noise_mean, noise_var);
    temp = temp + 1;                                                    % 记录1~5的序号，为汽车运动图
    NSPR = noise_var / var(res1(:));                                    % 噪信功率比
    a(:,:,temp) = blurred_noisy1;                                       % 加了噪声的图
    b(:,:,temp) = deconvwnr(blurred_noisy1,PSF1);                       % 逆滤波
    c(:,:,temp) = deconvwnr(blurred_noisy1,PSF1,NSPR);                  % 维纳滤波
end

for noise_var = 0.0005:0.0005:0.0025
    blurred_noisy2 = imnoise(res2, 'gaussian', noise_mean, noise_var);
    temp = temp + 1;                                                    %序号6~10，为背景运动图
    NSPR = noise_var / var(res2(:));                                    %下面代码解释同上一段
    a(:,:,temp) = blurred_noisy2;
    b(:,:,temp) = deconvwnr(blurred_noisy2,PSF2);
    c(:,:,temp) = deconvwnr(blurred_noisy2,PSF2,NSPR);
end

for i = 1 : 10
    figure(i)
    subplot(2,2,1),imshow(car),title('Original car');
    if i < 6
        subplot(2,2,2),imshow(a(:,:,i)),title(['blurred image with noise,', ' motion car,',' noise var = ',num2str(0.0005 * i)]);
    else
        subplot(2,2,2),imshow(a(:,:,i)),title(['blurred image with noise,', ' motion back,',' noise var = ',num2str(0.0005 * (i-5))]);
    end
    subplot(2,2,3),imshow(b(:,:,i)),title('逆滤波');
    subplot(2,2,4),imshow(c(:,:,i)),title('维纳滤波');
end

