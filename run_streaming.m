function run_streaming

len = 1000;
numExp=1;
tPrecision=zeros(1, len);
tRecall=zeros(1, len);
tFscore=zeros(1, len);
cost = 0;

for(i=1:numExp)
    display(sprintf('Running round %d out of %d (this may take a few minutes)', i,numExp))
    [data, labels, cost] = getData(5);
    display(sprintf(' Mode = 1 ...'))
    [precision, recall, Fscore, costs] = Streaming_solution(data,labels);
    tPrecision = tPrecision+precision;
    tRecall = tRecall+recall;
    tFscore = tFscore+Fscore;
end
tPrecision=tPrecision/numExp;
tRecall=tRecall/numExp;
tFscore=tFscore/numExp;
figure(1)
plot(tPrecision,'g');
hold on
plot(tRecall,'r');
hold on
plot(tFscore,'b');
hold off
xlabel('rounds')
ylabel('');
legend('precision','recall', 'F-score');

figure(2)
plot(costs,'g');
xlabel('rounds')
ylabel('cost');
