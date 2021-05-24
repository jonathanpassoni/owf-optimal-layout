clear all
close all

%% Grid data
%Grid given by the Genetic Algorithm Optimisation
addpath('./Optimization - Genetic Algorithm/')
binary_grid = [1 1 0 0 1 1 1 1; 0 0 1 1 1 0 0 1; 0 0 0 0 0 1 0 0; ...
    1 1 0 0 0 1 0 0; 0 0 1 1 0 0 1 0; 0 0 1 1 0 0 1 0; ...
    1 1 0 0 1 0 1 1; 1 1 1 1 1 1 0 1];
%Grid given by the MOPSO
%addpath('./Optimization - MOPSO/')
% binary_grid = [1 1 1 1 1 1 1 1; 1 1 0 0 1 1 0 0; 0 0 1 0 0 0 1 1; ...
% 0 0 0 0 0 0 0 0; 0 0 1 1 0 1 0 0; 0 0 0 0 0 0 0 0; 1 1 0 1 1 0 1 1; ...
%     1 1 1 1 1 1 1 1];

% Wind speed [m/s]
w = [ 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
%Probability for each wind speed
prob_data = [0.003 0.005 0.018 0.043 0.068 0.073 0.050 0.045 0.045 0.058 0.065 0.080 0.030 0.048 0.053 0.020 0.023 0.018 0.040 0.025 0.018 0.035 0.055 0.073];
% Rotor Power Coefficient [without unit]
Cp = [ 0.076 0.279 0.376 0.421 0.452 0.469 0.478 0.478 0.477 0.439 0.358 0.283 0.227 0.184 0.152 0.127 0.107 0.091 0.078 0.067 0.058 0.051 0.045 0.04];
% Power [KW]
Power = [ 3 37 118 258 479 790 1200 1710 2340 2867 3034 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050];

k_wake = 0.04; %wake decay constant
%% Ct evaluation
Ct=[];
a = [];
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
a_int = fit(w', a', 'cubicinterp') ;
power_int = fit([0;w'], [0;Power'], 'cubicinterp');