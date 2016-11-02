gisette_train_data = importdata('../data/GISETTE/gisette_train.data') ;
gisette_train_normalized = normalize(gisette_train_data);
gisette_train_labels = importdata('../data/GISETTE/gisette_train.labels');

gisette_valid_data = importdata('../data/GISETTE/gisette_valid.data');
gisette_valid_normalized = normalize(gisette_valid_data);
gisette_valid_labels = importdata('../data/GISETTE/gisette_valid.labels');

gisette_test_data = importdata('../data/GISETTE/gisette_test.data');
gisette_test_normalized = normalize(gisette_test_data);


gisette_all_data = [gisette_train_data ; gisette_valid_data];
gisette_all_normalized = normalize(gisette_all_data);
gisette_all_labels = [gisette_train_labels ; gisette_valid_labels ];
% separate training set into positive and negative classes for relevance
% score
gisette_train_positive = gisette_train_normalized(gisette_train_labels > 0 , :);
gisette_train_negative = gisette_train_normalized(gisette_train_labels < 0 ,:);