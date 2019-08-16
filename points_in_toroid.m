% Points in nhb using the toroidal correction for k analysis (after Haase 1995)...
function points_in_toroid = points_in_toroid(xa, ya, xb, yb, xmax, ymax, max_d)

    dist(1) = EuclDistance(xa, ya, xb, yb); % Nine possible toroidal distances

    % Effectively in this correction the plot is wrapped around itself eight times.
    dist(2) = EuclDistance(xa, ya, xb, ya + ymax);
    dist(3) = EuclDistance(xa, ya, xb, ya - ymax);

    dist(4) = EuclDistance(xa + xmax, ya, xb, yb);
    dist(5) = EuclDistance(xa - xmax, ya, xb, yb);

    dist(6) = EuclDistance(xa, ya, xb + xmax, yb + ymax);
    dist(7) = EuclDistance(xa, ya, xb + xmax, yb - ymax);
    dist(8) = EuclDistance(xa, ya, xb - xmax, yb + ymax);
    dist(9) = EuclDistance(xa, ya, xb - xmax, yb - ymax);

    if (min_fl_array(dist, 9, 1) <= max_d)
        in_circle = true;
    else
        in_circle = false;
    end
    
    % return if the points are in a toroid
    points_in_toroid = in_circle;

end