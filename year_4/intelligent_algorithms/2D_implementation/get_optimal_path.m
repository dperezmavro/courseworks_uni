function [ path ] = get_optimal_path( em , pm)

cols = size(em(1,:),2);
[~, mi] = min(em(:,cols));

path=zeros(1,cols);
path(1,cols)= mi ;
for J = fliplr(2:cols)
    mi = pm(mi,J);
    path(1,J-1)= mi;
end
end