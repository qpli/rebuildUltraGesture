function [ mr ] = plot_fft( x,fs,co )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N=length(x);
% N=512;

f=(1:N).*fs/(N);
%f=fs/2*[-1:2/N:1-2/N];
%f=(-N:N)*fs/(2*N);
mr=abs(fft(x,N));


% 
% 
% tt=mr(1:N/2)*2/N;

 %plot(mr(1:N/2)*2/N,'r');
 plot(f(1:N/2),mr(1:N/2)*2/N,co)
%  xlim([16500 23500]);
%  ylim([-0.02 0.02])
%  hold on
%plot(f,mr,'b')
title('Ô­Ê¼ÐÅºÅÆµÆ×');


end

