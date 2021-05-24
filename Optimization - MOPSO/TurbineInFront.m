function pos = TurbineInFront(grid,i,j)
%this function gives the vertical position on the grid of the nearest turbine 
%on the same column of the first one.
l = length(grid);
k = i;
while k > 1
    if grid(k-1,j) == 1
        pos = i - k +1;
        break
    else
        k = k-1;
    end
    pos = 0;
end
    
    