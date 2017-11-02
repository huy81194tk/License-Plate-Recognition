function y= angle(rgb )
%ANGLE Summary of this function goes here
%   Detailed explanation goes here
gray=rgb2gray(rgb);
BW=edge(gray,'canny');
BW=imclose(BW,strel('line',10,90));
[H,theta,rho] = hough(BW);
P = houghpeaks(H,1,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
% figure, imshow(rgb), hold on
max_len = 0;
p=0;
for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      p=k;
   end
end
A=lines(p).point1;
B=lines(p).point2;
goc=atan2(B(2)-A(2),B(1)-A(1));
goc=rad2deg(goc);
if goc <80
y=imrotate(rgb,goc,'crop');
end

end

