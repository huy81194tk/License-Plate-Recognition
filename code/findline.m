function [F peaks] = findline(bin)
[H theta rho] = hough(bin);
peaks = houghpeaks(H,10);
x=theta(peaks(:,2));y=rho(peaks(:,1));
F=houghlines(bin,theta,rho,peaks,'MinLength',10);