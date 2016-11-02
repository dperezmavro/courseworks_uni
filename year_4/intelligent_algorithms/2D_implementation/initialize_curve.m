%so far optimal value for l is [0.007,0.04]
L = 0.005 ;
%any les than 15 and it is unacceptable
M = 150;

im = imread('curve.png');
im = double (im);
immin = min(min(min(im))) ;
immax=max(max(max(im)));
ctr1 = load('curve1');
ctr2 = load('curve2');
im = (im - immin)/(immax-immin);
im2 = im ;

%intensities : matrix of intensities
%x,y : matrices of points corresponding the above intensities.
[intensities,x,y]=get_search_space(M,ctr1,ctr2,im2); 

%en : energy matrix
%pos :position matrix
[en, pos] = fill_energy_matrix(L,intensities, x,y); 
    
%path optimal path (working backwards with position/energy matrix)
path = get_optimal_path(en,pos);
%pts : list of coordinates optimal points
pts = get_optimal_points(path,x,y);


str = sprintf('Image of tongue with optimal contour overlayed(M:%d,L:%.5f)',M,L);
fig = figure('name',str, 'visible','off');
imagesc(im)
colormap(gray)
axis square

hold on
%plot contours
plot(ctr1(:,1),ctr1(:,2),'r*',ctr2(:,1),ctr2(:,2),'r*','MarkerSize',5)

%plot optimal path
plot(pts(:,1),pts(:,2),'g+-','LineWidth',1,'MarkerSize',5)

hold off
title(str);

fname = sprintf('2d-curve-%d-%.5f.png',M,L);
   print(fig,'-dpng',fname);