function run_streaming

len = 1000;
numExp=2;
tPrecision=zeros(1, len);
tRecall=zeros(1, len);
tFscore=zeros(1, len);

for(i=1:numExp)
    display(sprintf('Running round %d out of %d (this may take a few minutes)', i,numExp))
    [data, labels, cost] = getData(5);
    display(sprintf(' Mode = 1 ...'))
    [precision, recall, Fscore] = Streaming_solution(data,labels);
    tPrecision = tPrecision+precision;
    tRecall = tRecall+recall;
    tFscore = tFscore+Fscore;
end
tPrecision=tPrecision/numExp;
tRecall=tRecall/numExp;
tFscore=tFscore/numExp;
figure(1)
plot(precision,'g');
hold on
plot(recall,'r');
hold on
plot(tFscore,'b');
hold off
xlabel('rounds')
ylabel('');
legend('precision','recall', 'F-score');
