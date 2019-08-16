% Estimate k(t) using toroidal edge corrections ....
% This is the newer version of the routine which calcs all bins at once.
function k_t = calc_k_toroid(x1, y1, t, max_step, bins, n, xmax, ymax, area)

    k_t = zeros(n);
    
    for i = 1:n % Loop through all points
        for j = i + 1:n
            
            dist = EuclDistance(x1(i), y1(i), x1(j), y1(j));
            
            if (dist <= max_step && dist ~= 0)
                
                if (points_in_toroid(x1(i), y1(i), x1(j), y1(j), xmax, ymax, max_step) == true)
                    b = ceiling(dist / t) + 1;
                    if (area == 1 && b > bins) 
                        b = bins; % Seems to be occasional error when using unit plot and dij is exactly max_step?
                    end
                    k_t(b) = k_t(b) + 2; % + 2 for i to j and j to i
                end
                
            end
                
        end
    end
    
    for i = 1:bins
        k_t(i) = k_t(i) + k_t(i - 1); 
    end
    
    for i = 1:bins
        k_t(i) = area * (k_t(i) / (n ^ 2));
    end
end