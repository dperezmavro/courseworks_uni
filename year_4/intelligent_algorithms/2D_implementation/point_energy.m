%intensity matrix,
%l,
%x-coord/ycoord in actual image(of current sampling point), 
%x/y-coord on actual image(of previous point),
%current x,y index in intensity matrix
function [y] = point_energy(im ,l , cx , cy , px , py, cx_i, cy_i) 
    y=l*sqrt((cx-px)^2+(cy-py)^2)+(1-l)*im(cy_i,cx_i);
end