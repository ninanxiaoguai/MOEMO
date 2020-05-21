function Print(fun,run_name,eva,runtime,x,y)
    % problem001run001.dat
    
    fun_name = num2str(fun,'%03d');
    Run = num2str(run_name,'%03d');
    file_name = ['data/problem' fun_name 'run' Run '.dat'];
    fid=fopen(file_name,'a');
    [n,d] = size(x);
    for i=1:n
        for j=1:d
            fprintf(fid,'%.15f ',x(i,j));
        end
        fprintf(fid,'= %.15f @ %s %.5f\n',y(i),num2str(eva(i)),runtime(i)*1000);
    end
    fclose(fid);

end
