function diffmaxmin (I, n)
%if (n<5) && (n>25) %checking if the value is odd and if is between 5 and 25 
    %if(diff(mod(n,2),0))
      I_min=nlfilter(I,[n,n],'min(x(:))');  %calculation of min filter for the given image
      I_max=nlfilter(I,[n,n],'max(x(:))');   %calculation of max filter for the given image
      I_diff=I_max-I_min;  %calculation of difference 
      imshow(I_diff)
      title(' NON-LINEAR MAX - MIN FILTER')
      figure
    %end
%end %with these checks the function does not give any output
end


