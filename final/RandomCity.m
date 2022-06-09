function X = RandomCity(n)
% n 为城市数量
X = zeros(n,2);
for i = 1:n
    X(i,1) = rand * n;
    X(i,2) = rand * n;
end