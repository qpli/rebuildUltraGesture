clc
clear
barker= comm.BarkerCode('Length',13,'SamplesPerFrame',13);
 trainSeq1 = mapminmax(step(barker),-1,1);
% trainSeq =[1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];
trainSeq=(trainSeq1(:,1))';
trainSeq = [trainSeq trainSeq zeros(1,14)];
y2=trainSeq;

y1 = interp(y2, 12);
% fc=18500;
% fs=48000;
% t=0:1/fs:(length(y1)-1)/fs;
% y = sqrt(2)*cos(2*pi*fc*t);
% 
% y = 
plot(y1)
% b=zeros(1,168);
% y=[y1 b];
y=y1;
figure 
plot(y)

fs=48000;
yyy=repmat(y,1,2000);
fc = 19000;
t=0:1/fs:(length(yyy)-1)/fs;
% t=t(1:end-1);
y = sqrt(2)*yyy.*cos(2*pi*fc*t);

n=13;
Wn=[17000/(fs/2) 21000/(fs/2)] %设计Butterworth低通滤波器
[a,b]=butter(n,Wn);
y1=y';
ss= filter(a,b,y1);

ss=mapminmax(ss',-1,1);
[ mr ] = plot_fft( ss,fs,'r' );

%获取扬声器麦克风ID
info=audiodevinfo;
xmax=1.3;
%%
%%超声波发射频率的设置

t=3;
% buffersize = fs*t;%44100/s    播放时长的设定
% volume = 0.1;   %音量大小的设定
% out_channels = 1;  
t_signal = ss;
playwav1=t_signal;  %
%  audiowrite('send_single.mat',playwav1,fs);
%  save Ultrasonic playwav1 fs;
 %%
 %fs=44100;
% [send_single,fs]=audioread('Ultrasonic.mat');
player = audioplayer(playwav1,48000,16);%创建播放对象
R = audiorecorder( fs, 16 ,2) ;%创建录制对象  只有一个麦克风的数据
audiowrite('rebuildultragesture.wav',t_signal,fs);
for i=1:5
  
fprintf('第 %d 次数据收集完成，暂停1秒收集下次数据\n',i);
cou=0;
play(player); 
pause(1)
recordblocking(R,t);
myRecording = getaudiodata(R);
pause(0.1)
stop(R)
pause(0.1)
stop(player)    
pause(0.1)
result{i} = myRecording'; 

end
