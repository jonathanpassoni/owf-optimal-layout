function Area = OverlapArea(d,i,j,turbinesInFront,X)
%This function will evaluate the part of equation 13 - article 2 which is
%inside of the sum simbol. See description file - item6 3 
%d= rotor diameter
%i = number of lignes which separate the two turbines
%j = number of columns which separate this two turbines
%X = distance between the upwind turbine and the downwind turbine.
%turbinesInFront = number of turbines that are at the front of the analysed
%turbine
r = d/2; % the current turbine radius
Dj = 5*j*d; % horizontal distance between 2 tubines
k = 0.04; %wake decay constant
dx = d +2*5*k*d*i; %k: wake decay constant in sea
R = dx/2; %rx in the article
% the bigger circunference will be in the position i = Dj and your radius 
%will be R.
if Dj < (R+r) 
    if Dj > R
        distances = [1 1; 1 -1]\[Dj; ((power(R,2) - power(r,2))/Dj)]; % Evaluation of distances - See description file item 1
        d1 = distances(1);
        d2 = distances(2);  
        z = sqrt(power(r,2) - power(d2,2));
        Area = (power(1/R,2)/pi)*(power(R,2)*acos(d1/R) + power(r,2)*acos(d2/r) - z*Dj); % Eqn 19 - article 1
    else
        if ((R > 2*r) | (j==0))
            %In this case, only the Area considered by the nearest turbine
            %will be evaluated.
            newR = (d +2*0.04*5*X)/2;
            Area = power((r/newR),2)/turbinesInFront; % Part of Eqn 18 - Article 1
        else %when r<Dj<=R
            distances = [1 1; 1 -1]\[(power(R,2) - power(r,2))/Dj; Dj]; % Evaluation of distances - See description file item 1
            d1 = distances(1);
            d2 = distances(2);
            z = sqrt(power(r,2) - power(d2,2));
            Area = (power(1/R,2)/pi)*(power(R,2)*acos(d1/R) + power(r,2)*(pi - acos(d2/r)) + z*Dj); %Eqn 20 article 1
        end 
    end
else
    Area =  0;
end
if X < i %See Description file - item 4
    R2 = (d +2*5*k*d*(i-X))/2;
    if (Dj ~= 0) & ((R2-r) > Dj) %In this situation, there's a turbine that obstruct
     %the wake effect. In this case, the evaluated area is not considered. 
        Area = 0;
    end
end
