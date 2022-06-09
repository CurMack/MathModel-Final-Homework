function Len = SA_TSP_len(X, T0, Tend, L, q)

D = Distanse(X);  %计算距离矩阵
N = size(D,1);    %城市的个数

%% 初始解
S1 = randperm(N);  %随机产生一个初始路线
cnt = 1;
Len = 0;       %目标值初始化
%% 迭代
while T0 > Tend
    temp = zeros(L,N+1);
    for k = 1:L
        % 产生新解
        tmp = randperm(2);
        if tmp(1) == 1
            S2 = Mutate(S1,1);
        else 
            S2 = Reverse(S1,D);
        end
        % Metropolis法则判断是否接受新解
        [S1,R] = Metropolis(S1,S2,D,T0);  % Metropolis 抽样算法
        temp(k,:) = [S1 R];          %记录下一路线的及其路程
    end

    % 记录每次迭代过程的最优路线
    [d0, ~] = min(temp(:, end)); %找出当前温度下最优路线
    if cnt == 1 || d0 < Len
        Len = d0;           % 如果当前温度下最优路程小于上一路程则记录当前路程
    end
    T0 = q*T0;     % 降温
    cnt = 2;
end

