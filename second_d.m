function Diver = second_d(p)

[N,~] = size(p);
Zmin = min(p, [], 1); Zmax = max(p, [], 1);
T = (N);
d = (Zmax - Zmin)/(T);
G = floor((p - repmat(Zmin, [N 1]))./repmat(d, [N 1]));

GD =  pdist2(G, G); 
GD(logical(eye(N))) = 1e20;
DD = sort(GD,2,'ascend');

if(size(DD,2) < 2)
    Diver = [DD(:,1).^3];

else
    Diver = [DD(:,1).^3+DD(:,2).^2];
end

end
