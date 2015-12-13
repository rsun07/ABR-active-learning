function [ score ] = get_score( matrix, data, labels, current_i, current_j, prev_model )
%GET_SCORE Summary of this function goes here
%   Detailed explanation goes here
% data is only used to see if 
count = 0;
score = -1000;
if(current_j==1)
    if matrix(current_i, 1:3) == data(current_i,1:3)
        return
    end
elseif(current_j==2)
    if matrix(current_i, 4:28) == data(current_i,4:28)
        return
    end
elseif(current_j==3)
    if matrix(current_i, 29:128) == data(current_i,29:128)
        return
    end
elseif(current_j==4)
    if matrix(current_i, 129:130) == data(current_i,129:130)
        return
    end                              
end

for i = 1:size(matrix)
    cost = 0;
    if labels(i) ~= labels(current_i)
        continue
    end
    if current_i == i
        continue
    end
    if(current_j==1)
        if matrix(current_i, 1:3) ~= matrix(i,1:3)
            continue
        end
        matrix(current_i, 1:3) = matrix(i,1:3);
        cost = 10;
    elseif(current_j==2)
        if matrix(current_i, 4:28) ~= matrix(i,4:28)
            continue
        end        
        matrix(current_i, 4:28) = matrix(i,4:28);    
        cost = 250;
    elseif(current_j==3)
        if matrix(current_i, 29:128) ~= matrix(i,29:128)
            continue
        end
        matrix(current_i, 29:128) = matrix(i,29:128);                        
        cost = 500;
    elseif(current_j==4)
        if matrix(current_i, 129:130) ~= data(i,129:130)
            continue
        end        
        matrix(current_i, 129:130) = data(i,129:130); 
        cost = 1000;
    end
    count = count + 1;
    B = fitctree(matrix, labels(:,1:size(matrix, 1)));
    score = score + (get_f_score(matrix, labels, B) - get_f_score(matrix, labels, prev_model))/cost;
    
score = score/count;
end

