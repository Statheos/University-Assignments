im=imread('cameraman.tif');
cf=fftshift(fft2(im));  %rearranges a Fourier transform
%Low pass filter
[x,y]=meshgrid(-128:217,-128:127);  %we create the circle first
z=sqrt(x.^2+y.^2);
c=(z<15); %circle matrix
cfl=cf*c; %with the operator .* matlab gives error for the dimensions
subplot(2,2,1)
fftshow(cfl,'log') %function to show the spectrum
title('Low pass filter');
cfli=ifft2(cfl); %Applying ideal low pass filtering and inverting image
subplot(2,2,2)
fftshow(cfli,'abs')
title('Low pass filter after inversion');

%High pass filter
[x,y]=meshgrid(-128:127,-128:127);  %we create the circle first
z=sqrt(x.^2+y.^2);
c=(z>15);  %circle matrix
cfh=cf.*c; %multiplying the circle matrix by the DFT of the image
subplot(2,2,3)
fftshow(cfh,'log') 
cfhi=ifft2(cfh);
title('High pass filter');
subplot(2,2,4)
fftshow(cfhi,'abs')
title('High pass filter after inversion');

%Low pass butterworth filter
[x,y]=meshgrid(-128:217,-128:127); 
bl=1./(1+((x.^2+y.^2)/15).^2);
bl=lbutter(c,15,1);
cfbl=cf.*bl;
figure,subplot(2,2,1)
fftshow(cfbl,'log')
title('Low pass butterworth filter')
cfbli=ifft2(cfbl);
subplot(2,2,2)
fftshow(cfbli,'abs') %inverted to get the end result
title('Low pass butterworth filter after inversion');

%High pass butterworth filter
bh=hbutter(im,15,1);
cfbh=cf.*bh;
subplot(2,2,3)
fftshow(cfbh,'log')
title('High pass butterworth filter')
cfbhi=ifft2(cfbh);  %inverted to get the end result
subplot(2,2,4)
fftshow(cfbhi,'abs')
title('High pass butterworth filter after inversion')

%Low pass Gaussian filter
g1=mat2gray(fspecial('gaussian',256,10));
cg1=cf.*g1;
figure,subplot(2,2,1)
fftshow(cg1,'log')
title('Low pass Gaussian filter')
cgi1=ifft2(cg1);
subplot(2,2,2)
fftshow(cgi1,'abs');
title('Low pass Gaussian filter after inversion')

%High pass Gaussian filter
h1=1-g1;
ch1=cf.*h1;
subplot(2,2,3)
fftshow(ch1,'log')
ch1i=ifft2(ch1);
subplot(2,2,4)
fftshow(ch1i,'abs')