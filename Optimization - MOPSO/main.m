clear all, close all, clc

%MOPSO for the optimization of the layout of an offshore wind farm

%% Parameters
global NT P d dair winddata probdata sumprob ct_int a_int nvars nind
%we define all this data as persistent because the evaluation of the
%fitness function in the optimization algorithm uses the function "feval"
%and the only variable used for this fitness function will be the
%individuals
NT = 32; %nb of turbines
P = 3050; %Nominal power of 1 turbine
d = 101;  %rotor diameter
dair = 1.225; %air density
nind = 200; %number of individuals
%The distance between 2 adjacent cells is equal to 5*d

%% Data Turbine Model Enercon E-101 3050MW
% Wind speed [m/s]
winddata = [ 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
% Rotor Power Coefficient [without unit]
Cp = [ 0.076 0.279 0.376 0.421 0.452 0.469 0.478 0.478 0.477 0.439 0.358 0.283 0.227 0.184 0.152 0.127 0.107 0.091 0.078 0.067 0.058 0.051 0.045 0.04];
% Power [KW]
Power = [ 3 37 118 258 479 790 1200 1710 2340 2867 3034 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050 3050];
% Evaluation of Ct [without unit]
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
ct_int = fit(winddata',Ct', 'cubicinterp') ; 
a_int = fit(winddata', a', 'cubicinterp') ;
%power_int = fit([0;winddata'], [0;Power'], 'cubicinterp');
%plot(Cp, Ct,'*')
%figure(),hold on, grid on, plot(power_int(0:0.1:25),'.-k') 

%Probability distribution of wind speed in a year, Fig.12
%We will desconsider the wind speed value ws = 1m/s due to its probability
%value (p(ws)=0);
probdata = [0.003 0.005 0.018 0.043 0.068 0.073 0.050 0.045 0.045 0.058 0.065 0.080 0.030 0.048 0.053 0.020 0.023 0.018 0.040 0.025 0.018 0.035 0.055 0.073]; % [unit?]
sumprob = sum(probdata); % The sum of all probabities are not equal to 1. Due to this, the average efficiency
%will be evaluate with the rate between the probability of each wind speed
%value and the sum of all probablities.


%% Optimization
%vectorized option
nvars = 64;

%Constraint: The number of turbines in each grid that will be used in the
%optimization have to be equal to NT
Aeq = zeros(nvars);
Aeq(1,:) = 1;
beq = zeros(nvars,1);
beq(1) = NT;

% Domaine matrix
LB = zeros(nvars,1);
UB = zeros(nvars,1);
UB(:,1) = 1;
BinaryType = zeros(nvars,1);
BinaryType(:,1) = 1;
Domaine = [LB UB BinaryType];


%% MSPO

%options
options = struct( ...
      'AlgParams', struct(...    
     ...     % number of individuals
     'N_particules',     nind,...
     ...     % number of generations
     'N_iterations',     100,...
     ...     %number of variables
     'N_variables',     64, ...
     ...     %Number of solutions to be stored
     'N_archive',        100),...
     'StraParams', struct(...
     ... %Acceleration cognitive : in this problem, one can consider as the probability of being in the 
     ... %next iteration
     'Accel_memoire',    0.5, ...
     ...     %Acceleration sociale : tendance a suivre la meilleure position du groupe
     'Accel_guide',      0.5, ... 
     ...     %Inertie : tendance � suivre son �lan
     'Inertie_debut',    1, ...   %Valeur au debut de l'algorithme
     'Inertie_fin',      1, ...    %Valeur � la fin de l'algorithme
     ...     %MUTATION PROBABILITY
    'Proba_mut',        0.05, ...
     ...     %Facteur de constriction : Il r�duit � chaque it�ration l'ensemble de ces param�tres de strat�gie jusqu'� Fact_constrict fois leurs valeurs initiales
     ...     %Il permet, une fois le front atteint, de mieux le d�finir localement (avoir un front plus lisse)
     'Fact_constrict',   .1), ...
     ...%Fonction objectif
     'Objectif', struct(...
    ...     %Handle Matlab de la fonction objectif
     'fonction',     @(x)FitnessFunctionEvaluation(x)  , ...
     ...     %Espace de recherches des param�tres d'optimisation
     'Domaine',          Domaine), ...
     ...%Param�tres de sauvegarde
     'Sauvegarde', struct(...
     ...     %true, on sauvegarde, false, on sauvegarde pas
     'Etat',             true,...
     ...     %Nom du fichier dans lequel on sauvegarde les donn�es
     'Fichier',          'Resultat_MOPSO_eoliennes.mat'),... 
     ...%Parametres d'initialisation
     'Initialisation', struct(...
     ...     %true, on charge, false, on charge pas %0: aleatoire
     'Etat',             0 , ...
      'Fichier', '' ),...
     ...  %Parametres d'affichage
    'Affichage', struct(...
    ...     %On affiche ou pas, les r�sultats � chaque it�ration
    'Etat',             true) ); 

[x, fval] = MOPSO(options);

eff = -fval;