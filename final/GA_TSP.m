function GA_TSP(X, NIND, gen_max, Pc, Pm, GGAP)

D = Distanse(X);  % ���ɾ������
N = size(D,1);    

%% ��ʼ����Ⱥ
Chrom = InitPop(NIND, N);
Length_best = zeros(gen_max,1);  

%% ����Ѱ�����·��
for gen = 1 : gen_max
    % ������Ӧ��
    ObjV = PathLength(D,Chrom);  % ����·�߳���
    Length_best(gen) = min(ObjV);
    FitnV = Fitness(ObjV);
    
    SelCh = Select(Chrom,FitnV,GGAP);   % ѡ�� 
    
    SelCh = Recombin(SelCh,Pc);         % �������
    
    SelCh = Mutate(SelCh,Pm);           % ����
    
    SelCh = Reverse(SelCh,D);           % ��ת

    % �ز����Ӵ�������Ⱥ
    Chrom = Reins(Chrom,SelCh,ObjV);
end

%% �������Ž��·��ͼ
ObjV = PathLength(D,Chrom);  %����·�߳���
[~, minInd] = min(ObjV);
DrawPath(Chrom(minInd,:), X, '�Ŵ��㷨');

%% ������Ž��·�ߺ��ܾ���
disp('GA_Solution:');
OutputPath(Chrom(minInd,:));
disp(['Total Distance: ',num2str(Length_best(end))]);
disp('----------------------------------------');

%% �Ż����̵���ͼ
figure;
plot(1: gen_max, Length_best,'b');
xlabel('��������');
ylabel('����ֵ');
title('�Ŵ��㷨 �Ż�����');
