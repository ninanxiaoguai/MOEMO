
function [Population,Boundary] = Initialization(SOP,N)
% 初始化种群，返回上下界
    [MaxValue, MinValue, ~, ~, D] = Fun_info(SOP);
    Population = lhsdesign(N,D);
    Population = Population.*repmat(MaxValue,N,1)+(1-Population).*repmat(MinValue,N,1);
    Boundary = [MaxValue;MinValue];
    
end

