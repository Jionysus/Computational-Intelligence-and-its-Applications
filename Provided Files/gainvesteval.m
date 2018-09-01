function [sol, val, correct_rate] = gainvesteval(sol,options)
% evaluate function for the investment problem 
% val - the fittness of this individual
% sol - the individual, returned to allow for Lamarckian evolution
% options - [current_generation]

x=sol;
b=dec2bin(x,21);
load var_name
% variable 1
% load(['data\condition_data\jpy.mat']);
load(['data\condition_data\' var1]);
cond_data(:,1)=train_data';
% variable 2
load(['data\condition_data\' var2]);
cond_data(:,2)=train_data';
% varible 3
load(['data\condition_data\' var3]);
cond_data(:,3)=train_data';

all_cond=decision(b,cond_data);

% Hang Seng Index
load('data\gain_data\HSI.mat');
gain_data=train_data;

% strategy I
if strategy==1
    correct=0; %num of correct prediction
    invest(1)=1;% initial invest
    for l=1:max(size(gain_data))-1
        groundtruth=gain_data(l+1)-gain_data(l);% the truth
        if all_cond(l)==1 % positive condition --> invest!
            gain=(gain_data(l+1)-gain_data(l))/gain_data(l);
            invest(l+1)=invest(l)*(1+gain);
        else
            gain=0; % negative condition --> no action.
            invest(l+1)=invest(l)*(1+gain);
        end
        if all_cond(l)==1&groundtruth>0
            correct=correct+1;
        end
        if all_cond(l)==0&groundtruth<0
            correct=correct+1;
        end
    end
    correct_rate=correct/(max(size(gain_data))-1);% correct prediction rate
end

% strategy II
if strategy==2
    correct=0; % num of correct prediction
    invest(1)=1;% initial invest
    for l=1:max(size(gain_data))-1
        groundtruth=gain_data(l+1)-gain_data(l);% the truth
       if all_cond(l)==1 % positive condition --> invest!
            gain=(gain_data(l+1)-gain_data(l))/gain_data(l);
            invest(l+1)=invest(l)*(1+gain);
        else % negative condition --> no action.
            gain=-(gain_data(l+1)-gain_data(l))/gain_data(l); 
            invest(l+1)=invest(l)*(1+gain);
        end
        if all_cond(l)==1&groundtruth>0
            correct=correct+1;
        end
        if all_cond(l)==0&groundtruth<0
            correct=correct+1;
        end
    end
    correct_rate=correct/(max(size(gain_data))-1);% correct prediction rate
end

final_invest=invest(max(size(invest)));% final property after four years under this rule
val=final_invest+4;

function all_cond=decision(b,cond_data)
% this function 
% 1) decodes the input 21-bit binary code 'b' into the real condtion rule 
% 2) decide whether the cond_data satisfy the condition rule
% input: 
% b -- 21-bit binary code
% cond_data -- 48*3 array, three kinds of condtion data
% output:
% all_cond -- 48*1 array, '1' positive; '0' negative;

data=cond_data;

Vmin=min(data);
Vmax=max(data);
Vd=(Vmax-Vmin)/32;

x_value=b(1:5);
cutoff_x_value=Vmin(1)+Vd(1)*(bin2dec(x_value));
y_value=b(6:10);
cutoff_y_value=Vmin(2)+Vd(2)*(bin2dec(y_value));
z_value=b(11:15);
cutoff_z_value=Vmin(3)+Vd(3)*(bin2dec(z_value));
logic_code=bin2dec(b(16:18))+1; % 1,2,3,4,5,6,7,8 eight logical groupings of three conditions
sign=b(19:21); % 1 for '>=' ; 0 for '<'

for m=1:max(size(data))
    % real=data(1,1)
    % demand=sign(1)
    % cut_value=cutoff_x_value
    if bin2dec(sign(1))==1
        cond1=[data(m,1)>=cutoff_x_value];
    else
        cond1=[data(m,1)<cutoff_x_value];
    end
    
    % real=data(1,2)
    % demand=sign(2)
    % cut_value=cutoff_y_value
    if bin2dec(sign(2))==1
        cond2=[data(m,2)>=cutoff_y_value];
    else
        cond2=[data(m,2)<cutoff_y_value];
    end
    
    % real=data(1,3)
    % demand=sign(3)
    % cut_value=cutoff_z_value
    if bin2dec(sign(3))==1
        cond3=[data(m,3)>=cutoff_z_value];
    else
        cond3=[data(m,3)<cutoff_z_value];
    end
    
    if logic_code==1
        all_cond(m)=[cond1|(cond2&cond3)];
    end
    if logic_code==2
        all_cond(m)=[cond1&(cond2|cond3)];
    end
    if logic_code==3
        all_cond(m)=[(cond1|cond2)&cond3];
    end
    if logic_code==4
        all_cond(m)=[(cond1&cond2)|cond3];
    end
    if logic_code==5
        all_cond(m)=[(cond1|cond3)&cond2];
    end
    if logic_code==6
        all_cond(m)=[(cond1&cond3)|cond2];
    end
    if logic_code==7
        all_cond(m)=[cond1|cond2|cond3];
    end
    if logic_code==8
        all_cond(m)=[cond1&cond2&cond3];
    end
end

