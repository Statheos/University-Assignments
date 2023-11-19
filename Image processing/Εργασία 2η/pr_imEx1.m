im=imread('cameraman.tif'); %reading the image
C=imnoise(im,'gaussian',0,0.05); % image with noise
edge_p=edge(C,'prewitt');  %i)
subplot(2,3,1)
imshow(edge_p)
title('prewitt')
edge_r=edge(C,'roberts');  %ii)
subplot(2,3,2)
imshow(edge_r)
title('roberts')
edge_s=edge(C,'sobel');  %iii)
subplot(2,3,3)
imshow(edge_s)
title('sobel')
l=fspecial('laplacian',0); %iv)
ic_l=filter2(l,C);
subplot(2,3,4)
imshow(mat2gray(ic_l))
title('Z. crossings(Laplacian)')
fspecial('log',13,2)  %v)
subplot(2,3,5)
g1=edge(C,'log');
imshow(g1)
title('Z. crossings(Laplacian of Gaussian)')

%canny method
figure
c1=edge(C,'canny',0.2,0.2);
subplot(2,3,1)
imshow(c1)
title('T=0.2 & S=0.2')

c2=edge(C,'canny',0.2,2);
subplot(2,3,2)
imshow(c2)
title('T=0.2 & S=2')

c3=edge(C,'canny',0.3,2.5);
subplot(2,3,3)
imshow(c3)
title('T=0.3 & S=2.5')

c4=edge(C,'canny',0.5,3);
subplot(2,3,4)
imshow(c4)
title('T=0.5 & S=3')

c5=edge(C,'canny',0.1,5);
subplot(2,3,5)
imshow(c5)
title('T=0.1 & S=5')

c6=edge(C,'canny',0.9,1);
subplot(2,3,6)
imshow(c6)
title('T=0.9 & S=1')

suptitle('canny method')