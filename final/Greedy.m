function Greedy(X)

n = size(X,1);
D = Distanse(X);
Shortest_Length = 50000;
S = zeros(n,1);
for i =1:n 
    Stmp = zeros(n,1);
    Stmp(1) = i;
    tmp_len = 0;
    for j = 2:n 
        allow_index = ~ismember(1:n,Stmp);
        len = 100;
        for k = 1:n
            if allow_index(k) == 1 && D(Stmp(j-1), k) < len
                len = D(Stmp(j-1), k);
                idx = k;
            end
        end
        Stmp(j) = idx;
        tmp_len = tmp_len + len;
    end
    tmp_len = tmp_len + D(Stmp(1), Stmp(end));
    if tmp_len < Shortest_Length
        Shortest_Length = tmp_len;
        S = Stmp;
    end
end


%% 输出最优解的路线和总距离
disp( 'Greedy_solution:');
OutputPath(S);
disp(['Total Distance: ', num2str(Shortest_Length)]);
disp('----------------------------------------');

%% 最优解的路径图
DrawPath(S, X, '朴素贪心');
