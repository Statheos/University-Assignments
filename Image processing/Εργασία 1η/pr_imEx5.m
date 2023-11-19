f=imread('flowers.tif'); %the first three lines are given 
fg=rgb2gray(f);
fg=im2uint8(fg(30:285,60:315));
fg_noise=imnoise(fg,'salt & pepper',0.05); %this function adds 5% noise to the image
imshow(fg_noise);
title('initial noisy image')
figure

a=fspecial('average'); %Excercise 5.1 (a)
fg_a=filter2(a,fg_noise);
subplot(1,3,1)
imshow(fg_a/255)
title('Avarage filter')

fg_b3=medfilt2(fg_noise); %Excercise 5.1 (b)
subplot(1,3,2)
imshow(fg_b3)
title('3x3 median filter')

fg_c=mypsmed(fg_noise,0.3); %Excercise 5.1 (c)
subplot(1,3,3)
imshow(fg_c)
title('pseudo-median filter')
figure

%Excercise 5.2 
fg_noise=imnoise(fg,'salt & pepper',0.1); %this function adds 10% noise to the image
imshow(fg_noise);
title('initial noisy image')
figure

a=fspecial('average'); %(a)
fg_a=filter2(a,fg_noise);
subplot(1,3,1)
imshow(fg_a/255)
title('Avarage filter')

fg_b3=medfilt2(fg_noise); %(b)
subplot(1,3,2)
imshow(fg_b3)
title('3x3 median filter')

fg_c=mypsmed(fg_noise,0.3); %(c)
subplot(1,3,3)
imshow(fg_c)
title('pseudo-median filter')
figure

fg_noise=imnoise(fg,'salt & pepper',0.2); %this function adds 20% noise to the image
imshow(fg_noise);
title('initial noisy image')
figure

a=fspecial('average'); %(a)
fg_a=filter2(a,fg_noise);
subplot(2,3,1)
imshow(fg_a/255)
title('Avarage filter')

fg_b1=medfilt2(fg_noise); %(b first application of the 3x3 filter)
subplot(2,3,2)
imshow(fg_b1)
title('3x3 median filter 1st applic')

fg_b3=medfilt2(fg_noise); %(b second application of the 3x3 filter)
subplot(2,3,3)
imshow(fg_b3)
title('3x3 median filter 2nd applic')

fg_b3=medfilt2(fg_noise,[5,5]); %(b application of the 7x7 filter)
subplot(2,3,4)
imshow(fg_b3)
title('7x7 median filter')

fg_c=mypsmed(fg_noise,0.3); %(c)
subplot(2,3,5)
imshow(fg_c)
title('pseudo-median filter')