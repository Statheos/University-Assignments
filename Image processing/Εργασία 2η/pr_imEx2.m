c=imread('cameraman.tif');
t=imread('tire.tif');
c1=myEdge(c,'roberts');
subplot(2,2,1)
imshow(c1)
title('Custom roberts filter')
c2=edge(c,'roberts');
subplot(2,2,2)
imshow(c2)
title('Original roberts filter')
t1=myEdge(t,'roberts');
subplot(2,2,3)
imshow(t1)
title('Custom roberts filter')
t2=edge(t,'roberts');
subplot(2,2,4)
imshow(t2)
title('Original roberts filter'),figure

c1=myEdge(c,'sobel');
subplot(2,2,1)
imshow(c1)
title('Custom sobel filter')
c2=edge(c,'sobel');
subplot(2,2,2)
imshow(c2)
title('Original sobel filter')
t1=myEdge(t,'sobel');
subplot(2,2,3)
imshow(t1)
title('Custom sobel filter')
t2=edge(t,'sobel');
subplot(2,2,4)
imshow(t2)
title('Original roberts filter')