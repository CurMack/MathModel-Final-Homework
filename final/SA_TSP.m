function SA_TSP(X, T0, Tend, L, q)

D = Distanse(X);  %计算距离矩阵
N = size(D,1);    %城市的个数

%% 初始解
S1 = randperm(N);  %随机产生一个初始路线
L0 = PathLength(D, S1);

%% 计算迭代的次数
syms x;
Time = ceil(double(solve(1000*(q)^x == Tend, x)));
cnt = 0;        %迭代计数
Length_best = zeros(Time,1);         %目标值矩阵初始化
S = zeros(1,N);       %每代的最优路线矩阵初始化
%% 迭代
while T0 > Tend
    cnt = cnt+1;     %更新迭代次数
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
    [d0,index] = min(temp(:, end)); %找出当前温度下最优路线
    if cnt == 1 || d0 < Length_best(cnt-1)
        Length_best(cnt) = d0;           % 如果当前温度下最优路程小于上一路程则记录当前路程
    else
        Length_best(cnt) = Length_best(cnt-1);% 如果当前温度下最优路程大于上一路程则记录上一路程
    end
    S = temp(index, 1:end-1);  % 记录当前温度的最优路线

    T0 = q*T0;     % 降温
end


%% 输出最优解的路线和总距离
disp('SA_solution:')
OutputPath(S);
disp(['total distance: ',num2str(PathLength(D,S))]);
disp('----------------------------------------')

%% 最优解的路径图
DrawPath(S,X, '模拟退火算法')

%% 优化过程迭代图
figure;
plot(1:cnt,Length_best);
xlabel('迭代次数');
ylabel('最优值');
title('模拟退火算法 优化过程');
axis([0 250 0.85*PathLength(D,S) L0-3]);




