function MSE = fiterror(z,a,b,alpha,col,row)
% This function is used to calculate the error of the ellipse fitted.
% Input:
%       z - the centre of the ellipse(a 2-by-1 matrix)
%       a - the major axis(scalar)
%       b - the minor axis(scalar)
%   alpha - Q(ALPHA) is the rotation matrix(scalar in rad)
%           Q(ALPHA) = [cos(ALPHA), -sin(ALPHA); 
%                       sin(ALPHA), cos(ALPHA)]
%     col - the X-axis of original data(a N-by-1 matrix)
%     row - the Y-axis of original data(a)N-by-1 matrix)  

% Output:
%     MSE - mean-square error of the ellipse fitted

%% Get the ellipse fitted
npts = 10000;   %the number of the iteration
t = linspace(0, 2*pi, npts);
% Rotation matrix
Q = [cos(alpha), -sin(alpha); sin(alpha) cos(alpha)];
% Ellipse points
X = Q * [a * cos(t); b * sin(t)] + repmat(z, 1, npts);


%% Find the min distance
%The distance from a point(x0,y0) to the ellipse is d. 
%d = sqrt((x0 - a*cost)^2 + (y0 - b*sint)^2)
N = length(col);
d = zeros(N,1);
for i = 1:N
    d2 = min((repmat(col(i),1,npts) - X(1,:)).^2 + (repmat(row(i),1,npts) - X(2,:)).^2);
    d(i) = d2;
end


%% Calculate the MSE
MSE = sum(d) / N;

