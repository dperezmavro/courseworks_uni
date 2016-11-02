M = 100 ;
L = 0.05 ;
im = imread('tongue.png');
im = double (im);
immin = min(min(im)) ;
immax= max(max(im));
ctr1 = load('init1.ctr');
ctr2 = load('init2.ctr');
im = (im - immin)/(immax-immin);
im2 = 1 - im ; %this makes the image black and white and allows energy 
%minimizations rather than maximization

%intensities : matrix of intensities x,y : matrices of points corresponding
%the above intensities.
[intensities,x,y]=get_search_space(M,ctr1,ctr2,im2); 
%en : energy matrix pos :position matrix
[en, pos] = get_matrices_3D(L,intensities, x,y);
%optimal xs and ys
pts = get_optimals_3D(pos,x,y);
str = sprintf('Curve with optimal contour overlayed(M:%d,L:%.5f)',M,L);
%uncomment for printing to a file
fig = figure('name',str);%,'visible','off');
imagesc(im)
colormap(gray)
axis square
hold on
%plot contours
plot(ctr1(:,1),ctr1(:,2),'r*',ctr2(:,1),ctr2(:,2),'r*','MarkerSize',5)
%plot optimal path
plot(pts(:,1),pts(:,2),'g+-','LineWidth',1,'MarkerSize',5)
%view only% search space
axis([95 245 45 205])
hold off
title(str);
%uncomment to allow for printing to a file
%fname =sprintf('clcap-%d-%.5f.png',M,L);
%print(fig,'-dpng',fname);