function [ model_Fscore ] = get_f_score( data, labels, model )
%GET_F_SCORE Summary of this function goes here
%   Detailed explanation goes here
L = str2double(model.predict(data));
[indexs, ones_in_L] = find(L==1);
ones_in_labels = labels(indexs);
model_precision = sum(ones_in_labels) / sum(ones_in_L);
model_recall = sum(ones_in_labels) / sum(labels);
model_Fscore = 2 * model_precision * model_recall / (model_precision + model_recall);
end

