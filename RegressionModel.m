 function [loss] = RegressionModel(data,labels)
% Implements a regression model
% Inputs: data - a 1000 by 25 matrix containing the data from 1000 patients.
%         labels - a 1 by 1000 vector containting the survival times for the patients
%         mode - a flag that determines which batch selection strategy is used. 1 = default selection mode; 2 = diverse label mode
% Outputs: loss a 1 by 90 vector that returns the generalization error as function of the number of rounds (90) 

loss = zeros(1,1000);
[matrix, data_indexs] = random_data(data, 1000);
cosines = [];
for j=1:length(data)
    cosines = [cosines, getCosine(data(j,:), data)];
end

for i=1:1000
    [cosines, cosine_indexs] = sort(cosines, 'descend');
    p1 = getRandi(data_indexs, cosine_indexs);
    matrix = [matrix; data(p1, :)];
    data_indexs = [data_indexs, p1];

    B = TreeBagger(3, matrix, labels(data_indexs), 'Method', 'regression');
    L = B.predict(data);

    loss(i) = computeLoss2(L, labels);
end
end

function [matrix, data_indexs] = random_data(data, num)
    data_indexs = randsample(size(data, 1), num)';
    matrix = data(data_indexs, :);
end

function p = getRandi(data_indexs, cosine_indexs)
        for p=cosine_indexs
            if ~ismember(p, data_indexs) && p < 10000
                return;
            end
        end
end

function cosine = getCosine(vector, matrix)
    cosine = sum(matrix*vector');
end