function comb = WakeEffectCombined(grid,d)
%This function will evaluate the 'TotalWakeEffect' function to all turbines
%in the grid and then it will provide a matrix which contains the sum of 
%all contributions to this effect.
l = length(grid);
comb = zeros(l);
for i=1:1:(l-1)
    for j=1:l
        wakeeffect = TotalWakeEffect(grid,i,j,d);
        comb = comb + wakeeffect;
    end
end
        