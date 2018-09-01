clear all
close all
% single variable using GA


% initialization
initPop=initializega(30,[1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10],'gamultiple_vareval',[],[10^(-10) 1]);

% Now let's run the ga 
% [x,endPop,bPop,traceInfo] = ga([1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10],'gamultiple_vareval',[],initPop,[10^(-10) 1 0],'maxGenTerm',200,...
%   'normGeomSelect',[0.08],['simpleXover'],[8],'unifMutation',[8]);
% [x,endPop,bPop,traceInfo] = ga([1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10],'gamultiple_vareval',[],initPop,[10^(-10) 1 0],'maxGenTerm',200,...
%   'normGeomSelect',[0.08],['arithXover'],[8],'unifMutation',[8]);
[x,endPop,bPop,traceInfo] = ga([1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10],'gamultiple_vareval',[],initPop,[10^(-10) 1 0],'maxGenTerm',100,...
  'normGeomSelect',[0.08],['simpleXover arithXover'],[5 0; 5 0],'boundaryMutation unifMutation',[5 0; 5 0]);
% [x,endPop,bPop,traceInfo] = ga([1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10;1 10],'gamultiple_vareval',[],initPop,[10^(-10) 1 0],'maxGenTerm',100,...
%   'tournSelect',[5],['simpleXover'],[5 0],'unifMutation',[5 0]);


[fsol,f]=gamultiple_vareval(x);

sol = fsol(1:10);
format short e;
sol % the best variable value
f % the function value

figure(1)
plot(traceInfo(:,2),'-o')
xlabel('generation');
ylabel('maximum value at each generation');
title('maximum vs. generation')

