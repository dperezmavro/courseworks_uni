function c_graph(data_name, train_set, train_labels, num_params_to_use, c_range, correlation_indexes)
    c_result = zeros(size(c_range,2),2);
    for j=1:size(c_range,2)
        params = ['-q -v 20 -c ', num2str(10^(c_range(j))),' -t 0'];
        model = svmtrain(train_labels, train_set(:,correlation_indexes(1,1:num_params_to_use)),params);
        c_result(j,:) = [c_range(j) model];
    end

    figure;
    plot(c_result(:,1), 1 - (c_result(:,2)./100))
    xlabel('x, C = 10^x');
    ylabel('cv-error');
    title([data_name, ': 20-fold cross-validation for different C'])
    axis([0,max(c_result(:,1)) , 0 , 1.05 - min(c_result(:,2)./100)])
end