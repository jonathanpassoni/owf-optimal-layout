function grid = DecimalToBinary(x,NT,nvars)
%This function converts an individual of the population composed by
%real numbers in a binary numbers grid. It considers the
%distance between 2 turbines in the same column, because this can decrease
%the wake effect contribution.
l = sqrt(length(x));
distance = DistanceToPreviousTurbine(reshape(x, [l l]));
[sort_value, sort_index] = sort(distance,'descend');
grid = x;
for i = 1:1:nvars
    if i <= NT
        grid(sort_index(i)) = 1;
    else
        grid(sort_index(i)) = 0;
    end
end
        