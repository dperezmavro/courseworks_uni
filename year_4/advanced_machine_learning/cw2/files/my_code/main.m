echo off
initialize_arcene ; %runs commands in file initialize_vars.m
fscores = zeros (1,size(arcene_train_data,2));

for i=1:size(fscores,2)
    fscores(1,i) = fisher_relevance(arcene_train_positive, arcene_train_negative, i);
end

[sorted, sort_indexes] = sort(fscores,2,'descend');

figure;
plot(fscores, 'k.', 'MarkerSize', 4);
axis([0,10000,0,max(fscores)])
title('Fisher scores for normalized training set ARCENE');
xlabel('Attribute');
ylabel('score');

figure;
range = 0:0.005:1;
bincnt = histc(fscores,range);
bar(range,bincnt,'histc');
axis([0,max(fscores),0,max(bincnt)]);
title('Score histogram for ARCENE');
xlabel('Score bin');
ylabel('frequency');


c_graph('arcene', arcene_train_normalized, arcene_train_labels, 5000, -2:0.5:6,sort_indexes) ;% run commands in C_graph.m file
select_num_features ;% run commands in select_num_features.m file
[v,i] = max(num_features_performance(:,2));
best_features = num_features_performance(i,1);

%%%%%%%%%%%%%%%%%%%%%%%%
%   GISETTE TRAINING
%%%%%%%%%%%%%%%%%%%%%%%%
gizette_fscores = zeros (1,size(gisette_train_data,2));

for i=1:size(gizette_fscores,2)
    gizette_fscores(1,i) = fisher_relevance(gisette_train_positive, gisette_train_negative, i);
end

[gisette_sorted, gisette_sort_indexes] = sort(gizette_fscores,2,'descend');
gisette_num_features ;
gisette_optimal_features = 801 ;
params = '-q -g 1 -c 32' ;
train_and_test('gisette', gisette_train_normalized,gisette_train_labels, gisette_valid_normalized, gisette_valid_labels, gisette_test_normalized,gisette_optimal_features, gisette_sort_indexes, params );

figure;
plot(gizette_fscores, 'k.', 'MarkerSize', 4);
axis([0,10000,0,max(gizette_fscores)])
title('Fisher scores for normalized training set GISETTE');
xlabel('Attribute');
ylabel('score');

figure;
range = 0:0.005:1;
gisette_bincnt = histc(gizette_fscores,range);
bar(range,gisette_bincnt,'histc');
axis([0,max(gizette_fscores),0,max(gisette_bincnt)]);
title('Score histogram for GISETTE');
xlabel('Score bin');
ylabel('frequency');
