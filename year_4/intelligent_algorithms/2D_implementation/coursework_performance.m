L = 0.05 ;

im = imread('tongue.png');
im = double (im);
immin = min(min(im)) ;
immax=max(max(im));
ctr1 = load('init1.ctr');
ctr2 = load('init2.ctr');
im = (im - immin)/(immax-immin);
im2 = 1 - im ; %this is crucial !

times = zeros(1,7); %vary this one and linspace to get a results for different Ms
tic
for M = 10*linspace(1,7,7)
    [intensities,x,y]=get_search_space(M,ctr1,ctr2,im2); %any les than 15 and it is unacceptable
    [en, pos] = fill_energy_matrix(L,intensities, x,y); 
    times(M/10) = toc;
end

figure('name','Function of time vs M (t(m))')
plot(times,'--r*')
xlabel('M (tens)')
xlabel('Time (s)')