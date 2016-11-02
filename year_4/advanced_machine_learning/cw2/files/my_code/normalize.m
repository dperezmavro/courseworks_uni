function normalized = normalize(data_matrix)
    m = size(data_matrix,1);
    normalized =  data_matrix ./ sqrt((1/m) * sum(sum(data_matrix .^ 2 ,2)) );
end