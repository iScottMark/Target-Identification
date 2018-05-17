% The Target Identification
% This .m_script should be run at first.

%% Use the function 'label' written but not the MATLAB 'bwlabel' 
close all
clear
clc

%% Load the processing images
N = 8;      %N is the number of the processing images
imgsuffix = 'm_Ð£Õýºó.jpg';    
img = imgread(N,imgsuffix);
[row,col] = size(img(:,:,1));


%% Use the average of the all images in order to get the background
img_bk = double(zeros(row,col));

for i = 1:N
    img(:,:,i) = uint16(img(:,:,i));
    img_bk = img_bk + img(:,:,i);
end

img_bk = img_bk / N;


%% Plot the background
figure(1)
subplot(2,2,1)
imshow(img_bk,[])
title('background')


%% Plot the target
%The diff(im2-img_bk) is the wanted target. 
img_temp =  img(:,:,2) - img_bk; %only test the im2.

subplot(2,2,2)
imshow(img_temp,[])
title('target')


%% Plot the edge
%Use the Canny Method to get the edge of the im2.
%Note that the threshold 'thre' needs to be adjusted according to the
%different images.
thre = 0.53;
img_edge = edge(img_temp,'canny',thre);
subplot(2,2,3)
imshow(img_edge,[])
title('edge')


%% Call to bwlabel.
%Note that connected area is 8.
% [L,num] = bwlabel(img_edge,8);
% 
% x1 = zeros(size(img_edge));
% x1(find(L==1)) = img_edge(find(L==1));
% imwrite(x1,'x1.jpg')
% 
% L = double(L);  %convert the data type for the following function--regionprops

%Call to regionprops to extract features like areas,boundings,etc.
% img_reg = regionprops(L,  'area', 'boundingbox');  
% areas = [img_reg.Area];  
% rects = cat(1,  img_reg.BoundingBox);  


%% Call to the written function 'label.m'
n = 8;  %8-connected region
img_edge2= double(img_edge);
img_edge2(~img_edge) = NaN;
[L2,num2,sz] = label(img_edge2,n);
% L2 = double(L2);
subplot(2,2,4)
imshow(L2)
title('cluster')
pause
close
%L is equal to L2

%% Call to 'props.m' to get some important proporties of shapes
[S2P,L2W,Extent] = props(L2,num2,sz,img_edge2);


%% Judge the shape whether is a circle or an ellipse and plot them
%Firstly,according to [S2P,L2W,Extent] returned by 'props.m',
%        a circle or an ellipse can be first identified.

%Then,let the shapes which meet the above criteria fit the ellipse.

%At last,according to the MSE ,a circle or an ellipse can be detected.

%Just take Extent for a instance(S2P,L2W will be added after that.)
eps = 0.05;
sum1 = 0;
for i = 1:num2
    if length(find(L2==i)) > 25     %the number of pixels must be enough
        
        if (Extent(i) <= pi/4 + eps) && (Extent(i) >= pi/4 - eps)   

            [row1,col1] = find(L2==i);   
            X1 = [col1';row1'];
            [z1, a1, b1, alpha1] = fitellipse(X1);      %fit the ellipse
            MSE = fiterror(z1,a1,b1,alpha1,col1,row1);   %get the MSE

            if (MSE < 0.2)
                figure(i)       %Now,I can't let all ellipses be shown in one image.
                imshow(uint8(img(:,:,2)))   %test the img2
                hold on
                plotellipse(z1, a1, b1, alpha1)
                hold on
                plot(round(z1(1)),round(z1(2)),'x')    %Plot the center
                
                display('The center of the target is:')
                x = z1(1),y = z1(2)
            else
                sum1 = sum1 + 1;
            end
        else
            sum1 = sum1 + 1;
        end
    else
        sum1 = sum1 + 1;
    end
end

if sum1 == num2
    display('No target is found.')
end





