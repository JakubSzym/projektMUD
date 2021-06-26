%Skrypt rysuje charakterystyki statyczne
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
a=15;
b=15;
h_wew=4;
h_p=2;
V_wew=a*b*h_wew;
V_p=(a*b*h_p)/3;
Cvw = c_p*ro_p*V_wew;
Cvp = c_p*ro_p*V_p;
%Obliczenie wspolczynnikow przenikalnosci;
Kw=(qgN-c_p*ro_p*fpN*TwewN+c_p*ro_p*fpN*TpN)/(TwewN-TzewN);
Kp=(c_p*ro_p*fpN*(TwewN-TpN))/(TpN-TzewN);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qg=0:100:2000;
Tzew=-10:1:10;
fp=0:.1:20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%wykresy Twew(qg) i Tp(qg);
Tp =(c_p*ro_p*fpN*qg)/(c_p*ro_p*fpN*(Kp+Kw)+Kw*Kp)+TzewN;
Twew = (c_p*ro_p*fpN*Tp+Kp*Tp-Kp*TzewN)/(c_p*ro_p*fpN);
subplot(321);
hold on;
grid on;
xlabel('q_{g} [W]','FontSize',14);
ylabel('T_{wew} [^{\circ}C]','FontSize',14);
title('Charakteystyka statyczna T_{wew}(q_{g})','FontSize',18);
plot(qg,Twew);
plot(qgN,TwewN, 'r.', 'Markersize',25);
legend("T_{wew}","Punkt nominalny", 'Location','SouthEast','FontSize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(322);
hold on;
grid on;
xlabel('q_{g}[W]','FontSize',14);
ylabel('T_{p}[^{\circ}C]','FontSize',14);
title('Charakterystyka statyczna T_{p}(q_{g})','FontSize',18);
plot(qg,Tp);
plot(qgN,TpN,'r.', 'Markersize',25);
legend("T_{p}","Punkt nominalny", 'Location','SouthEast','FontSize',14);

%wykresy Twew(fp) i Tp(fp)
Tp =(c_p*ro_p*fp*qgN)./(c_p*ro_p*fp*(Kp+Kw)+Kw*Kp)+TzewN;
Twew = (c_p*ro_p*fp.*Tp+Kp*Tp-Kp*TzewN)./(c_p*ro_p*fp);
subplot(323);
hold on;
grid on;
xlabel('f_{p}[m^3/s]','FontSize',14);
ylabel('T_{wew} [^{\circ}C]','FontSize',14);
title('Charakteystyka statyczna T_{wew}(f_{p})', 'FontSize', 18);
plot(fp,Twew);
plot(fpN,TwewN, 'r.', 'Markersize',25);
legend("T_{wew}","Punkt nominalny", 'Location','SouthEast','FontSize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(324);
hold on;
grid on;
xlabel('f_{p}[m^3/s]','FontSize',14);
ylabel('T_{p}[^{\circ}C]','FontSize',14);
title('Charakterystyka statyczna T_{p}(f_{p})', 'FontSize', 18);
plot(fp,Tp);
plot(fpN,TpN,'r.', 'Markersize',25);
legend("T_{p}","Punkt nominalny", 'Location','SouthEast','FontSize',14);

%wykresy Twew(Tzew) i Tp(Tzew)
Tp =(c_p*ro_p*fpN*qgN)/(c_p*ro_p*fpN*(Kp+Kw)+Kw*Kp)+Tzew;
Twew = (c_p*ro_p*fpN*Tp+Kp*Tp-Kp*Tzew)/(c_p*ro_p*fpN);
subplot(325);
hold on;
grid on;
xlabel('T_{zew}[^{\circ}C]','FontSize',14);
ylabel('T_{wew} [^{\circ}C]','FontSize',14);
title('Charakteystyka statyczna T_{wew}(T_{zew})', 'FontSize',18);
plot(Tzew,Twew);
plot(TzewN,TwewN, 'r.', 'Markersize',25);
legend("T_{wew}","Punkt nominalny", 'Location','SouthEast','FontSize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(326);
hold on;
grid on;
xlabel('T_{zew}[^{\circ}C]','FontSize',14);
ylabel('T_{p}[^{\circ}C]','FontSize',14);
title('Charakterystyka statyczna T_{p}(T_{zew})', 'FontSize',18);
plot(Tzew,Tp);
plot(TzewN,TpN,'r.', 'Markersize',25);
legend("T_{p}","Punkt nominalny", 'Location','SouthEast','FontSize',14);