function [ en,pos ] = get_matrices(l,intensities, x , y)
rows = size(intensities(:,1),1);
cols = size(intensities(1,:),2);
en = zeros(rows,cols, rows);
pos = zeros(1,cols-1) ;
posm = zeros(rows,cols, rows);
%initialize matrix
for ly = 1:rows
    en(ly,1,:) = 0;
    %en(ly,1,:) = intensities(ly,1); %uncomment to initialize matrix
    %dfferently
end
    for cx = 2:cols-1
       for cy = 1:rows
          curr_int = intensities(cy,cx);
          curx = 2*x(cy,cx) ;
          cury = 2*y(cy,cx) ;
          for ny = 1:rows
              sums = zeros(1,rows);
              tx1  = x(ny,cx+1) - curx;
              ty1  = y(ny,cx+1) - cury;              
              nextx = x(ny,cx+1);
              nexty = y(ny,cx+1);              
              for py = 1:rows
                  tx = x(py,cx-1) + tx1;
                  ty = y(py,cx-1) + ty1;                  
                  enumerator = tx^2 + ty^2;                  
                  dx = nextx - x(py,cx-1);
                  dy = nexty - y(py,cx-1);
                  denominator = dx^2 + dy^2;                  
                  proximity = l*(enumerator/denominator) + (1-l)*curr_int ;                  
                  curr_en = en(py,cx-1,cy) + proximity;
                  sums(1,py)= curr_en ;
              end
              [minv, mini ] = min(sums);
              en(cy,cx,ny) = minv;
              posm(cy,cx, ny) = mini; 
          end
       end
    end
    
    %fill last column
    for cy =1:rows
        sums= zeros(1,rows);
       for py =1:rows
         expre=l*sqrt((x(cy,cols)-x(py,cols))^2+(y(cy,cols)-y(py,cols))^2)
         +(1-l)*intensities(cy,cols);
         sums(1,py)=expre;
       end 
       en(cy,cols,:) = min(sums);
    end
    
	%start backtracking : locate the minimum in the penultimate column
    [~ , miny] = min(en(:,cols-1));
    pos(1,1) = miny;
    
	%backtrack through the rest of the columns
    for X = fliplr(2:cols-1)
       newz= miny;
       newy = posm(miny,X,newz);       
       pos(1,X) = newy;
       miny = newz;
    end
end%end function