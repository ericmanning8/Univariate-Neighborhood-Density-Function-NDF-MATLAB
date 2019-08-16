% Edge correction for cases where both borders are intersected (from G and P, 1999): Case 2
function edge_corr2 = edge_corr2(d1, d2, d3, d4, d)

    % logical statements for the edge correction
    if (d > d1 && d > d2 && d <= d3 && d <= d4)
        if (d^2 <= d1^2 + d2^2) % Case 2a
            aout = (2 * acos(d1 / d)) + (2 * acos(d2 / d));
        elseif (d ^ 2 >= d1 ^ 2 + d2 ^ 2) % Case 2b
            aout = (pi / 2) + (acos(d1 / d)) + (acos(d2 / d));
        end
    
    elseif (d > d1 && d > d3 && d <= d2 && d <= d4) % Case 2c
        aout = (2 * acos(d1 / d)) + (2 * acos(d3 / d));
    end
    
    % return edge correction 2
    edge_corr2 = (2 * pi) / ((2 * pi) - aout);

end