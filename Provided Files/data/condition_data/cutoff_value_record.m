clear all
close all

D=dir('*.mat');
dataname='cutoff_data.pat'
fid1=fopen(dataname,'a');

for l=1:max(size(D))
    filename=D(l).name;
    load(filename)
    c1=fprintf(fid1,[filename '\n']);
    data=train_data;
    Vmin=min(data);
    Vmax=max(data);
    Vd=(Vmax-Vmin)/32;
    c1=fprintf(fid1,'%c','min=');
    c1=fprintf(fid1,'%8.2f',Vmin);
    c1=fprintf(fid1,'\n');
    c1=fprintf(fid1,'%c','max=');
    c1=fprintf(fid1,'%8.2f',Vmax);
    c1=fprintf(fid1,'\n');
    for m=1:32
        c1=fprintf(fid1,'%8.2f',Vmin+Vd*(m-1));
        c1=fprintf(fid1,', ');
        if fix(m/8)==m/8
            c1=fprintf(fid1,'\n');
        end
    end
    c1=fprintf(fid1,'\n');
end
fclose(fid1)