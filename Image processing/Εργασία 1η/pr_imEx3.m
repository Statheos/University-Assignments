t=imread('text.png'); %reading images
c=imread('cameraman.tif');
m=uint8(double(c)+255*double(t)); %combined images
figure,imshow(m>254) %thresholding with text only (excercise3.1)
title('image after the thresholding')
figure

t1 = 1-t;  %creating the complimentary images from t and c and the output is shown (excercise 3.2) 
subplot(1,2,1)
imshow(t1)  
title('image t1')
c1 = 1-c;
subplot(1,2,2)
imshow(c1)
title('image c1')
figure

m=uint8(double(t1)+255*double(c)); %combined images
subplot(1,3,1)
imshow(m>0.999) %thresholding with text only 

m=uint8(double(t)+255*double(c1)); %combined images
subplot(1,3,2)
imshow(m>0.999) %thresholding with text only 

m=uint8(double(t1)+255*double(c1)); %combined images
subplot(1,3,3)
imshow(m>0.999) %thresholding with text only 

