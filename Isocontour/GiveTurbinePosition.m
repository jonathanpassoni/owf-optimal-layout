function [TurbinePositionX, TurbinePositionY] = GiveTurbinePosition(grid, D)
%This function generates the turbines s position in a grid
% grid = binary matrix of turbines placement
% D = turbine diameter
dim = length(grid);
TurbinePositionX = [];
TurbinePositionY = [];
%Initial points
%Distance considered between 2 turbines = 5*D
for i=1:1:dim 
    if i == 1
        x = 0;
    end
    x = x + 5*D;
    for j=1:1:dim
        if j == 1
            y = 0;
        end
        y = y + 5*D;
        if grid(i,j) == 1
            TurbinePositionX = [TurbinePositionX x];
            TurbinePositionY = [TurbinePositionY y];
        end
    end
end