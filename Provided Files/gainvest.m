clear all
close all
% investment using GA

% Hang Seng Index
load('data\gain_data\HSI.mat');
temp=[train_data test_data];
figure(1)
plot(temp,'k');
xlabel('month')
ylabel('HSI')
title('Hang Seng Index');
hold on
stem(1,temp(1),'r');
stem(48,temp(48),'r');
stem(49,temp(49),'b');
stem(66,temp(66),'b');
text(15,8000,'training period');
text(50,8000,'testing period');





% specify the condition data set
var1='retail-index.mat';
var2='dj_c.mat';
var3='jpy.mat';

% select strategy
strategy=2;%% '1' for strategy I; '2' for strategy II

save var_name;

% initialization
initPop=initializega(10,[0 2^21],'gainvesteval',[],[1 0]);

% Now let's run the ga 
% [x,endPop,bPop,traceInfo] = ga([0 2^21],'gainvesteval',[],initPop,[1 0 0],'maxGenTerm',15,...
%   'normGeomSelect',[0.08],['simpleXover'],[0.6],'binaryMutation',[.05]);
% [x,endPop,bPop,traceInfo] = ga([0 2^21],'gainvesteval',[],initPop,[1 0 0],'maxGenTerm',15,...
%   'roulette',[0.08],['simpleXover'],[0.6],'binaryMutation',[.05]);
[x,endPop,bPop,traceInfo] = ga([0 2^21],'gainvesteval',[],initPop,[1 0 0],'maxGenTerm',15,...
  'tournSelect',[5],['simpleXover'],[0.6],'binaryMutation',[0.05]);

x %The best found
traceInfo(:,2)=traceInfo(:,2)-5;

[x,final_gain_train,correct_rate_train]=gainvesteval(x);
final_gain_train=final_gain_train-5;
best_rule=dec2bin(x,21)
final_gain_train
correct_rate_train

figure(2)
plot(traceInfo(:,2),'-o')
xlabel('generation');
ylabel('best record');
title('return vs. generation')

% test the learned rule 

[x,final_gain_test,correct_rate_test]=test_gain(x);
final_gain_test=final_gain_test-5;
final_gain_test
correct_rate_test

%[x,final_gain_test,correct_rate_test]=test_gain1(x);
%final_gain_test=final_gain_test-5;
%final_gain_test
%correct_rate_test