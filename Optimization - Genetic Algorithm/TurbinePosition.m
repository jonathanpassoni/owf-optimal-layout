function [TurbinePositionX, TurbinePositionY] = GiveTurbinePosition(grid, D)
dim = len(grid);
TurbinePositionX = [];
TurbinePositionY = [];
x = 5*D;
y = 5*D;
for i=1:1:dim 
    x = x + 10*D*(i-1);
    for j=1:1:dim
        y = y + 10*D*(j-1);
        if grid(i,j) == 1
            TurbinePositionX = [TurbinePositionX x];
            TurbinePositionY = [TurbinePositionY y];
        end
    end
end

   
            
            
            
        
        