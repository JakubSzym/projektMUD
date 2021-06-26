%Model state space
clear all;
clc;
%Dane nominalne:
TwewN=21;  
TpN=20;
TzewN=-2;
fpN=1;
qgN=1500;
%Parametry modelu:
c_p=1000;
ro_p=1.2;
a=10;
b=5;
h_wew=3;
h_p=3;
V_wew=a*b*h_wew;
V_p=(a*b*h_p)/3;
Cvw = c_p*ro_p*V_wew;
Cvp = c_p*ro_p*V_p;
%Obliczenie wspolczynnikow przenikalnosci;
Kw=(qgN-c_p*ro_p*fpN*TwewN+c_p*ro_p*fpN*TpN)/(TwewN-TzewN);
Kp=(c_p*ro_p*fpN*(TwewN-TpN))/(TpN-TzewN);
%Poczatkowe wartosci parametrow
Tzew1=TzewN;
qg1=qgN;
fp1=2;
%Macierze potrzebne do modelu state space
A = [(-c_p*ro_p*fp1-Kw)/Cvw, (c_p*ro_p*fp1)/Cvw; (c_p*ro_p*fp1)/Cvp, (-c_p*ro_p*fp1-Kp)/Cvp];
B = [1/Cvw, Kw/Cvw; 0, Kp/Cvp];
C = [1, 0; 0, 1];
D = [0, 0; 0, 0];


%Wartosci skoku
d_qg=0.1*qgN;
d_Tzew=0;
%Warunki poczatkowe
Tp0 =(c_p*ro_p*fp1*qg1)/(c_p*ro_p*fp1*(Kp+Kw)+Kw*Kp)+Tzew1;
Twew0 = (c_p*ro_p*fp1*Tp0+Kp*Tp0-Kp*Tzew1)/(c_p*ro_p*fp1);
Init = [Twew0;Tp0];
[ans1]=sim('miniprojekt_state_space',2.5*10^4);
Tzew1=TzewN+5;
qg1=0.5*qgN;
Tp0 =(c_p*ro_p*fp1*qg1)/(c_p*ro_p*fp1*(Kp+Kw)+Kw*Kp)+Tzew1;
Twew0 = (c_p*ro_p*fp1*Tp0+Kp*Tp0-Kp*Tzew1)/(c_p*ro_p*fp1);
Init = [Twew0;Tp0];
[ans2]=sim('miniprojekt_state_space',2.5*10^4);
figure(1);
subplot(121);
hold on;
grid on;
xlabel('czas[s]','FontSize',14);
ylabel('T_{wew}[^{\circ}C]','FontSize',14);
title('Skok o dq_{g}=0.1*q_{gN}','FontSize',18);
plot(ans1.Twew_state_space);
plot(ans2.Twew_state_space,'.','Markersize',8);
legend("PP1","PP2",'FontSize',14);
subplot(122);
hold on;
grid on;
xlabel('czas[s]','FontSize',14);
ylabel('T_{p}[^{\circ}C]','FontSize',14);
title('Skok o dq_{g}=0.1*q_{gN}','FontSize',18);
plot(ans1.Tp_state_space);
plot(ans2.Tp_state_space,'.','Markersize',8);
legend("PP1","PP2",'FontSize',14);

d_qg=0;
d_Tzew=2;
%Warunki i wartosci poczatkowe
Tzew1=TzewN;
qg1=qgN;
Tp0 =(c_p*ro_p*fp1*qg1)/(c_p*ro_p*fp1*(Kp+Kw)+Kw*Kp)+Tzew1;
Twew0 = (c_p*ro_p*fp1*Tp0+Kp*Tp0-Kp*Tzew1)/(c_p*ro_p*fp1);
Init = [Twew0;Tp0];
[ans1]=sim('miniprojekt_state_space',2.5*10^4);
Tzew1=TzewN+5;
qg1=0.5*qgN;
Tp0 =(c_p*ro_p*fp1*qg1)/(c_p*ro_p*fp1*(Kp+Kw)+Kw*Kp)+Tzew1;
Twew0 = (c_p*ro_p*fp1*Tp0+Kp*Tp0-Kp*Tzew1)/(c_p*ro_p*fp1);
Init = [Twew0;Tp0];
[ans2]=sim('miniprojekt_state_space',2.5*10^4);
figure(2);
subplot(121);
hold on;
grid on;
xlabel('czas[s]','FontSize',14);
ylabel('T_{wew}[^{\circ}C]','FontSize',14);
title('Skok o dT_{zew}=2','FontSize',18);
plot(ans1.Twew_state_space);
plot(ans2.Twew_state_space,'.','Markersize',8);
legend("PP1","PP2",'FontSize',14);
subplot(122);
hold on;
grid on;
xlabel('czas[s]','FontSize',14);
ylabel('T_{p}[^{\circ}C]','FontSize',14);
title('Skok o dT_{zew}=2','FontSize',18);
plot(ans1.Tp_state_space);
plot(ans2.Tp_state_space,'.','Markersize',8);
legend("PP1","PP2",'FontSize',14);


%Zmiana modelu state space na transmitancyjny
[L1,M1] = ss2tf(A,B,C,D,1);
[L2,M2] = ss2tf(A,B,C,D,2);

%Wartosci skoku
d_qg=0.1*qgN;
d_Tzew=0;
%Warunki i wartosci poczatkowe
Tzew1=TzewN;
qg1=qgN;
Tp0 =(c_p*ro_p*fp1*qg1)/(c_p*ro_p*fp1*(Kp+Kw)+Kw*Kp)+Tzew1;
Twew0 = (c_p*ro_p*fp1*Tp0+Kp*Tp0-Kp*Tzew1)/(c_p*ro_p*fp1);
[ans1]=sim('miniprojekt_transmitancja',2.5*10^4);
Tzew1=TzewN+5;
qg1=0.5*qgN;
Tp0 =(c_p*ro_p*fp1*qg1)/(c_p*ro_p*fp1*(Kp+Kw)+Kw*Kp)+Tzew1;
Twew0 = (c_p*ro_p*fp1*Tp0+Kp*Tp0-Kp*Tzew1)/(c_p*ro_p*fp1);
[ans2]=sim('miniprojekt_transmitancja',2.5*10^4);
figure(3);
subplot(121);
hold on;
grid on;
xlabel('czas[s]','FontSize',14);
ylabel('T_{wew}[^{\circ}C]','FontSize',14);
title('Skok o dq_{g}=0.1*q_{gN}','FontSize',18);
plot(ans1.Twew_transmitancja);
plot(ans2.Twew_transmitancja,'.','Markersize',8);
legend("PP1","PP2",'FontSize',14);
subplot(122);
hold on;
grid on;
xlabel('czas[s]','FontSize',14);
ylabel('T_{p}[^{\circ}C]','FontSize',14);
title('Skok o dq_{g}=0.1*q_{gN}','FontSize',18);
plot(ans1.Tp_transmitancja);
plot(ans2.Tp_transmitancja,'.','Markersize',8);
legend("PP1","PP2",'FontSize',14);

d_qg=0;
d_Tzew=2;
%Warunki i wartosci poczatkowe
Tzew1=TzewN;
qg1=qgN;
Tp0 =(c_p*ro_p*fp1*qg1)/(c_p*ro_p*fp1*(Kp+Kw)+Kw*Kp)+Tzew1;
Twew0 = (c_p*ro_p*fp1*Tp0+Kp*Tp0-Kp*Tzew1)/(c_p*ro_p*fp1);
[ans1]=sim('miniprojekt_transmitancja',2.5*10^4);
Tzew1=TzewN+5;
qg1=0.5*qgN;
Tp0 =(c_p*ro_p*fp1*qg1)/(c_p*ro_p*fp1*(Kp+Kw)+Kw*Kp)+Tzew1;
Twew0 = (c_p*ro_p*fp1*Tp0+Kp*Tp0-Kp*Tzew1)/(c_p*ro_p*fp1);
[ans2]=sim('miniprojekt_transmitancja',2.5*10^4);
figure(4);
subplot(121);
hold on;
grid on;
xlabel('czas[s]','FontSize',14);
ylabel('T_{wew}[^{\circ}C]','FontSize',14);
title('Skok o dT_{zew}=2','FontSize',18);
plot(ans1.Twew_transmitancja);
plot(ans2.Twew_transmitancja,'.','Markersize',8);
legend("PP1","PP2",'FontSize',14);
subplot(122);
hold on;
grid on;
xlabel('czas[s]','FontSize',14);
ylabel('T_{p}[^{\circ}C]','FontSize',14);
title('Skok o dT_{zew}=2','FontSize',18);
plot(ans1.Tp_transmitancja);
plot(ans2.Tp_transmitancja,'.','Markersize',8);
legend("PP1","PP2",'FontSize',14);