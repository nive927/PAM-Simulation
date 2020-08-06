function [y MSE]=NADelta_Modulation()
%del=step size
%y=output binary sequence

Vwind=12;              % wind speed at 19.4 m
dw=0.01;                % the difference between successive frequencies
w=0.01:dw:4;            % angular frequencies
t=1:1:500;         % simulation time
x=0;
N=length(t);
el=zeros(1,N);
%S=waveSpectrum(Vwind,w);
g=9.81; 
A=8.1e-3*g^2; 
B=0.74*(g/Vwind)^4; 
S=A*w.^(-5).*exp(-B./(w.^4));
figure;
plot(S);
xlabel('frequency [rad/s]');
ylabel('wave spectrum [m^2/s]');
grid on;

%t=0:2*pi/100:2*pi;
t=0:1:100;
x=S*5;
plot(x)
hold on
y=[0];
xr=0;
del=0;
for i=1:length(x)-1
    if xr(i)<=x(i)
        d=1;
        del=x(i)-xr(i);
        xr(i+1)=xr(i)+del;
    else
        d=0;
        del=xr(i)-x(i);
        xr(i+1)=xr(i)-del; 
    end
    y=[y d];
    
end
stairs(xr)
hold off
%MSE=sum((x-xr).^2)/length(x);
%MSE;
end