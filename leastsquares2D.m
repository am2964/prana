function F = leastsquares2D(x,mapint_i,locxy_i)
%This function is called by lsqnonlin if the least squares or continuous
%least squares method has been chosen. x contains initial guesses[I0, betas, x_c,
%y_c]. mapint_i is a matrix containing pixel intensity values, and locxy_i
%is a 1x2 vector containing the row/column coordinates of the top left
%pixel in mapint_i
%
%F is the variable being minimized - the difference between the gaussian
%curve and the actual intensity values.
%
%Adapted from M. Brady's 'leastsquaresgaussfit' and 'mapintensity'
%B.Drew - 7.18.2008

I0=x(1);
betas=x(2);
x_centroid=x(3);
y_centroid=x(4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Just like in the continuous four-point method, lsqnonlin tries negative
%values for x(2), which will return errors unless the abs() function is
%used in front of all the x(2)'s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num1=(I0*pi)/4;
num2=sqrt(abs(betas));

gauss_int = zeros(size(mapint_i));
xp = zeros(size(mapint_i));
yp = zeros(size(mapint_i));
for ii = 1:length(mapint_i)
    xp(ii) = locxy_i(ii,2);
    yp(ii) = locxy_i(ii,1);
end

% map an intensity profile of a gaussian function:
for rr = 1:size(xp,1)
    gauss_int(rr)=I0*exp(-abs(betas)*(((xp(rr))-x_centroid)^2 + ...
        ((yp(rr))-y_centroid)^2));
end

% compare the Gaussian curve to the actual pixel intensities
F=mapint_i-gauss_int;

end