function [y MSE]=Delta_Modulation(del,A)
%del=step size
%A=amplitude of signal
%y=output binary sequence
%Vary del value and check when MSE is least
%If you have any problem or feedback please contact me @
%%===============================================
%NIKESH BAJAJ
%Aligarh Muslim University
%+919915522564, bajaj.nikkey@gmail.com
%%===============================================

Vwind=12;              % wind speed at 19.4 m
dw=0.01;                % the difference between successive frequencies
w=0.01:dw:4;            % angular frequencies
t=0.1:0.02:500;         % simulation time
x=0;
N=length(t);
el=zeros(1,N);
S=waveSpectrum(Vwind,w);
figure;
plot(S);
xlabel('frequency [rad/s]');
ylabel('wave spectrum [m^2/s]');
grid on;

%t=0:2*pi/100:2*pi;
t=0:1:100;
x=A*S;
plot(x)
hold on
y=[0];
xr=0;
length(x)
for i=1:length(x)-1
    if xr(i)<=x(i)
        d=1;
        xr(i+1)=xr(i)+del;
    else
        d=0;
        xr(i+1)=xr(i)-del; 
    end
    y=[y d];
    
end
stairs(xr)
hold off
MSE=sum((x-xr).^2)/length(x);
MSE
end
    
