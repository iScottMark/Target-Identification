%read the image

function im = imgread(N,imgsuffix)

for i=1:N
    seq = num2str(i);
    imgname = [seq,imgsuffix];
    im(:,:,i) = double(imread(imgname));
end
    
