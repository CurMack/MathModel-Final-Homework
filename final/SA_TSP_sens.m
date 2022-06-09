clear; clc;
% 导入数据
% load CityPosition2.mat
X = RandomCity(100);
%%
% SA_TSP_len(X, T0, Tend, L, q)
% 初始化参数
T0 = 1000;                      % 初始温度
Tend = 1e-3;                    % 终止温度
L = 200;                        % 恒温的迭代次数（链长）
q = 0.95;                       % 降温速率

%% T0 初始温度
t_len = zeros(200,1);
i = 1;
for t = 1:10:2000
    t_len(i) = SA_TSP_len(X, t, Tend, L, q);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(1:10:2000, t_len,'b');
xlabel('初始温度');
ylabel('最短距离');
title('退火算法关于初始温度的灵敏度分析');

%% q 降温速率
q_len = zeros(99,0);
i = 1;
for qt = 0.01:0.01:0.99
    q_len(i) = SA_TSP_len(X, T0, Tend, L, qt);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(0.01:0.01:0.99, q_len,'b');
xlabel('降温速率');
ylabel('最短距离');
title('退火算法关于降温速率的灵敏度分析');

%% L
l_len = zeros(150,1);
i = 1;
for l = 1:2:300
    l_len(i) = SA_TSP_len(X, T0, Tend, l, q);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(1:2:300, l_len,'b');
xlabel('恒温迭代次数');
ylabel('最短距离');
title('退火算法关于恒温迭代次数的灵敏度分析');