select_num_features ;
best_features = 5201 ;
params = ['-q -g ',num2str(2^1.5),' -c ',num2str(2^3.5)];
train_and_test('arcene', arcene_train_normalized,arcene_train_labels, arcene_valid_normalized, arcene_valid_labels, arcene_test_normalized,5201, sort_indexes, params );