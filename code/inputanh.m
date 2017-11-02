clc,clear,warning off
rgb = imread('bien so image test\dang-ky-xe-bien-HN.jpg');
tic
gray=rgb2gray(rgb); % chuyen anh mau thanh anh xam
gray=imadjust(gray);% can bang cuong do sang
[row,col]=size(gray);% Lay kich thuoc anh
cp=[round(row/2),round(col/2)];% toa do diem tam
de=round(0.01*row);% khoang cong tru
cm1=cp(1)-de:cp(1)+de;% khoang thoa man theo hang
cm2=cp(2)-de:cp(2)+de;% khoang thoa man theo cot
doituongnho=round(0.02*row*col);% so diem anh doi tuong nho
biensonho=[round(0.09*row),round(0.09*19*row/14)];% bien so duoc cho la nho
thresh=0; % khoi tao nguong
check=0; % khoi tao kiem tra
num = 1;
grayC = {};
KKK = {};
for thresh = 0:0.1:1
%     if thresh==1
% %         msgbox('Khong phat hien duoc bien so');
%         break;
%     else
    bw=im2bw(gray,thresh);
    bw=bwareaopen(bw,doituongnho);
    bw=imfill(bw,'holes');
    bw=imclearborder(bw,4);
    bw1 = bw;
    bw=imerode(bw,strel('rectangle',biensonho));
    [L,n]=bwlabel(bw);
    if n>0
        for j=1:n
            bin = bwmorph(L==j,'remove',Inf);
            [H peak] = findline(bin);
            A = 0;
            for i = 1:length(H)
                C = min([abs(90 - H(i).theta),abs(0 - H(i).theta),abs(-90 - H(i).theta),abs(180 - H(i).theta)]);
                A = A + C;
            end
            B = (A/length(H));
            K = imrotate(L==j,-round(B),'bilinear','crop');
            grayR = imrotate(gray,-round(B),'bilinear','crop');
            M = imdilate(K,strel('rectangle',biensonho));
            stat=regionprops((M),'BoundingBox','Centroid');
            try 
                mat=stat.BoundingBox;
                if mat(4)<mat(3)
                    check=1;
                    Result(num) = stat;
                    rgbcrop=imcrop(grayR,mat);
                    KKK{1,num} = rgbcrop;
                    num = num+1;
                else
                    check=0;
                end
            end
%             imshow(uint8(M).*grayR);
%             pause(0.1);
        end
    end
%     end
end
Test = [];
for i = 1: length(Result)
    Test = [Test;Result(i).Centroid];
end
Test = floor(Test);
ahihi = [];
for i = 1: length(Test)
    [x y] = find(Test == Test(i,:)); 
    x = unique(x);
    if length(x)>1
        ahihi = [ahihi x];
    end
end
x = unique(ahihi);
KKK(:,x(2:end)) = [];
M = length(KKK);
subplot(4,M,1:(4-1)*M);imshow(rgb);
for i = 1:M
    subplot(4,M,(4-1)*M+i);
    imshow(KKK{1,i});
end
toc
% end