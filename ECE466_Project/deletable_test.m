clear all;
clc;
close all;
% [x,t] = iris_dataset;
% net = patternnet(10);
% net = train(net,x,t);
% y = net(x);
% perf = perform(net,t,y);
% classes = vec2ind(y);
% figure, plotconfusion(t,y)
% [c,cm]=confusion(t,y);
% fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
% fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
% 
% i=[1 2 3 4 5 6 7 8 9 0; 4 3 2 1 0 -1 -2 -3 -4 -5]

%deletable_test

[x,t] = crab_dataset;
size(x);
size(t);
setdemorandstream(491218382);
net = patternnet(10);
view(net);
[net,tr] = train(net,x,t);
nntraintool
plotperform(tr)
testX = x(:,tr.testInd);
testT = t(:,tr.testInd);

testY = net(testX);
testIndices = vec2ind(testY);
[c,cm] = confusion(testT,testY)

perf = perform(net,testT,testY)
fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);