function [ en , pos] = fill_energy_matrix(l,intensities, x , y)

rows = size(intensities(:,1),1);
cols = size(intensities(1,:),2);
en = zeros(rows,cols);
pos = zeros(rows,cols) ;
sum = zeros(1,rows);
ty=zeros(1,rows);
%%Initialize first column of matrix
for a1 = 1: rows
   en(a1,1) = intensities (a1,1);
end

%fill rest of matrix based on that 
for a = 2:cols 
    for b = 1:rows       
       for j = 1 : rows
         curr_value = en(j,a-1)+
           point_energy(intensities,l,x(b,a),y(b,a),x(j,a-1),y(j,a-1),a,b);
         sum(1,j) = curr_value;
         ty(1,j)=j;%positions of previous box used to calculate energy
       end       
       [minv mini] = min(sum);
       en(b,a) = minv;
       pos(b,a) = ty(mini) ;
       ty=zeros(1,rows);
       sum = zeros(1,rows);
    end
end

end

