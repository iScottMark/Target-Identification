%Three frame difference

%Input arguements:
%im1,im2 and im3 are three continuous frames of the images.
%thre is the threshold of the canny method.

%Output arguements:
%B is the return of the edge of the images.

function B = threeframe(im1,im2,im3,thre,t)

%im1 = edge(im1,'canny',thre);
%im2 = edge(im2,'canny',thre);
%im3 = edge(im3,'canny',thre);


%calculate the diff
d1 = im2 - im1;     
d2 = im3 - im2;

figure(6)
imshow(d1)
figure(7)
imshow(d2)

b1 = im2bw(d1,t);
b2 = im2bw(d2,t);


%And
[row,col] = size(d1);
B = zeros(row,col);
B = b1 & b2;


