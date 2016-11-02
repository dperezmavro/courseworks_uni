stepSize = 0.1;
c_list = 3:stepSize:4;
g_list = 1:stepSize:2;
trainLabel = arcene_train_labels ;
trainData = arcene_train_normalized(:,sort_indexes(1,1:best_features)) ;

num_c = length(c_list);
num_g = length(g_list);
cvMatrix = zeros(num_c,num_g);
bestcv = 0;
for i = 1:num_c
    c = c_list(i);
    for j = 1:num_g
        g = g_list(j);   
        param = ['-q -v 10 -c ', num2str(2^c), ' -g ' , num2str(2^g)];
        cv = svmtrain(trainLabel, trainData, param);
        cvMatrix(i,j) = cv;
        if (cv >= bestcv),
            bestcv = cv; bestc = c; bestg = g;
        end
    end
    i/num_c
end

disp(['CV scale1: best c:',num2str(bestc),' best g:',num2str(bestg),' accuracy:',num2str(bestcv),'%']);

% Plot the results
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick',1:num_g)
set(gca,'XTickLabel',sprintf('%3.1f|',g_list))
xlabel('Log_2\gamma');
set(gca,'YTick',1:num_c)
set(gca,'YTickLabel',sprintf('%3.1f|',c_list))
ylabel('Log_2C');