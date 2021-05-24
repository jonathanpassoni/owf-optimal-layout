function ws = speed(grid, Uf, ct_int, WakeEffect)
%This function gives a matrix with the wind speed for each turbine given
%the wind speed in the first line of the grid.

l = length(grid);
ws = zeros(l);

%% Wind speed grid initialization
for i = 1:1:l
    j = 1;
    %j is the index of the first wind turbine in the column
    while j <= l  
        if grid(j,i) == 1
            ws(j,i) = Uf;
            break 
        else
            j = j+1;
            %In the end, j will be the sum of spaces without turbines
        end
    end 
end

%% Fill wind speed grid using wake effect
gridnt = DistanceToPreviousTurbine(grid);
for i = 2:1:l
    for j = 1:1:l
        if grid(i,j) == 1
            if gridnt(i,j) ~= 0
                Ct = ct_int(ws((i-gridnt(i,j)),j));
                %Evaluation of the wind speed considering the wake effect
                ws(i,j) = ws((i-gridnt(i,j)),j)*(1 + (sqrt(1-Ct) - 1)*(WakeEffect(i,j))); %Eq.18
            end    
        end
    end
end