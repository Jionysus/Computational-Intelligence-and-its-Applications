function [sol, val]=gasingle_vareval(sol,options)

% evaluation function

x=sol;

val=x*sin(10*pi*x)+2;