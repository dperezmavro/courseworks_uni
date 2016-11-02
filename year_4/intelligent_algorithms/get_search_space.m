function [intensities, x,y] = get_search_space (M, ctr1 , ctr2, im) 

intensities = zeros(M, size(ctr1(:,1),1)) ;
x = zeros(M, size(ctr1(:,1),1)) ;
y = zeros(M, size(ctr1(:,1),1)) ;

for index = 1 : size(ctr1(:,1),1)
    xdif = (ctr2(index, 1) - ctr1(index,1))/(M-1) ;
    ydif = (ctr2(index, 2) - ctr1(index,2))/(M-1) ;
    for J = 1 : M
        cx = xdif*(J-1) + ctr1(index,1) ;
        cy = ydif*(J-1) + ctr1(index,2) ;
        intensities(J,index) = im(round(cy),round(cx));
        x(J,index) = cx ;
        y(J,index) = cy ;
    end
end

end