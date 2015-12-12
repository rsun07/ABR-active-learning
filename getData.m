function [data labels cost] = getData(test_id)
% input: test_id - test id
% output: data - features of test data

[data_raw] = csvread('stream.csv');
m = load('trueLabels.mat');
labels=m.trueLabels;

if(test_id==1)
    data = data_raw(:,1:3);
    cost = 10;
elseif(test_id==2)
    data = data_raw(:,4:28);
    cost = 250;
elseif(test_id==3)
    data = data_raw(:,29:128);
    cost = 500;
elseif(test_id==4)
    data = data_raw(:,129:130);
    cost = 1000;
elseif(test_id==5)
    data = data_raw;
    cost = 1000;
end
end