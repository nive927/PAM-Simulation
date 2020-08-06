function [S] = waveSpectrum(Vwind,w) % Vwind is the wind speed at height 19.4 m 
% w is the list of angular frequencies, for example: w=0.01:0.01:4. 
g=9.81; 
A=8.1e-3*g^2; 
B=0.74*(g/Vwind)^4; 
S=A*w.^(-5).*exp(-B./(w.^4)); 
end 