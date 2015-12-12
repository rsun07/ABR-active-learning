function loss = computeLoss2(L, labels)
%% Compute the loss
% Input:
%       L: labeling of leaf nodes
%       labels: true labels of each node
% Output:
%       loss: squared loss of current prediction
    loss = sum(abs(L - labels'))/1000;
end