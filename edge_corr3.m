% Edge correction for where both borders are intersected but where both distances from
% point i to the nearest edge are less than the distance from i to the nearest plot corner.
% From G and P 1999: Case 3
function edge_corr3 = edge_corr3(d1, d2, d3, d4, d)

    % logical statements for edge correction 3
    if (d > d1 && d > d2 && d > d3 && d <= d4)
        if ( (d^2) <= (d1^2 + d2^2) && (d^2) <= (d2^2 + d3^2) ) % Case 3a
            aout = (2 * acos(d1 / d)) + (2 * acos(d2 / d)) + (2 * acos(d3 / d));
        elseif (d^2 <= (d1^2 + d2^2) && d^2 > (d2^2 + d3^2) ) % Case 3b
            aout = (pi / 2) + (2 * acos(d1 / d) + acos(d2 / d) + acos(d3 / d));
        
        elseif (d^2 > (d1^2 + d2^2) && d^2 > (d2^2 + d3^2)) % Case 3c
            aout = pi + acos(d1 / d) + acos(d3 / d);
        end
    else
        aout = 0; % aout initilized to 0 in the case where the logical statements are not ran 
    end
    
    % return edge correction 3
    edge_corr3 = (2 * pi) / ((2 * pi) - aout);

end