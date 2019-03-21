% clc
% clear 
% load('data.mat');

sr = data(:,2)';
t=0:1/fs:(length(sr)-1)/fs;
I=sr*sqrt(2).*cos(2*pi*fc*t);
Q=-sr*sqrt(2).*sin(2*pi*fc*t);

% [ mr ] = plot_fft( Q_tr,fs,'r' );

n=13;
Wn=[2500/(fs/2)] %Éè¼ÆButterworthµÍÍ¨ÂË²¨Æ÷
[a,b]=butter(n,Wn);
I_low= filter(a,b,I);
Q_low=filter(a,b,Q);
[ mr ] = plot_fft( I_low,fs,'r' );

% t=0:1/fs:(length(sr)-1)/fs;
% tr=t_signal(1:length(sr));
% I_tr=tr*sqrt(2).*cos(2*pi*fc*t);
% Q_tr=-tr*sqrt(2).*sin(2*pi*fc*t);

% I_tr_low= filter(a,b,I_tr);
% Q_tr_low=filter(a,b,Q_tr);
% [ mr ] = plot_fft( I_tr_low,fs,'r' );

L=140;
P=340;
tr=yyy;
% y_ls  = LS_es( I_low,P,L,tr);
y_ls  = LS_es( I_low+j*Q_low,P,L,tr);
% y_ls=flipud(y_ls);
imagesc((abs(y_ls)'))
figure
for i=2:size(y_ls,1)
    y_d(i,:) =y_ls(i,:)-y_ls(i-1,:); 
end
image(abs(y_d'));
% w=gausswin(40);


gus_filter=fspecial('gaussian',[1 40],5);
for i=1:size(y_d,1)
y_gus(i,:)=imfilter(y_d(i,:),gus_filter,'conv');
% y_gus(i,:)=Gaussianfilter(40, 5, y_d(i,:));
% y_gus(i,:)=filter( w,5,y_d(i,:));
end
figure
imagesc((abs(y_gus))')
% y_gus=imfilter(y_d,gus_filter,'conv');
% 
% figure
% imagesc(abs(y_gus)')
% y_gus = imgaussfilt(y_d,5,'FilterSize',41);
yy_gus=y_gus;
for i=1:size(y_gus,1)
    for j=1:size(y_gus,2)
        if(abs(y_gus(i,j))<0.09)
            yy_gus(i,j)=0;
        end
    end
end

figure
% clims = [min(min(abs(y_d))) max(max(abs(y_d)))];
im=imagesc(abs(yy_gus)')
% im.AlphaData=20^100;
colorbar
% imagesc(abs(yy_gus)')




