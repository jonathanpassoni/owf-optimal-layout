function EffAv = FitnessFunction(x, ct_int, a_int, winddata, probdata, NT, P, d, sumprob,dair)
% x is a vector of 0 and 1 depending on whether a wind turbine is present or not.
dim = sqrt(length(x));
%grid = XToGrid(x,NT)'; % we use the transverse due to the vector data
%modelling
xbin = DecimalToBinary(x, NT,length(x))
sum(xbin)
grid = reshape(xbin, [dim dim])';
%Fitness function
EffAv = 0;
weffect = WakeEffectCombined(grid,d);
for k = 1:1:length(probdata)
    Uf = winddata(k);%we fix the wind speed in the first line of the grid
    %This speed  value is the reference for the evaluation of the speed of
    %all turbines on the grid
    ws = speed(grid, Uf, ct_int,weffect); % grid of wind speed considering wake effect [8x8] for Uf
    Pwf = SumPower(ws,d,dair,a_int); % Eq.21 [KW]
    AE = Pwf/(P*NT); % Eq.22  efficiency for a given wind speed value
    EffAv = EffAv  - AE*(probdata(k)/sumprob); % Average Efficiency considering the 
    %probability of each wind speed value
end