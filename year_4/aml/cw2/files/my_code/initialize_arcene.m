arcene_train_data = importdata('../data/ARCENE/arcene_train.data') ;
arcene_train_normalized = normalize(arcene_train_data);
arcene_train_labels = importdata('../data/ARCENE/arcene_train.labels');

arcene_valid_data = importdata('../data/ARCENE/arcene_valid.data');
arcene_valid_normalized = normalize(arcene_valid_data);
arcene_valid_labels = importdata('../data/ARCENE/arcene_valid.labels');

arcene_test_data = importdata('../data/ARCENE/arcene_test.data');
arcene_test_normalized = normalize(arcene_test_data);


arcene_all_data = [arcene_train_data ; arcene_valid_data];
arcene_all_normalized = normalize(arcene_all_data);
arcene_all_labels = [arcene_train_labels ; arcene_valid_labels ];
% separate training set into positive and negative classes for relevance
% score
arcene_train_positive = arcene_train_normalized(arcene_train_labels > 0 , :);
arcene_train_negative = arcene_train_normalized(arcene_train_labels < 0 ,:);