function [i_s, j_s] = get_matrix_score(matrix, data, belda, mode, labels)
%Get index of the highest score query
%   Detailed explanation goes here

if mode == 1
    i_s = size(matrix,1);
    j_s = 1;
end

if mode == 2
    i_s = size(matrix,1);
    j_s = 2;
end

if mode == 3
    i_s = size(matrix,1);
    j_s = 3;
end

if mode == 4
    i_s = size(matrix,1);
    j_s = 4;
end

if mode == 5
    % the tricky one
    scores(size(matrix, 1), 4) = 0;
    B = TreeBagger(3, matrix, labels(:,1:size(matrix, 1)));
    for i = 1:size(matrix,1)
        for j = 1:4
            scores(i, j) = get_score(matrix, data, labels, i, j, B);
        end
    end
    [i_s, j_s] = ind2sub(size(scores), find(scores==max(max(scores))));

end

