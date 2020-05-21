clc,clear
% 根据20x50个输出文件统计最终结果
Result = [];
E = [];
S = [];
global initial_flag
for problem = 1:20
    e = [];
    su = [];
    for run = 1:50
        initial_flag = 0;
        name = ['data/problem' num2str(problem,'%03d') 'run' num2str(run,'%03d') '.dat'];
        dem = get_dimension(problem);
        s = '%f';
        for i = 1:dem-1
            s = [s '%f'];
        end
        s = [s '%s%s%s%s%s'];
        fid = fopen(name);
        C = textscan(fid,s);
        fclose(fid);
        res = cell2mat(C(:,1:dem));
        n = size(res,1);
        epsilon = [1e-1 1e-2 1e-3 1e-4 1e-5];
        optimal_numbs = [2 5 1 4 2 18 36 81 216 12 6 8 6 6 8 6 8 6 6 8];
        temp = [];
        for i = 1:length(epsilon)
            [count, ~] = count_goptima(res, problem, epsilon(i));
            temp = [temp count];
        end
        e = [e;temp];
        su = [su;(temp == optimal_numbs(problem))-0];
        Result = [Result;[problem run optimal_numbs(problem) temp]];
    end
    E = [E;[problem mean(e,1)/optimal_numbs(problem)]];
    S = [S;mean(su,1)];
end
f = Result==0;
f = any(f,2);
not_good = Result(f,1:2);