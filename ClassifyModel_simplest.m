 function [precision, recall, Fscore] = ClassifyModel_simplest(data,labels)
% Implements a regression model
% Inputs: data - a 1000 by 25 matrix containing the data from 1000 patients.
%         labels - a 1 by 1000 vector containting the survival times for the patients
%         mode - a flag that determines which batch selection strategy is used. 1 = default selection mode; 2 = diverse label mode
% Outputs: loss a 1 by 90 vector that returns the generalization error as function of the number of rounds (90) 
len = 1000;

precision = zeros(1,len);
recall = zeros(1,len);
Fscore = zeros(1,len);
matrix = [data(1:10, :)];

for i=11:len+10
    matrix = [matrix; data(i, :)];
    tree = fitctree(matrix, labels(:,1:i));
%     B = TreeBagger(3, matrix, labels(:,1:i));
     SVM = fitcsvm(matrix, labels(:,1:i));
%     L = str2double(B.predict(data));
    L=SVM.predict(data);
    [indexs, ones_in_L] = find(L==1);
    ones_in_labels = labels(indexs);
    t = i-10;
    precision(t) = sum(ones_in_labels) / sum(ones_in_L);
    recall(t) = sum(ones_in_labels) / sum(labels);
    Fscore(t) = 2 * precision(t) * recall(t) / (precision(t) + recall(t));
end
end