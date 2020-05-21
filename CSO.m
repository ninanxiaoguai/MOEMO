%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Implementation of a competitive swarm optimizer (CSO) for large scale optimization
%
%  See the details of CSO in the following paper
%  R. Cheng and Y. Jin, A Competitive Swarm Optimizer for Large Scale Optmization,
%  IEEE Transactions on Cybernetics, 2014
%
%  The source code CSO is implemented by Ran Cheng
%
%  If you have any questions about the code, please contact:
%  Ran Cheng at r.cheng@surrey.ac.uk
%  Prof. Yaochu Jin at yaochu.jin@surrey.ac.uk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [bestx, bestf,eva] = CSO(seedx, funcid, maxfes, lbounds, ubounds)

d = size(seedx,2);
lu = [lbounds'; ubounds'];
if(funcid <= 18)
    m = 20;
else
    m = 60; % for high-dimensional problems, you may try larger swarm size
end
% m = 20;
phi = 0;
[~,ddd] = min(-niching_func(seedx, funcid));
% best results
bestx = seedx(ddd,:); 
bestff = -niching_func(bestx,funcid);
bestf = bestff;
% initialization
XRRmin = repmat(lu(1, :), m, 1);
XRRmax = repmat(lu(2, :), m, 1);
p = XRRmin + (XRRmax - XRRmin) .* rand(m, d);% Random
% p = XRRmin + (XRRmax - XRRmin) .* lhsdesign(m,d); % Latin
if(size(seedx,1) > m)
    [~,ddd] = min(-niching_func(seedx, funcid));
    dd = randperm(size(seedx,1));
    p = seedx(dd(1:m),:);
    p(1,:) = seedx(ddd,:);
else
    p(1:size(seedx,1),:) = seedx;
    
end

fitness = -niching_func(p, funcid);
v = zeros(m,d);

FES = m;
gen = 0;
eva = 0;
% main loop
while(FES < maxfes)

    % generate random pairs
    rlist = randperm(m);
    rpairs = [rlist(1:ceil(m/2)); rlist(floor(m/2) + 1:m)]';
    
    % calculate the center position
    center = ones(ceil(m/2),1)*mean(p);
    
    % do pairwise competitions
    mask = (fitness(rpairs(:,1)) > fitness(rpairs(:,2)));
    losers = mask.*rpairs(:,1) + ~mask.*rpairs(:,2);
    winners = ~mask.*rpairs(:,1) + mask.*rpairs(:,2);
    
    %random matrix
    randco1 = rand(ceil(m/2), d);
    randco2 = rand(ceil(m/2), d);
    randco3 = rand(ceil(m/2), d);
    
    % losers learn from winners
    v(losers,:) = randco1.*v(losers,:) ...,
        + randco2.*(p(winners,:) - p(losers,:)) ...,
        + phi*randco3.*(center - p(losers,:));
    p(losers,:) = p(losers,:) + v(losers,:);
    
    % boundary control
    for i = 1:ceil(m/2)
        p(losers(i),:) = max(p(losers(i),:), lu(1,:));
        p(losers(i),:) = min(p(losers(i),:), lu(2,:));
    end
    
    % fitness evaluation
    fitness(losers,:) = -niching_func(p(losers,:), funcid);
    % best solution
    [B,I] = min(fitness);
    
    if(B < bestf)
        bestf = B;
        bestx = p(I,:);
        eva = FES;
    end
    FES = FES + ceil(m/2);
    
    gen = gen + 1;
%     if(size(p,2) == 1)
%         plot(p(:,1),bestf,'+')
% %         axis([min(seedx(1))-1 max(seedx(1))+1 bestff-1 bestff+1 ])
%         drawnow
%     else
%         plot(p(:,1),p(:,2),'+')
% %         axis([min(seedx(1))-1 1.1*max(seedx(1))+1 min(seedx(2))-1 max(seedx(2))+1 ])
%         drawnow
%     end
end

end

