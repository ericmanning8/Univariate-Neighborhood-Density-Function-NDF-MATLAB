function Distance = DistanceFormula(P1, P2)

    n = size(P1); 
    Distance = 0;

    for i = 1:n
        Distance = Distance + ( P2(i) - P1(i) )^2;
    end
    
    Distance = sqrt( Distance );

end 