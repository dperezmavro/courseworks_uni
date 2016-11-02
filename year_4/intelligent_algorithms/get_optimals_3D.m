function [ opts ] = get_optimals(pos, x ,y)
%Get (x,y) coordinates of points lying in the optimal contour
cols = size(x,2);
opts = zeros(cols-1,2);
for i = 1:cols-1
   opts(i,1) = x(pos(i),i);
   opts(i,2) = y(pos(i),i);
end
end