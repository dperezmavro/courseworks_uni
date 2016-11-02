%so far optimal value for l is [0.007,0.04]
L = 0.05 ;
%any les than 15 and it is unacceptable
M = 150;

im = imread('tongue.png');
im = double (im);
immin = min(min(im)) ;
immax=max(max(im));
ctr1 = load('init1.ctr');
ctr2 = load('init2.ctr');
im = (im - immin)/(immax-immin);
im2 = 1 - im ; %this makes the image black and white

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
%make pretty graph
str = sprintf('Image of tongue with optimal contour overlayed(M:%d,L:%.4f)',M,L);
fig =figure('name',str);%,'visible','off');
imagesc(im)
colormap(gray)
axis square
hold on
%plot contours
plot(ctr1(:,1),ctr1(:,2),'r*',ctr2(:,1),ctr2(:,2),'r*','MarkerSize',5)
%plot optimal path
plot(pts(:,1),pts(:,2),'g+-','LineWidth',1,'MarkerSize',5)
%view only search space
axis([95 245 45 205])
%add title
hold off
title(str);

%uncomment to allow for printing to a file
%fname = sprintf('2d-clcap-%d-%.5f.png',M,L);
%print(fig,'-dpng',fname);