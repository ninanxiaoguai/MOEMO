function [OffspringX, OffspringF,front_f,Eva,Times] = EnvironmentalSelection(Population,...,
                                               FunctionValue,N,all_Eva,all_time)
% NSGA-II 中的环境选择


[FrontValue,MaxFront] = NDSort(FunctionValue);
Next = zeros(1,N);
NoN = numel(FrontValue,FrontValue<MaxFront);
Next(1:NoN) = find(FrontValue<MaxFront);

Last = find(FrontValue==MaxFront);

CrowdDistance = CalculCrowdDistance(FunctionValue,FrontValue);
[~,Rank] = sort(CrowdDistance(Last),'descend');

Next(NoN+1:N) = Last(Rank(1:N-NoN));
front_f = FrontValue(Next);
OffspringX = Population(Next,:);
OffspringF = FunctionValue(Next,:);
Eva = all_Eva(Next);
Times = all_time(Next);
end

