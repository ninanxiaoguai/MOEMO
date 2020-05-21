function Output = Fun_value(func_num,Population)
% 计算当前的函数值
    Output = -niching_func(Population, func_num);
    Output = [Output ,-second_d(Population)];

end
