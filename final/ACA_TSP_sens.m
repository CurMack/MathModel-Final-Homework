clear; clc;
% 导入数据
% load CityPosition2.mat
X = RandomCity(50);
%%
% ACA_TSP_len(X, m, alpha, beta, rho, Q, iter_max)
% 初始化参数
m = 50;                         % 蚂蚁数量
alpha = 1;                      % 信息素重要程度因子
beta = 3;                       % 启发函数重要程度因子
rho = 0.1;                      % 信息素挥发因子
Q = 1;                          % 蚂蚁信息素量
iter_max = 150;                 % 最大迭代次数 

%% M 蚂蚁数量
m_len = zeros(100,1);
i = 1;
for mt = 1:100
    m_len(i) = ACA_TSP_len(X, mt, alpha, beta, rho, Q, iter_max);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(1:100, m_len,'b');
xlabel('蚂蚁数量');
ylabel('最短距离');
title('蚁群算法关于蚂蚁数量的灵敏度分析');

%% Q 常系数
q_len = zeros(100,1);
i = 1;
for qt = 0.1:0.1:10
    q_len(i) = ACA_TSP_len(X, m, alpha, beta, rho, qt, iter_max);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(0.1:0.1:10, q_len,'b');
xlabel('蚂蚁信息素量');
ylabel('最短距离');
title('蚁群算法关于蚂蚁信息素量的灵敏度分析');

%% alpha 信息素重要程度因子
alpha_len = zeros(101,1);
i = 1;
for a = 0: 0.1:10
    alpha_len(i) = ACA_TSP_len(X, m, a, beta, rho, Q, iter_max);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(0:0.1:10, alpha_len,'b');
xlabel('信息素重要程度');
ylabel('最短距离');
title('蚁群算法关于信息素重要程度因子的灵敏度分析');

%% beta 启发函数重要程度因子
beta_len = zeros(101,1);
i = 1;
for b = 0: 0.1:10
    beta_len(i) = ACA_TSP_len(X, m, alpha, b, rho, Q, iter_max);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(0:0.1:10, beta_len,'b');
xlabel('启发函数重要程度');
ylabel('最短距离');
title('蚁群算法关于启发函数重要程度的灵敏度分析');

%% rho 信息素挥发因子
rho_len = zeros(100,1);
i = 1;
for r = 0: 0.01: 0.99
    rho_len(i) = ACA_TSP_len(X, m, alpha, beta, r, Q, iter_max);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(0: 0.01: 0.99, rho_len,'b');
xlabel('信息素挥发因子');
ylabel('最短距离');
title('蚁群算法关于信息素挥发因子的灵敏度分析');