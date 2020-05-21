clc;format short;
currentFolder = pwd;
addpath(genpath(currentFolder));

Iter =1:50;
showfig = 1;
show_results = 1;
Res = [];
Problems = 2;
global initial_flag

for Prob = Problems
    initial_flag = 0;
    % D > 2 时即使 showfig=1 也不选择输出
    pic_flag = (get_dimension(Prob) <= 2)*showfig; 
    
    for iter = Iter
        res = MMO_main(Prob,iter,pic_flag,show_results);
        Res = [Res;res];
    end
end

