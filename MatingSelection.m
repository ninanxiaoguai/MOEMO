function MatingPool = MatingSelection(Population)
% 随机打乱后配对
    [N,~] = size(Population);
    MatingPool = Population(randperm(N),:);
    if(mod(size(MatingPool,1), 2) == 1)
        MatingPool = [MatingPool; MatingPool(1,:)];
    end
    
end

