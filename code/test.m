
bw=imread('A.bmp');
stat=regionprops(bw,'Image','Area');
n=length(stat);
a=zeros(1,n);
for i=1:n
    a(i)=stat(i).Area;
end
k= a==max(a);
y=stat(k).Image
