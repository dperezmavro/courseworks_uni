info = [(1:70)' , (1:100:7000)'];
num_features_performance = zeros(size(info,1), 2);
train_data = [arcene_train_data ; arcene_valid_data];
train_data = normalize(train_data);
labels = [arcene_train_labels ; arcene_valid_labels] ;

for no_features=1:size(info,1)
    %train svm
    model = svmtrain(labels, train_data(:,sort_indexes(1,1:info(no_features,2))), '-q -v 10 -g 3 -c 5'); %select the highest ranking features
    num_features_performance(no_features, :) = [info(no_features,2), model];
end

figure;
plot(num_features_performance(:,1), 1-(num_features_performance(:,2)./100))
title('ARCENE : estimation of best number of features (gaussian, soft margin, g=3, c=5)');
xlabel('Number of features used');
ylabel('10-fold cross-validation error');
axis([0,max(info(:,2)+10),min(0.95-(num_features_performance(:,2)./100)), max(1-(num_features_performance(:,2)./100))]);