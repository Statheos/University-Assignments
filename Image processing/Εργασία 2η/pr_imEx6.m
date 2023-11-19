im=imread('circles_and_lines.jpg');
%di = strel('disk',6);   % with bigger number (>=7) the image becomes black
%open = imopen(im,di); %disk-shaped structuring element with a radius of 5 pixels
%this structure doesn't give the best result
line = strel('line',20,90); %20-90 gives the best result 
open = imopen(im,line);
%imshow(open)
imwrite(open,'lines.png')
sp = strel('sphere',6); % with bigger number (>=7) the image becomes black
%six gives almost the same circles we have in the initial image
open = imopen(im,sp);
imwrite(open,'circles.png')
%imshow(open)