RGB = imread('rose.jpg'); %the rose.jpg image is being read
I = rgb2gray(RGB);
 solarize(I, 64)  %testing the function
 solarize(I, 128)
 solarize(I, 192)
