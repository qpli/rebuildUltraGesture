function [ y ] = LS_es( x,P,L,tr)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
% x=I_low;

%x为接收信号
% x=I_low;
% tr=yyy;
%对x进行处理，去掉没有收到声音的部分
for i=1:length(x)
    if(abs(x(i))>0.0001)
        x=x(i:end);
        break
    end
end

%对接收信号x分帧
cou=1;
for i=1:L+P:length(x)-(L+P)
%     fprintf('i %d\n',i)
    x1(cou,:) = x(i:i+480-1);
    cou=cou+1;
end


%tr为发射信号
tr=tr(1:length(x));
cou=1;
for i=1:L+P:length(tr)-(L+P)
%     fprintf('i %d\n',i)
    tr1(cou,:) = tr(i:i+480-1);
    cou=cou+1;
end


% L=140;
% P=340;

%x2为发射信号，M为发射信号，将发射信号转为矩阵M
for k=1:size(x1,1)
    x2=tr1(k,:);
    cou=1;
    for i=1:length(x2)-L
        M{k}(cou,:) = x2(i:i+L-1);
        cou=cou+1;
%         fprintf('j: %d  j+L-1: %d\n',i,i+L-1);
    end
end

% tr=t_signal(L+1:P+L)';
% clear M1
% clear y
for i=1:length(M)
tr2=x1(i,L+1:L+P);
M1=fliplr(M{i});
% M1=M{i};
y(i,:)=(inv(M1'*M1))*M1'*tr2';
end


end

