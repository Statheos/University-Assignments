f=imread('flowers.tif');
fg=rgb2gray(f);
fg=im2uint8(fg(30:285,60:315));
fg_a=imnoise(fg,'gaussian'); %a) image with noise
subplot(2,2,1)
imshow(fg_a)
title('a')

fg_b=imnoise(fg,'gaussian',0,0.02); %b) image with noise
subplot(2,2,2)
imshow(fg_b)
title('b')

fg_c=imnoise(fg,'gaussian',0,0.05); %c) image with noise
subplot(2,2,3)
imshow(fg_c)
title('c')

fg_d=imnoise(fg,'gaussian',0,0.1); %d) image with noise
subplot(2,2,4)
imshow(fg_d) 
title('d')
suptitle('Images with gaussian noise')
figure

%now the noise is removed by using two different filters
%average filter:
b=fspecial('average');  %the result is not the expected and i get a white image
fg1=filter2(b,fg_a);
subplot(2,2,1)
imshow(fg1/255)
title('a')

b=fspecial('average'); 
fg2=filter2(b,fg_b);
subplot(2,2,2)
imshow(fg2/255)
title('b')

c=fspecial('average'); 
fg3=filter2(c,fg_c);
subplot(2,2,3)
imshow(fg3/255)
title('c')

d=fspecial('average'); 
fg4=filter2(d,fg_d);
subplot(2,2,4)
imshow(fg4/255)
title('d')
suptitle('Cleaned images with average filter')
figure

%Wiener filter
f1=wiener2(fg_a);
subplot(2,2,1)
imshow(f1)
title('a')

f2=wiener2(fg_b);
subplot(2,2,2)
imshow(f2)
title('b')

f3=wiener2(fg_c);
subplot(2,2,3)
imshow(f3)
title('c')

f4=wiener2(fg_d);
subplot(2,2,4)
imshow(f4)
title('d')
suptitle('Cleaned images with wiener filter')