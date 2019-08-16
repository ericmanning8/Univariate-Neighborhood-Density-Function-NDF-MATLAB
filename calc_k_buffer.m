% Estimate k(t) using buffered plot-edge corrections ....
function k_t = calc_k_buffer(x1, y1, t, max_step, bins, n, xmin, ymin, xmax, ymax, area)

    k_t = zeros(n);
    
    closest_edge(x1, y1, edge_dist, xmin, ymin, xmax, ymax, n);
    
    for i = 1:n % Loop through all points
        for j = 1:n
            
            dist = EuclDistance(x1(i), y1(i), x1(j), y1(j));
            
            if (dist <= max_step && dist ~= 0)
                if (edge_dist(i) >= (max_step / 2))
                    wij = 1;
                end
                    
                b = ceiling(dist / t) + 1;
                if (area == 1 && b > bins)
                    b = bins;
                end % Seems to be occasional error when using unit plot and dij is exactly max_step?
                k_t(b) = k_t(b) + wij; % + wji  + 2 for i to j and j to i
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