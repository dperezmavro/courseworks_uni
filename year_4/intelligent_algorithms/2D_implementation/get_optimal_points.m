function [ points] = get_optimal_points( path , x ,y )

    points=zeros(size(x,2),2);

    for i=1:length(path)
        points(i,1) = x(path(i),i) ;
        points(i,2) = y(path(i),i) ;
    end
end

