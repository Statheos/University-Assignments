im=imread('circbw.tif');
%dilation
sq=ones(3,3) %3x3 square
di = [1 0 0;1 1 1;0 0 1]; %diamond
sqh = [1 1 1;1 0 1;1 1 1]; %square with 0 in the middle
%the asked operations
dial = imdilate(im,sq); 
ero = imerode(im,sq);
open = imopen(im,sq);
close = imclose(im,sq);
%showing the results
subplot(3,4,1)
imshow(dial); title({'Dilation','Square'}); subplot(3,4,2)
imshow(ero); title({'Erosion','Square'}); subplot(3,4,3)
imshow(open); title({'Open','Square'}); subplot(3,4,4)
imshow(close); title({'Close','Square'});
%the asked operations
dial = imdilate(im,di);
ero = imerode(im,di);
open = imopen(im,di);
close = imclose(im,di); 
%showing the results
subplot(3,4,5)
imshow(dial); title({'Dilation','Diamond'}); subplot(3,4,6)
imshow(ero); title({'Erosion','Diamond'}); subplot(3,4,7)
imshow(open); title({'Open','Diamond'}); subplot(3,4,8)
imshow(close); title({'Close','Diamond'});
%the asked operations
dial = imdilate(im,sqh);
ero = imerode(im,sqh);
open = imopen(im,sqh);
close = imclose(im,sqh);
%showing the results
subplot(3,4,9)
imshow(dial);
title({'Dilation','S. 0 in the middle'}); subplot(3,4,10)
imshow(ero);
title({'Erosion','S. 0 in the middle'}); subplot(3,4,11)
imshow(open);
title({'Open','S. 0 in the middle'}); subplot(3,4,12)
imshow(close);
title({'Close','S. 0 in the middle'});