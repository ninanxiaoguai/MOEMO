function [MaxValue, MinValue, FEs, N, D,percent] =  Fun_info(func_num)
% 根据函数的ID，返回上界，下界，最大评估次数，种群个数，决策变量个数，

    global initial_flag
    initial_flag = 0;
    
    D = get_dimension(func_num);
    MaxValue = get_ub(func_num);
    MinValue = get_lb(func_num);
    if(D ~= length(MaxValue))
        MaxValue = repmat(MaxValue(1), [1 D]);
        MinValue = repmat(MinValue(1), [1 D]);
    end
    if(func_num < 15)
        N = 200;
    else
        N = 400;
    end
    if(D < 6)
        percent = 0.4;
    else
        percent = 0.5;
    end
    FEs = get_maxfes(func_num);

end