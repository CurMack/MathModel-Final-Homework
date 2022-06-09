clear; clc;
% 导入数据
% load CityPosition2.mat
X = RandomCity(100);
%%
% GA_TSP_len(X, NIND, gen_max, Pc, Pm, GGAP)
% 参数列表
% NIND       种群大小
% gen_max    迭代次数
% Pc         交叉概率
% Pm         变异概率
% GGAP       代沟
% 默认参数
NIND = 50;  
gen_max = 250;  
Pc = 0.4; 
Pm = 0.05;  
GGAP = 0.85; 

%% NIND 种群大小(2:50)
NIND_len = zeros(49,1);
for n = 2:50
    NIND_len(n-1) = GA_TSP_len(X, n, gen_max, Pc, Pm, GGAP);
end
% 种群大小灵敏度图
figure;
plot(2:50, NIND_len,'b');
xlabel('种群大小');
ylabel('最短距离');
title('遗传算法关于种群大小的灵敏度分析');

%% gen_max 迭代次数(1:300)
gen_len = zeros(300,1);
for g = 1:300
    gen_len(g) = GA_TSP_len(X, NIND, g, Pc, Pm, GGAP);
end
% 迭代次数灵敏度图
figure;
plot(1:300, gen_len,'b');
xlabel('迭代次数');
ylabel('最短距离');
title('遗传算法关于迭代次数的灵敏度分析');

%% Pc 交叉概率
pc_len = zeros(101,1);
i = 1;
for p = 0:0.01:1
    pc_len(i) = GA_TSP_len(X, NIND, gen_max, p, Pm, GGAP);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(0:0.01:1, pc_len,'b');
xlabel('交叉概率');
ylabel('最短距离');
title('遗传算法关于交叉概率的灵敏度分析');

%% Pc 变异概率
pm_len = zeros(101,1);
i = 1;
for p = 0:0.01:1
    pm_len(i) = GA_TSP_len(X, NIND, gen_max, Pc, p, GGAP);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(0:0.01:1, pm_len,'b');
xlabel('变异概率');
ylabel('最短距离');
title('遗传算法关于变异概率的灵敏度分析');

%% GGAP 代沟
gap_len = zeros(101,1);
i = 1;
for p = 0:0.01:1
    gap_len(i) = GA_TSP_len(X, NIND, gen_max, Pc, Pm, p);
    i = i+1;
end
% 迭代次数灵敏度图
figure;
plot(0:0.01:1, gap_len,'b');
xlabel('代沟');
ylabel('最短距离');
title('遗传算法关于代沟的灵敏度分析');
