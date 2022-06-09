function SA_TSP(X, T0, Tend, L, q)

D = Distanse(X);  %����������
N = size(D,1);    %���еĸ���

%% ��ʼ��
S1 = randperm(N);  %�������һ����ʼ·��
L0 = PathLength(D, S1);

%% ��������Ĵ���
syms x;
Time = ceil(double(solve(1000*(q)^x == Tend, x)));
cnt = 0;        %��������
Length_best = zeros(Time,1);         %Ŀ��ֵ�����ʼ��
S = zeros(1,N);       %ÿ��������·�߾����ʼ��
%% ����
while T0 > Tend
    cnt = cnt+1;     %���µ�������
    temp = zeros(L,N+1);
    for k = 1:L
        % �����½�
        tmp = randperm(2);
        if tmp(1) == 1
            S2 = Mutate(S1,1);
        else 
            S2 = Reverse(S1,D);
        end
        % Metropolis�����ж��Ƿ�����½�
        [S1,R] = Metropolis(S1,S2,D,T0);  % Metropolis �����㷨
        temp(k,:) = [S1 R];          %��¼��һ·�ߵļ���·��
    end

    % ��¼ÿ�ε������̵�����·��
    [d0,index] = min(temp(:, end)); %�ҳ���ǰ�¶�������·��
    if cnt == 1 || d0 < Length_best(cnt-1)
        Length_best(cnt) = d0;           % �����ǰ�¶�������·��С����һ·�����¼��ǰ·��
    else
        Length_best(cnt) = Length_best(cnt-1);% �����ǰ�¶�������·�̴�����һ·�����¼��һ·��
    end
    S = temp(index, 1:end-1);  % ��¼��ǰ�¶ȵ�����·��

    T0 = q*T0;     % ����
end


%% ������Ž��·�ߺ��ܾ���
disp('SA_solution:')
OutputPath(S);
disp(['total distance: ',num2str(PathLength(D,S))]);
disp('----------------------------------------')

%% ���Ž��·��ͼ
DrawPath(S,X, 'ģ���˻��㷨')

%% �Ż����̵���ͼ
figure;
plot(1:cnt,Length_best);
xlabel('��������');
ylabel('����ֵ');
title('ģ���˻��㷨 �Ż�����');
axis([0 250 0.85*PathLength(D,S) L0-3]);




