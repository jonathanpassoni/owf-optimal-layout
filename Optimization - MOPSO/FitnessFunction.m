function EffAv = FitnessFunction(x)
global  NT P d dair winddata probdata sumprob ct_int a_int
% x is a vector of 0 and 1 depending on if there is a wind turbine or not.
dim = sqrt(length(x));
%xbin = DecimalToBinary(x, NT,length(x));
grid = reshape(x, [dim dim])';
EffAv = 0;
weffect = WakeEffectCombined(grid,d);
for k = 1:1:length(probdata)
    Uf = winddata(k);%we will fix the wind speed in the first line of the grid
    %This speed will be the reference to the evaluation of the speed of all grid 
    ws = speed(grid, Uf, ct_int,weffect); % grid of wind speed considering wake effect [8x8] for Uf
    Pwf = SumPower(ws,d,dair,a_int); % Eq.21 [KW]
    AE = Pwf/(P*NT); % Eq.22  efficiency for a given wind speed value
    EffAv = EffAv  - AE*(probdata(k)/sumprob); % Average Efficiency considering the 
    %probability of each wind speed value
end
