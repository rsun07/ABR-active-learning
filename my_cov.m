function [l0, l1] = my_cov()

[data, labels, cost] = getData(5);
[index1, one] = find(labels==1);
[index0, zero] = find(labels==0);

data1 = data(index1,:);
data0 = data(index0,:);

l1 = cov(data1);
l0 = cov(data0);

end

