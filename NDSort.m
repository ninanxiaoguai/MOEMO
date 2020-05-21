function [FrontValue,MaxFront] = NDSort(FunctionValue)

% Efficient non-dominated sort on sequential search strategy, TEVC, 2014,
% Xingyi Zhang, Ye Tian, Ran Cheng and Yaochu Jin
% Copyright 2014 BCMA Group, Written by Mr Ye Tian and Prof Xingyi Zhang
% Contact: xyzhanghust@gmail.com


    [N,M] = size(FunctionValue);
    MaxFront = 0;
    Sorted = false(1,N);
    [FunctionValue,rank] = sortrows(FunctionValue);
    FrontValue = zeros(1,N) + inf;
    while (sum(Sorted)<N/2)
        MaxFront = MaxFront + 1;
        ThisFront = false(1,N);
        for i = 1 : N
            if ~Sorted(i)
                x = 0;
                for j = 1 : N
                    if ThisFront(j)
                        x = 2;
                        for j2 = 2 : M
                            if FunctionValue(i,j2) < FunctionValue(j,j2)
                                x = 0;
                                break;
                            end
                        end
                        if x == 2
                            break;
                        end
                    end
                end
                if x ~= 2
                    ThisFront(i) = true;
                    Sorted(i) = true;
                end
            end
        end
        FrontValue(rank(ThisFront)) = MaxFront;
    end
end