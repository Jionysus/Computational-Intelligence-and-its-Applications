clear all
close all

D=dir('*.txt');
for i=1:max(size(D))
    s_datafile=D(i).name;
    s_filename=s_datafile(1:max(size(s_datafile))-4);
    fid1=fopen(s_datafile,'r');
    data=fscanf(fid1,'%s');
    
    
    %% extract the unit data of each month
    t=1;% counter: letter
    d=1;% counter: day data
    while max(size(data))>0&&(t+7)<max(size(data))
        t=t+1;
        start_p=1;
        temp_label1=data(1:7);
        temp_label2=data(t:t+7);
        if temp_label2(3)=='-'
            end_p=t-1;
            unit_data(d).data=data(start_p:end_p);
            data(start_p:end_p)=[];
            t=1;
            d=d+1;
        end
    end
    unit_data(d).data=data;
    % end of extract unit data of each month and recorded as unit_data.data;
    
    % format the month data
    for l=1:max(size(unit_data))
        temp=unit_data(l).data;
        month_data(l).year=temp(4:7);
        month_data(l).month=temp(1:2);
        temp(1:8)=[];
        month_data(l).average=str2num((temp(1:max(size(temp))-1)));
    end
    % %% month_data.year
    %              .month
    %              .average
    %% end of format the unit_data to daily_data
    
    % reorder the data
    clear temp;
    M=max(size(month_data));
    for m=1:M
        month_data_new(M-m+1)=month_data(m);
    end
    month_data=month_data_new;
    
    
    %% extract the test data
    
    for m=1:max(size(month_data))
        if str2num(month_data(m).year)==2005&&str2num(month_data(m).month)==05
            start_month=m
        end
        if str2num(month_data(m).year)==2003&&str2num(month_data(m).month)==12
            end_month=m
        end
    end
    
    p=1;
    for m=start_month:end_month
        test_data(p)=month_data(m).average;
        p=p+1;
    end
    
    %% end of extraction of test data
    
    %% extract the training data
    
    for m=1:max(size(month_data))
        if str2num(month_data(m).year)==2003&&str2num(month_data(m).month)==11
            start_month=m
        end
        if str2num(month_data(m).year)==1999&&str2num(month_data(m).month)==12
            end_month=m
        end
    end
    
    p=1;
    for m=start_month:end_month
        train_data(p)=month_data(m).average;
        p=p+1;
    end
    
    %% end of extraction of training data
    
    test_data
    train_data
    save(s_filename,'test_data','train_data');
    
    
    
    
    
    fclose(fid1)
end
