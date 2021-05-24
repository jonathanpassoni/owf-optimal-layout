function Pot = SumPower(ws, d, dair, a_int)
l = length(ws);
%loop version
Pot = 0;
for i=1:1:l
    for j = 1:1:l
        if ws(i,j) > 1
            a = a_int(ws(i,j))
            power_i = 2*dair*(pi*power(d/2,2))*a*(power((1-a),2)) % Eqn 15 - Article 1
            Pot = Pot + power_i;
        end
    end
end
