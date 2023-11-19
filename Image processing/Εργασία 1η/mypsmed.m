%(Excercise 4)  %this is an implimentation of Pratts pseudo-median filter
function res=mypsmed(im,d)
f=[0.125 0.125 0.125; 0.125 0 0.125; 0.125 0.125 0.125]; 
imd=im2double(im); 
imf=filter2(f,imd);
r=abs(imd-imf)-d>0;
res=im2uint8(r.*imf+(1-r).*imd);
end