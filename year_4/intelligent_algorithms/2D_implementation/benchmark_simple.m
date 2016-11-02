m = [50 ,60,70,80,90,100,120,140,160,180,200,250,300];
L = 0.05;

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


times = zeros(size(m,2),2);
for a = 1:size(m,2) 
   M = m(1,a)
   times(a,1) = M ;
   tic;
   [intensities,x,y]=get_search_space(M,ctr1,ctr2,im2); 
   [en, pos] = fill_energy_matrix(L,intensities, x,y); 
   times(a,2) = toc;
  
    %path optimal path (working backwards with position/energy matrix)
    path = get_optimal_path(en,pos);
    %pts : list of coordinates optimal points
    pts = get_optimal_points(path,x,y);
    %make pretty graph
    str = sprintf('Image of tongue with optimal contour overlayed(M:%d,L:%.4f)',M,L);
    fig1 = figure('name',str,'visible','off')
    imagesc(im)
    colormap(gray)
    axis square
    hold on
    %plot contours
    plot(ctr1(:,1),ctr1(:,2),'r*',ctr2(:,1),ctr2(:,2),'r*','MarkerSize',5)
    %plot optimal path
    plot(pts(:,1),pts(:,2),'g+-','LineWidth',1,'MarkerSize',5)
    %view only search space
    %axis([95 245 45 205])
    %add title
    hold off
    title(str);
    
      
    fname = sprintf('2D-M-%d-L-%.5f.png',M,L);
    print(fig1,'-dpng',fname);
   
   
end
    str2 = sprintf('Tests for 2D matrix performance');
    fig = figure('name',str2,'visible','off');
    plot(times(:,1),times(:,2),'r*-')
    xlabel('M')
    ylabel('Time (s)')
    hold off
    title(str2);
    
    fname = sprintf('cw_2d_benchmark.png');
    print(fig,'-dpng',fname);