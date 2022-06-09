function Len = ACA_TSP_len(X, m, alpha, beta, rho, Q, iter_max)

%% 计算城市间相互距离
n = size(X,1);
D = Distanse(X);
Eta = 1./D;                         % 启发函数
Tau = ones(n,n);                    % 信息素矩阵
Table = zeros(m,n);                 % 路径记录表      
Length_best = zeros(iter_max,1);    % 各代最佳路径的长度  

%% 迭代寻找最佳路径
for iter = 1 : iter_max
    % 随机产生各个蚂蚁的起点城市
    start = zeros(m,1);
    for i = 1:m
        temp = randperm(n);
        start(i) = temp(1);
    end
    Table(:,1) = start; 
    % 构建解空间
    X_index = 1:n;
    % 逐个蚂蚁路径选择
    for i = 1:m
        % 逐个城市路径选择
        for j = 2:n
            tabu = Table(i,1:(j - 1));           % 已访问的城市集合(禁忌表)
            allow_index = ~ismember(X_index,tabu);
            allow = X_index(allow_index);  % 待访问的城市集合
            P = allow;
            % 计算城市间转移概率
            for k = 1:length(allow)
                P(k) = Tau(tabu(end),allow(k))^alpha * Eta(tabu(end),allow(k))^beta;
            end
            P = P/sum(P);
            % 轮盘赌法选择下一个访问城市
            Pc = cumsum(P);     
            target_index = find(Pc >= rand); 
            target = allow(target_index(1));
            Table(i,j) = target;
        end
    end
    % 计算各个蚂蚁的路径距离
    Length = zeros(m,1);
    for i = 1:m
        Route = Table(i,:);
        Length(i) = PathLength(D, Route);
    end
    % 计算最短路径距离
    [min_Length,~] = min(Length);
    if iter == 1
        Length_best(iter) = min_Length;  
    else
        Length_best(iter) = min(Length_best(iter - 1),min_Length);
    end
    % 更新信息素
    Delta_Tau = zeros(n,n);
    % 逐个蚂蚁计算
    for i = 1:m
        % 逐个城市计算
        for j = 1:(n - 1)
            Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);
        end
        Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);
    end
    Tau = (1-rho) * Tau + Delta_Tau;
    % 迭代次数加1，清空路径记录表
    Table = zeros(m,n);
end
Len = Length_best(end);
