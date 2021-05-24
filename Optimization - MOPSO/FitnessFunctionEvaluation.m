function [EffAvX, Constraint, Divers]  = FitnessFunctionEvaluation(x)
EffAvX = [];
Constraint = [];
global NT 
% x is a vector of 0 and 1 depending on if there is a wind turbine or not.
%x
for i = 1:1:length(x(1,:))
    if sum(x(:,i)) == NT
        Constraint = [Constraint -1];
        %x(:,i)'
        EffAvX = [EffAvX FitnessFunction(x(:,i)')];
    else
        Constraint = [Constraint 1];
        EffAvX = [EffAvX 1];
    end
end
EffAvX = [EffAvX; zeros(1,length(EffAvX))];
Divers = zeros(1, length(EffAvX));