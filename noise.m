close all;
noise_mean = 0;                                                         % ������ֵΪ0
[M,N] = size(res1);
a = zeros(M,N,10);                                                      % �洢����˸�˹������ͼ�� 
b = zeros(size(a));                                                     % �洢���˲����ͼ��
c = zeros(size(a));                                                     % �洢ά���˲����ͼ��

temp = 0;
for noise_var = 0.0005:0.0005:0.0025
    blurred_noisy1 = imnoise(res1, 'gaussian', noise_mean, noise_var);
    temp = temp + 1;                                                    % ��¼1~5����ţ�Ϊ�����˶�ͼ
    NSPR = noise_var / var(res1(:));                                    % ���Ź��ʱ�
    a(:,:,temp) = blurred_noisy1;                                       % ����������ͼ
    b(:,:,temp) = deconvwnr(blurred_noisy1,PSF1);                       % ���˲�
    c(:,:,temp) = deconvwnr(blurred_noisy1,PSF1,NSPR);                  % ά���˲�
end

for noise_var = 0.0005:0.0005:0.0025
    blurred_noisy2 = imnoise(res2, 'gaussian', noise_mean, noise_var);
    temp = temp + 1;                                                    %���6~10��Ϊ�����˶�ͼ
    NSPR = noise_var / var(res2(:));                                    %����������ͬ��һ��
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
    subplot(2,2,3),imshow(b(:,:,i)),title('���˲�');
    subplot(2,2,4),imshow(c(:,:,i)),title('ά���˲�');
end

