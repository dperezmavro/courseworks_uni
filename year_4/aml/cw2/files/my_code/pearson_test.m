%%%%%%%%%%%%%%%%%%%
%   LOAD START
%%%%%%%%%%%%%%%%%%%
initialize_arcene ;
initialize_gisette ;
%%%%%%%%%%%%%%%%%%%
%   END LOADING
%%%%%%%%%%%%%%%%%%%

arcene_pearson = corr(arcene_train_normalized, arcene_train_labels);
arcene_pearson(isnan(arcene_pearson)) = 0 ; %make nans be uncorrelated features
arcene_pearson = abs(arcene_pearson);
[arcene_pearson_sorted, arcene_pearson_index] = sort(arcene_pearson);
arcene_optimal_features = 5201;
params = ['-q -g ',num2str(2^1.5),' -c ',num2str(2^3.5)];
train_and_test('arcene', arcene_train_normalized,arcene_train_labels, arcene_valid_normalized, arcene_valid_labels, arcene_test_normalized,5201, arcene_pearson_index', params );

gisette_pearson = corr(gisette_train_normalized, gisette_train_labels);
gisette_pearson(isnan(gisette_pearson)) = 0 ; %make nans be uncorrelated features
[gisette_pearson_sorted, gisette_pearson_index] = sort(gisette_pearson);
gisette_optimal_features = 801 ;
params = '-q -g 1 -c 32' ;
train_and_test('gisette', gisette_train_normalized,gisette_train_labels, gisette_valid_normalized, gisette_valid_labels, gisette_test_normalized,gisette_optimal_features, gisette_pearson_index', params );
