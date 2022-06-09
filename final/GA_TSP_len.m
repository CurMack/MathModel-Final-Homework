function Len = GA_TSP_len(X, NIND, gen_max, Pc, Pm, GGAP)
D = Distanse(X);  % 生成距离矩阵
N = size(D,1);    

%% 初始化种群
Chrom = InitPop(NIND, N); 

%% 迭代寻找最佳路径
for gen = 1 : gen_max
    % 计算适应度
    ObjV = PathLength(D,Chrom);  %计算路线长度
    FitnV = Fitness(ObjV);
    Len = min(ObjV);
    % 选择
    SelCh = Select(Chrom, FitnV, GGAP);
    % 交叉操作
    SelCh=Recombin(SelCh, Pc);
    % 变异
    SelCh=Mutate(SelCh, Pm);
    % 逆转操作
    SelCh=Reverse(SelCh, D);
    % 重插入子代的新种群
    Chrom=Reins(Chrom,SelCh, ObjV);
    % 更新迭代次数
end