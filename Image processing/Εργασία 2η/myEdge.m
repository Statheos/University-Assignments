function[x] = myEdge(x,filter) 

if strcmp(filter,'roberts') == 1 %creating table X1.
x1 = [1 0 0; 0 -1 0; 0 0 0];
%creatign filter by using X1 table

xx1 = filter2(x1,x); %creating table X2.
x2 = [0 1 0; -1 0 0; 0 0 0];
%creatign filter by using X2 table

xx2 = filter2(x2,x);
%combination of filters and elevation in square.
rob = sqrt(xx1.^2 + xx2.^2);
[x]=rob/255;
end
if strcmp(filter,'sobel') == 1 %creating table X1.
x1 = [1 0 0; 0 -1 0; 0 0 0];
%creatign filter by using X1 table

xx1 = filter2(x1,x);  %creating table X2.
x2 = x1';
%creatign filter by using X2 table

xx2 = filter2(x2,x);
%combination of filters and elevation in square.
sob = sqrt(xx1.^2 + xx2.^2);
[x]=sob/255;
end