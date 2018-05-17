function [S2P,L2W,Extent] = props(L,num,sz,img_edge)
% This function is used to get some important proporties of shapes.
% Area-to-primeter ratio , length-to-width ratio and Extent are included.
% Input:
%      L,num,sz are returned by 'label.m'.
%      img_edge is the image which is extracted the edge.

% Output:
%      S2P - Area-to-primeter ratio
%      L2W - length-to-width ratio
%   Extent - FilledArea-to-BoundingBoxArea ratio

%% Extract the proporties from the all edges

for i = 1:num
    X = zeros(size(sz));
    X(find(L==i)) = img_edge(L==i);
    stats(i) = regionprops(X,'Area','BoundingBox','Extent', ...
                              'FilledImage','FilledArea','Perimeter');

%     The above codes are equivalent to the codes as follow:
%     X2 = imfill(X,'holes');
%     figure(i)
%     imshow(X2)
%     stats(i) = regionprops(X2,'Area','Boundingbox','Extent','FilledImage','FilledArea');  

end


%% Calculate some significant proporties of the shapes

for i = 1:num
    
%     Judge this labeled edge whether is a circle or an ellipse.
%     No.1 via S/P = FilledArea/Perimeter
%     No.2 via L/W = Length/Width
%     No.3 via Extent = FilledArea/BoundingBoxArea(=pi/4(¡Àtolerance))
    
    S2P(i) = stats(i).FilledArea / stats(i).Perimeter;
    L2W(i) = stats(i).BoundingBox(3) / stats(i).BoundingBox(4);
    Extent(i) = stats(i).FilledArea / (stats(i).BoundingBox(3)*stats(i).BoundingBox(4));
  
end







