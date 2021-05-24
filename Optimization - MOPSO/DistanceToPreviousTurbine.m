function gridnt = DistanceToPreviousTurbine(grid)
%This function gives the distance between the previous and 
%a given turbine(value 1) in a same column - for each turbine in the grid.
%Distance measured in units of array cells.
l = length(grid);
gridnt = zeros(l);
for i=1:1:l
    for j = 2:1:l
        %turbine to be analysed
        pos = j-1;
        while grid(pos,i) == 0
            if pos == 1
                gridnt(j,i) = 0;
                break
            else
                pos = pos -1; %Searching for the position of the precedent turbine
            end
        end
        if grid(pos,i) ==1
            gridnt(j,i) = j - pos;
        end
    end
end
end
            
                