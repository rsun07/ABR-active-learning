 function [precision, recall, Fscore] = String_solution(data,labels)
% Implements a regression model
% Inputs: data - a 1000 by 25 matrix containing the data from 1000 patients.
%         labels - a 1 by 1000 vector containting the survival times for the patients
%         mode - a flag that determines which batch selection strategy is used. 1 = default selection mode; 2 = diverse label mode
% Outputs: loss a 1 by 90 vector that returns the generalization error as function of the number of rounds (90) 
len = 1000;

precision = zeros(1,len);
recall = zeros(1,len);
Fscore = zeros(1,len);
matrix = [];
belda = 1;
cost = 0;

vector = repmat(-100,1,130);

for i=1:len
    matrix = [matrix; vector];
    [i_s, j_s] = get_matrix_score(matrix, belda);
    
    for k=1:belda
        current_i = i_s(k);
        current_j = j_s(k);
        if(current_j==1)
            matrix(current_i, 1:3) = data(current_i,1:3);
            cost = cost + 10;
        elseif(current_j==2)
            matrix(current_i, 4:28) = data(current_i,4:28);            
            cost = cost + 250;
        elseif(current_j==3)
            matrix(current_i, 29:128) = data(current_i,29:128);                        
            cost = cost + 500;
        elseif(current_j==4)
            matrix(current_i, 129:130) = data(current_i,129:130);                        
            cost = cost + 1000;
        end
    end
    
%     tree = fitctree(matrix, labels(:,1:i));
     B = TreeBagger(3, matrix, labels(:,1:i));
%      SVM = fitcsvm(matrix, labels(:,1:i));
    L = str2double(B.predict(data));
    [indexs, ones_in_L] = find(L==1);
    ones_in_labels = labels(indexs);
    precision(i) = sum(ones_in_labels) / sum(ones_in_L);
    recall(i) = sum(ones_in_labels) / sum(labels);
    Fscore(i) = 2 * precision(i) * recall(i) / (precision(i) + recall(i));
end
end