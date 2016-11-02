%This file was used to benchmark the coursework and plot the performance graph
m = [50 ,60,70,80,90,100,120,140,160,180,200,250,300];
L = 0.05;
im = imread('tongue.png');
im = double (im);
immin = min(min(im)) ;
immax= max(max(im));
ctr1 = load('init1.ctr');
ctr2 = load('init2.ctr');
im = (im - immin)/(immax-immin);
im2 = 1 - im ; %this makes the image black and white
times = zeros(size(m,2),2);
for a = 1:size(m,2) 
   M = m(1,a)
   times(a,1) = M ;
   tic;
    [intensities,x,y]=get_search_space(M,ctr1,ctr2,im2); 
    [en, pos] = get_matrices_3D(L,intensities, x,y);   
    times(a,2) = toc;
end
str = sprintf('Tests for 3D matrix performance(M:%d,L:%.5f)',M,L);
fig = figure('name',str,'visible','off');
plot(times(:,1),times(:,2),'r*-')
xlabel('M')
ylabel('Time (s)')
hold off
title(str);
fname = sprintf('cw_3d_benchmark.png');
print(fig,'-dpng',fname);