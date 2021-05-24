function effect = TotalWakeEffect(grid,i,j,d)
%This function evaluates the wake effect produced by a turbine in
%all other turbines of the wind farm
l = length(grid);
effect = zeros(l);
if grid(i,j) == 1
    k = i+1;
    while k <=l
        for c = 1:1:l
            if grid(k,c) ==1
                turbinesInFront = sum(grid(1:(k-1),j)); %number of turbines in a given column that
                % produce the wake effect in a given turbine (i,j)
                distance = TurbineInFront(grid,k,c); % distance from the nearest turbine which is at the
                %front of the turbine (i,j)
                Area = OverlapArea(d, k-i, abs(j-c),turbinesInFront,distance);
                effect(k,c) = Area;
            end
        end
        k = k+1;
    end
end