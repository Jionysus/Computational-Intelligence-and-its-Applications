clear all
close all
% single variable using GA

figure(1)
fplot('x*sin(10*pi*x)+2',[-1 2]);
title('f(x)');

% initialization
initPop=initializega(10,[-1 2],'gasingle_vareval',[],[10^(-5) 0]);

% Now let's run the ga 

[x,endPop,bPop,traceInfo] = ga([-1 2],'gasingle_vareval',[],initPop,[10^(-5) 0 0],'maxGenTerm',15,...
  'normGeomSelect',[0.08],['simpleXover'],[0.6],'binaryMutation',[.05]);

[sol,f]=gasingle_vareval(x);

x % the best variable value
f % the function value

figure(2)
plot(traceInfo(:,2),'-o')
xlabel('generation');
ylabel('maximum value at each generation');
title('maximum vs. generation')

figure(1)

hold on
stem(x,f,'ro')
text(x+.1,f,'best');


