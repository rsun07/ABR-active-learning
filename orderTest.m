function  [result,cost]=orderTest(id,t)
% input: id - patient id
%        t - test type (1 = inexpensive proteomic panel; 2=expensive proteomic panel; 3 = genotyping; 4 = imaging).
% output: result - test results
%         cost - test cost
[data] = csvread('stream.csv');

if(t==1)
    result = data(id,1:3);
    cost = 10;
elseif(t==2)
    result = data(id,4:28);
    cost = 250;
elseif(t==3)
    result = data(id,29:128);
    cost = 500;
elseif(t==4)
    result = data(id,129:130);
    cost = 1000;
end
end