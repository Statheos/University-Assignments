I1=imread('peppers.png'); %reading the images
I2=imread('lenna.png');
IG1=rgb2gray(I1);   %grayscaling the images
IG2=rgb2gray(I2);
ig2=imresize(IG2,[384 384]);  %adjusting the dimensions of lenna.png image
conc1=cat(2,ig2,IG1);  %merging the two images
figure, imshow(conc1)
ig22=imresize(IG2,[512 512]);  %adjusting the dimensions of lenna.png image
conc2=cat(1,ig22,IG1);  %merging the two images
figure, imshow(conc2)

