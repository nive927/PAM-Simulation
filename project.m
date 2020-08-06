%FIXING FREQUENCY OF CARRIER AND MESSAGE SIGNAL
clc;

fc=input('Enter carrier signal frequency (in Hz): ');
fs=input('Enter sampling frequency       (in Hz): ');   %sampling frequency
t_bound=0.5;

%Creation of a Vector of Sampling Instants (Step Size of 1/fs)

samples=0:1/fs:t_bound;
samples= samples(1:end-1); %To have exactly 500 samples

%GENERATION OF SQUARE WAVE

duty = 20;
pulse = square(2*pi*fc*samples,duty);
pulse(pulse<0) = 0;
%plot(samples, pulse)

%MESSAGE SIGNAL
type=input('Type of message signal:\n    1. Sine\n    2. Cosine\n    3. Sine+Cosine\n    4. Square\n    5. Sawtooth\n    6. Heaviside\n    7. Exponential\n    8. Random analog signal\n    9. Random digital signal\nEnter type: ');

if type==3
    fm1=input('Enter message signal frequency (in Hz):\n    Sine component  : ');
    fm2=input('    Cosine component: ');
elseif type==8 || type==9
else
    fm=input('Enter message signal frequency (in Hz): ');
end   
    
switch(type)
    case 1
        m=sin(2*pi*fm*samples);
    case 2
        m=cos(2*pi*fm*samples);
    case 3
        m=sin(2*pi*fm1*samples)+cos(2*pi*fm2*samples);
    case 4
        m=square(2*pi*fm*samples);
    case 5
        m=sawtooth(2*pi*fm*samples);
    case 6
        m=heaviside(2*pi*fm*samples);
    case 7
        m=exp(2*pi*fm*samples);
    case 8
        m=rand(1,length(samples));
    case 9
        m=randi([0 1],1,length(samples));
    otherwise
        m=sin(2*pi*fm*samples);
end

%plot(samples, m)

%PAM WAVE
period_samp = floor(2*length(samples)/fc);         %No. of samples in each pulse duration
indices = 1:period_samp:length(samples);    %First sample in each pulse duration
on_samp = ceil(period_samp * duty/100);     %No. of samples during positive cycle
pam = zeros(1,length(samples)); %Setting it to 0
uni_pam= pam;
for i=1:length(indices)
    if indices(i) + on_samp<=length(samples)
        pam(indices(i):indices(i) + on_samp) = m(indices(i));
    end
end

for i=1:length(samples)
   uni_pam(i)= abs(pam(i));
end







%plot(samples, pam)
%hold
%plot(samples, m)

%FINAL OUTPUT
subplot(4,1,1);
plot(samples,pulse,'r');
title('CARRIER SIGNAL');
xlabel({'Frequency','(in Hertz)'});
ylabel('Amplitude');


subplot(4,1,2);
plot(samples,m,'b');
title('MESSAGE SIGNAL');
xlabel({'Frequency','(in Hertz)'});
ylabel('Amplitude');

subplot(4,1,3);
plot(samples,uni_pam,'g');
title('UNIPOLAR PULSE AMPLITUDE MODULATED SIGNAL');
xlabel({'Frequency','(in Hertz)'});
ylabel('Amplitude');

subplot(4,1,4);
plot(samples,pam,'m');
title('BIPOLAR PULSE AMPLITUDE MODULATED SIGNAL');
xlabel({'Frequency','(in Hertz)'});
ylabel('Amplitude');
clc;