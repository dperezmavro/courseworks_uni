function train_and_test(name_set, train_data_normalized, train_labels,valid_data_normalized, valid_labels,test_data_normalized, num_features,sorted_indexes,svm_params)
    data_all = [train_data_normalized ; valid_data_normalized] ;
    labels_all = [train_labels ; valid_labels ];
    
    svm_model = svmtrain(labels_all, data_all(:,sorted_indexes(1,1:num_features)), svm_params);

    [predict_label_train, accuracy_train, prob_values_train] = svmpredict(train_labels,train_data_normalized(:,sorted_indexes(1,1:num_features)),svm_model );
    [predict_label_valid, accuracy_valid, prob_values_valid] = svmpredict(valid_labels,valid_data_normalized(:,sorted_indexes(1,1:num_features)),svm_model );
    [predict_label_test, accuracy_test, prob_values_test] = svmpredict(zeros(size(test_data_normalized,1),1),test_data_normalized(:,sorted_indexes(1,1:num_features)),svm_model );

    if ~isequal(exist('results','file'),7) %
        mkdir('results');
    end
    if ~isequal(exist('zipped', 'dir'),7) % 7 = directory.
        mkdir('zipped');
    end
    
    dlmwrite(['results/',name_set,'_train.resu'],predict_label_train);
    dlmwrite(['results/',name_set,'_valid.resu'],predict_label_valid);
    dlmwrite(['results/',name_set,'_test.resu'],predict_label_test);
    dlmwrite(['results/',name_set,'.feat'],sorted_indexes(1,1:num_features)');
    zip(['zipped/',name_set,'.zip'],{'*.resu','*.feat'},[pwd,'/results']);
end

