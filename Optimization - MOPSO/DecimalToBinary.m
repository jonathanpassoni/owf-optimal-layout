function grid = DecimalToBinary(x,NT,nvars)
%This function converts an individual of the population composed by
%real numbers in a binary numbers grid. It considers the
%closest values to 1.
[sort_value, sort_index] = sort(x,'descend');
grid = x;
for i = 1:1:nvars
    if i <= NT
        grid(sort_index(i)) = 1;
    else
        grid(sort_index(i)) = 0;
    end
end
        