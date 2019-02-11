clc
close all;
clear all;
n=input('Enter the number of bits ');
n1=input('Enter the number of samples ');
l=2^n;
x=0:0.01:2*pi;
y=8*sin(x);
subplot(2,1,1)
plot(x,y);
title('Actual Signal');
grid on
x=0:pi/n1:2*pi;
s=8*sin(x);
subplot(2,1,2);
stem(x,s);
title('Sampled Signal');
grid on;

%Quantization
figure;
vmax=8;
vmin=-vmax;
del=(vmax-vmin)/l;
part=vmin:del:vmax;
code=vmin-(del/2):del:vmax+(del/2);
[ind,q]=quantiz(s,part,code);
plot(x,s,'-',x,q,'.');
title('Quantized Signal');
grid on

%Encoding
figure;
l1=length(ind);
l2=length(q);
code=de2bi(ind,'left-msb');             % Cnvert the decimal to binary
 k=1;
for i=1:l1
    for j=1:n
        coded(k)=code(i,j);                  % convert code matrix to a coded row vector
        j=j+1;
        k=k+1;
    end
    i=i+1;
end
subplot(2,1,1)
stairs(coded); 
title('Modulated Signal');
axis([0 100 -2 3]);

%Demodulation

 qunt=reshape(coded,n,length(coded)/n);
 index=bi2de(qunt','left-msb');                    
 q=del*index+vmin+(del/2);                       
 subplot(2,1,2); grid on;
 plot(q);  
 grid on;
 title('Demodulated Signal');
