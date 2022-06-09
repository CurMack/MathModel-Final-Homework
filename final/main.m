%% 导入数据
clear; clc;
% load CityPosition2.mat
X = RandomCity(69);

%% 随机解
D = Distanse(X);  
N = size(D,1); 
RandSol = randperm(N); 
% 画出随机解的路线图
DrawPath(RandSol, X, '随机生成');
% 随机解的路径图
disp('rand_solution: ')
OutputPath(RandSol);
Rlength = PathLength(D,RandSol);
disp(['Total Distance: ',num2str(Rlength)]);
disp('----------------------------------------');

%% 简单贪心
Greedy(X);

%% 模拟退火算法
% 初始化参数
T0 = 1000;                      % 初始温度
Tend = 1e-3;                    % 终止温度
L = 400;                        % 各温度下的迭代次数
q = 0.96;                       % 降温速率

SA_TSP(X, T0, Tend, L, q);

%% 遗传算法
% 初始化参数
NIND = 300;                     % 种群大小
MAXGEN = 700;                   % 迭代次数
Pc = 0.6;                       % 交叉概率
Pm = 0.05;                      % 变异概率
GGAP = 0.85;                    % 代沟(Generation gap)

GA_TSP(X, NIND, MAXGEN, Pc, Pm, GGAP);

%% 蚁群算法
% 初始化参数
m = 80;                         % 蚂蚁数量
alpha = 0.8;                      % 信息素重要程度因子
beta = 3;                       % 启发函数重要程度因子
rho = 0.1;                      % 信息素挥发因子
Q = 1;                          % 常系数
iter_max = 280;                 % 最大迭代次数 

ACA_TSP(X, m, alpha, beta, rho, Q, iter_max);