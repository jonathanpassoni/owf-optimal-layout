clear all, close all, clc

%GA for the optimization of the layout of an offshore wind farm

%% Parameters
NoT = 32; %nb of turbines
P = 3050; %Nominal power of 1 turbine
d = 101; % rotor diameter
dair = 1.225;
%The distance between 2 cells in the grid is equal to 5*d

%% Data Turbine Model Enercon E-101 3050MW
% Wind speed [m/s]
w = [ 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
% Rotor Power Coefficient [without unit]
Cp = [ 0.076 0.279 0.376 0.421 0.452 0.469 0.478 0.478 0.477 0.439 0.358 0.283 0.227 0.184 0.152 0.127 0.107 0.091 0.078 0.067 0.058 0.051 0.045 0.04];
% Power [KW]
Power = [ 3 37 118 258 479 790 1200 1710 2340 2867 3034 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050];
% Evaluation of Ct [without unit]
Ct=[];
a=[];
for k=1:1:24
    % Relation between Cp and Ct (Equation 17)
    p = [4 -8 4 -Cp(k)];
    rootp = roots(p)';
    available_root = [];
    for i=1:1:3
        if (real((rootp(i)) >0) & real((rootp(i))<0.5))
            available_root = [available_root real(rootp(i))];
        end
    end
    a = [a max(available_root)];
    Ct = [Ct Cp(k)/(1- max(available_root))];
end

%spline interpolation
ct_int = fit(w',Ct', 'cubicinterp') ; 
power_int = fit([0;w'], [0;Power'], 'cubicinterp');
a_int = fit(w', a', 'cubicinterp') ;
plot(a_int(0:0.1:25),'.-k') 

%grd1 = reshape(x, [8 8])';
grd1 = [1 1 1 1 1 0 1 0; 0 0 0 0 0 0 0 1; 0 0 0 1 0 1 0 0; 0 0 0 0 0 0 1 0;1 0 1 0 0 1 0 0; 0 1 1 0 1 0 1 1;1 1 0 1 1 1 0 1; 1 1 1 1 1 1 1 1];
%grd1 = [1 1 1 1 1 1 1 1; 0 0 0 0 0 0 0 0; 1 0 1 0 0 0 0 0; 0 0 0 0 1 1 0 1; 1 1 1 0 0 0 1 1; 1 1 0 1 1 1 0 1; 0 1 1 1 0 0 1 0; 0 0 0 1 1 1 1 0];
new_vento = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
new_prob = [0 0.003 0.005 0.018 0.043 0.068 0.073 0.050 0.045 0.045 0.058 0.065 0.080 0.030 0.048 0.053 0.020 0.023 0.018 0.040 0.025 0.018 0.035 0.055 0.073];

d = 101;
EfPot = [];
EffAv = 0;
PowerAv = 0;
sumprob = sum(new_prob);
WakeEffect = WakeEffectCombined(grd1,d);
for k = 1:1:length(new_prob)
    Uf = new_vento(k);
    ws = speed(grd1, Uf, ct_int,WakeEffect);
    Pwf = SumPower(ws,d,dair,a_int);
    PowerAv = PowerAv + Pwf*(new_prob(k)/sumprob); 
    Eff = Pwf/(3050*NoT); %Si: KW; %EQN 22 article 1
    EfPot = [EfPot Eff];
    EffAv = EffAv  + Eff*(new_prob(k)/sumprob);
end