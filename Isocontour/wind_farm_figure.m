% This algorithm builds the figure that shows the wake effect in a grid

% We consider the space between 2 turbines as 5*d.So, each cell of this
% array has horizontal lenght = 6*d and vertical length = 5*d

grid_data;

d = 101; %turbine diameter
rt = d/2; %turbine radius
dim = 8; % grid dimension
x = [0:10:6*d*dim];
y = [0:10:6*d*dim];

%% Place of each turbine
[position_x, position_y] = GiveTurbinePosition(binary_grid, d);

%% Wind speed in each turbine given its probability distribution
WakeEffect = WakeEffectCombined(binary_grid,d);
w_speed = zeros(length(binary_grid));
for k=1:length(w)
    w_speed_Uf = speed(binary_grid, w(k), ct_int, WakeEffect);
    w_speed = w_speed + prob_data(k)*w_speed_Uf;
end
w_speed = w_speed/sum(prob_data);
w_list = []; %list of wind speed only for the turbines in a grid
for i = 1:length(w_speed)
    for j = 1:length(w_speed)
        if w_speed(i,j) || 0
            w_list = [w_list w_speed(i,j)];
        end
    end
end

%% Figure Building

U = zeros(numel(x), numel(y));
for k = 1:length(position_y)
    yt = position_y(k);
    xt = position_x(k);
    for i=1:numel(x)
        for j=1:numel(y)
            if x(i)> xt
                rw(i)=rt+k_wake*(x(i)-xt); %influence radius of the turbine in analysis
                if y(j)>yt-rw(i) && y(j)<yt+rw(i) %region where the wind speed changes
                    U(i,j)= w_list(k)*(1-(1-sqrt(1-ct_int(w_list(k))))*(rt/rw(i))^2);
                else
                    if U(i,j)== 0
                        U(i,j) = w_list(1);
                    end
                % considering that the wind speed in the area 
                % where the wake effect does not take place are the same
                % wind speed value in turbines which are in the first line 
                end
            else
                if U(i,j)== 0
                    U(i,j) = w_list(1);
                end
            end
        end
    end
end

figure
contourf (x, y, U,'LineStyle','none','LevelStep',0.01)
colorbar
grid on
xlabel({'x/D'});
ylabel({'y/D'});
title({'Velocity contour [m/s]'});
set(gca, 'YDir','reverse')
hold on
%plot(position_x, position_y, 'o')
