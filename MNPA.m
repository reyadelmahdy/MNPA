% clc; clear all; close all
%% ELEC4700 PA7
% Reyad ElMahdy 101064879

%2 a)
% Assigning all the circuit parameters

R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
RO = 1000;
C = 0.25;
L = 0.2;
a = 100;

% Creating the G and C matrices

G = zeros(6,6);
Cmat = zeros(6,6);

G(1,1) = 1;
G(2,1) = -1/R1;
G(2,2) = 1/R2 +1/R1;
G(3,3) = 1/R3;
G(3,6) = -1;
G(4,3) = -a/R3;
G(4,4) = 1;
G(5,4) = -1/R4;
G(5,5) = 1/R4 + 1/RO;
G(6,2) = -1;
G(6,3) = 1;

Cmat(2,1) = -C;
Cmat(2,2) = C;
Cmat(6,6) = L;

%2 b)
V3 = [];
Vo = [];
for i = -10:1:10
    F = [i; 0; 0; 0; 0; 0];
    temp = G\F;
    V3 = [V3 temp(3)];
    Vo = [Vo temp(5)];
end
figure (1)
hold on
title('DC voltage sweep')
plot(-10:1:10,V3)
plot(-10:1:10,Vo)
legend('V3','Vo');
hold off

%c)

F = [1; 0; 0; 0; 0; 0];
Vo = [];
gain = [];
for i = 0:1:100
    temp = (G + 1j*i*C)\F;
    Vo = [Vo temp(5)];
    tempdb = 20*log(temp);
    gain = [gain tempdb];
end
w = 0:1:100;
figure(3)
hold on
title('AC Voltage Sweep')
plot(w,Vo)
plot(w,gain)
legend('Vo (V)', 'Gain (dB)')
hold off

% c)

cap = [];
gain = [];

for i = 1:1:1000
    ranC = C + randn()*0.05;
    Cmat(2,:) = [-ranC, ranC, 0, 0, 0, 0];
    temp = (G+1j*pi*Cmat)\F;
    cap = [cap ranC];
    gain = [gain real(temp(5))];
end

figure(3)
plot(cap, gain);
title('Gain vs Random Capacitance')
xlabel('Capacitance')
ylabel('Gain (dB)')
figure(4)
histogram(cap)
title('Normally Distributed Capacitance Histogram')
xlabel('Capacitance')
ylabel('Number of Occurences')
figure(5)
histogram(gain)
title('Output Gain Histogram')
xlabel('Gain')
ylabel('Number of Occurences')