function GA_TSP(X, NIND, gen_max, Pc, Pm, GGAP)

D = Distanse(X);  % 生成距离矩阵
N = size(D,1);    

%% 初始化种群
Chrom = InitPop(NIND, N);
Length_best = zeros(gen_max,1);  

%% 迭代寻找最佳路径
for gen = 1 : gen_max
    % 计算适应度
    ObjV = PathLength(D,Chrom);  % 计算路线长度
    Length_best(gen) = min(ObjV);
    FitnV = Fitness(ObjV);
    
    SelCh = Select(Chrom,FitnV,GGAP);   % 选择 
    
    SelCh = Recombin(SelCh,Pc);         % 交叉操作
    
    SelCh = Mutate(SelCh,Pm);           % 变异
    
    SelCh = Reverse(SelCh,D);           % 逆转

    % 重插入子代的新种群
    Chrom = Reins(Chrom,SelCh,ObjV);
end

%% 画出最优解的路线图
ObjV = PathLength(D,Chrom);  %计算路线长度
[~, minInd] = min(ObjV);
DrawPath(Chrom(minInd,:), X, '遗传算法');

%% 输出最优解的路线和总距离
disp('GA_Solution:');
OutputPath(Chrom(minInd,:));
disp(['Total Distance: ',num2str(Length_best(end))]);
disp('----------------------------------------');

%% 优化过程迭代图
figure;
plot(1: gen_max, Length_best,'b');
xlabel('迭代次数');
ylabel('最优值');
title('遗传算法 优化过程');
