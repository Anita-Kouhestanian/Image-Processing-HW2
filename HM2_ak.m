
%% Question 1
I = imread('students.jpg');
I_LCC=mylcc(I);
figure,subplot(3,2,1),imshow(I),title('Original image');
subplot(3,2,2),imhist(I),title('original image HISTOGRAM');
subplot(3,2,3),imshow(I_LCC),title('logarithmic contrast compression');
subplot(3,2,4),imhist(I_LCC),title('logarithmic contrast compression HISTOGRAM');
I_FSCS=myfscs(I_LCC);
subplot(3,2,5),imshow(I_FSCS),title('FSCS ');
subplot(3,2,6),imhist(I_FSCS),title('FSCS  HISTOGRAM');
%because the image values is between 0 to 255 so the log compressed image
%values should be between 0 to 6 so that's why we see it mostly black and we miss
%lots of details.By applying FSCS we'll use the whole range of gray level,
%we can see very bright pixels in the image but it doesn't have the visual
%quality yet
%% Question 3
%I used a function “myThresholding”and a subfunction "myav"  to find the
%the correct threshold of each segment of the image.after getting binary
%image,I used bwlabel function in order to label the objects of the image.
%matlab count 44 objects, so I write a piece of code to see is there any
%connected coins or not and report the number of connected coins plus the
%number of coins that matlab computed as the number of coins in the image

f = imread('hw2_coins.tif');
p1=f(:,1:49);
p2=f(:,50:98);
p3=f(:,99:147);
p4=f(:,148:196);
p5=f(:,197:245);
p6=f(:,246:294);
p7=f(:,295:343);
p8=f(:,344:392);
p9=f(:,393:441);
p10=f(:,442:490);
p11=f(:,491:539);
p12=f(:,540:588);
p13=f(:,589:637);
p14=f(:,638:686);
a1=im2bw(p1,mythresholding(p1));
a2=im2bw(p2,mythresholding(p2));
a3=im2bw(p3,mythresholding(p3));
a4=im2bw(p4,mythresholding(p4));
a5=im2bw(p5,mythresholding(p5));
a6=im2bw(p6,mythresholding(p6));
a7=im2bw(p7,mythresholding(p7));
a8=im2bw(p8,mythresholding(p8));
a9=im2bw(p9,mythresholding(p9));
a10=im2bw(p10,mythresholding(p10));
a11=im2bw(p11,mythresholding(p11));
a12=im2bw(p12,mythresholding(p12));
a13=im2bw(p13,mythresholding(p13));
a14=im2bw(p14,mythresholding(p14));
f_bw = zeros(884,686);
f_bw(:,1:49)=a1;
f_bw(:,50:98)=a2;
f_bw(:,99:147)=a3;
f_bw(:,148:196)=a4;
f_bw(:,197:245)=a5;
f_bw(:,246:294)=a6;
f_bw(:,295:343)=a7;
f_bw(:,344:392)=a8;
f_bw(:,393:441)=a9;   
f_bw(:,442:490)=a10;
f_bw(:,491:539)=a11;
f_bw(:,540:588)=a12;
f_bw(:,589:637)=a13;
f_bw(:,638:686)=a14;
f_bw=imcomplement(f_bw);

[L, num] = bwlabel(f_bw);
frgb = label2rgb(L);
figure,imshow(L);
s = regionprops(L, 'Centroid');
hold on
for k = 1:numel(s)
    c = s(k).Centroid;
    text(c(1), c(2), sprintf('%d', k), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle');
end
hold off

figure,subplot(1,2,1),imshow(f),title('Original Image'),subplot(1,2,2),imshow(f_bw),title('Binarized Image');

D = regionprops(L, 'Area');
w = [D.Area];
figure,hist(w),title('Histogram Of Distribution Of Coins Size')
meanarea = uint16(mean(w));
stdarea = uint16(std(w));
K_Large=find(w>meanarea+stdarea);
[R,C]=size(K_Large);
ConnectedCoins=sum(uint8(double(w(K_Large))/double(meanarea)))-C;
fprintf("Number Of Connected Coins Is: %f \n \n",ConnectedCoins);

K_Small=find(w<meanarea-stdarea);
[R1,C1]=size(K_Small);
K_Noise=find(w<1000);
[R2,C2]=size(K_Noise);
NumberOfNoise=C2;

fprintf("Number Of Coins Is: %f \n \n",num+ConnectedCoins-NumberOfNoise);
%% Question 5:
I = imread('hw2_image.png');
    Nwhites = sum(sum(I==255));
    Percentage_Of_Whites = (Nwhites/numel(I))*100;
%Part a    
fprintf("Percentage Of White Pixels Is: %.2f%% \n \n",Percentage_Of_Whites);
[L,N]=bwlabel(I);
s = regionprops(L, 'Centroid');
for k = 1:numel(s)
    c = s(k).Centroid;
    text(c(1), c(2), sprintf('%d', k), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle');
end
   
% Number Of Holes
    I1=imcomplement(I);
    WithoutHoles=0;
    WithHoles=0;
    [L1, num1] = bwlabel(I1);
    Holes=L1;
    Holes(L1==1)=0;
    [Label,NumOfHoles]=bwlabel(Holes);
    withoutholdimage=Holes.^L1;
    fprintf("Number Of Holes Is: %f \n \n",NumOfHoles);     
%Part b
 % Number Of Objects
    [labelofobjects,numofobjects]=bwlabel(withoutholdimage);
    
    J1=logical(I);
    for i=1:numofobjects
        J=(labelofobjects==i);
        A=J&J1;
        if (A==J)
            WithoutHoles=WithoutHoles+1;
        else
            WithHoles=WithHoles+1;
        end
    end
fprintf('Number Of Objects Is: %f \n \n',numofobjects);
    
%Part d
fprintf('Number Of Objects With Holes Is: %f \n \n',WithHoles);
%just for showing in image
subplot(1,3,1),imshow(I),title('Original Image'),subplot(1,3,2),imshow(withoutholdimage),title('WithOut Hole');
subplot(1,3,3),imshow(Holes),title('Holes');

