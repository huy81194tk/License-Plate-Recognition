function y = inputanh(rgb)
%INPUTANH Summary of this function goes here
%   Detailed explanation goes here
gray=rgb2gray(rgb); % chuyen anh mau thanh anh xam
gray=imadjust(gray);% can bang cuong do sang
[row,col]=size(gray);% Lay kich thuoc anh
cp=[round(row/2),round(col/2)];% toa do diem tam
de=round(0.01*row);% khoang cong tru
cm1=cp(1)-de:cp(1)+de;% khoang thoa man theo hang
cm2=cp(2)-de:cp(2)+de;% khoang thoa man theo cot
doituongnho=round(0.02*row*col);% so diem anh doi tuong nho
biensonho=[round(0.08*row),round(0.08*19*row/14)];% bien so duoc cho la nho
thresh=0; % khoi tao nguong
check=0; % khoi tao kiem tra
while check==0
    thresh=thresh+0.01;
    if thresh==1
        msgbox('Khong phat hien duoc bien so');
        break;
    else
        bw=im2bw(gray,thresh);
    bw=bwareaopen(bw,doituongnho);
    bw=imfill(bw,'holes');
    bw=imclearborder(bw,4);
    bw=imopen(bw,strel('rectangle',biensonho));
    [L,n]=bwlabel(bw);
%     close all;imshow(bw);
    if n>0
        for i=1:n
            [row1,col1]=find(bw==i);
            a=sum(ismember(cm1,row1));
            b=sum(ismember(cm2,col1));
            stat=regionprops((L==i),'BoundingBox');%xac dinh hinh chu nhat bao quanh
            try 
                mat=stat.BoundingBox;
                if a>0&&b>0&&mat(4)<mat(3)
                    check=1;
%                     bw=(L==i);
                    break;
                else
                    check=0;
                end
            catch e
                msgbox(e.message);
            end
        end
    end
    end
end
%img la anh nhi phan cua bang so 
if thresh<1
    rgbcrop=imcrop(rgb,mat);
    y=rgbcrop;
else
    y=rgb;
end
end