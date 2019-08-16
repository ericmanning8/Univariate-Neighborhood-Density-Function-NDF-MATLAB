% Estimate k(t) assuming weighted edge corrections -> method given by Goreaud and Pelissier (1999) is used.
% This is the newer version of the routine which calcs all bins at once.
function k_t = calc_k_ew(x1, y1, t, max_step, bins, n, xmin, ymin, xmax, ymax, area)
    
    % initilize the k_t matrix
    k_t = zeros(n);

    for i = 1:n % Loop through all points
        for j = i+1:n
            
%            pctDone = Int((i / n) * 100)
%            Application.StatusBar = "Calculating Ripley's K " & pctDone & " % complete."
                
            dij = EuclDistance(x1(i), y1(i), x1(j), y1(j)); % Distance between points
            
            if (dij <= max_step && dij ~= 0) % If the point's within the largest circle ...
                    
                % First the weight for point i to point j...
                dx = dist_x(x1(i), xmin, xmax);
                dy = dist_y(y1(i), ymin, ymax); % Distance to boundaries
                dx2 = max_val(xmax - x1(i), x1(i) - xmin);
                dy2 = max_val(ymax - y1(i), y1(i) - ymin);

                method = assess_edge(dij, dx, dy, dx2, dy2);

                if method == 0
                    edge_wgt = 1;
                elseif method == 1
                    edge_wgt = edge_corr1(min_val(dx, dy), dij);
                elseif method == 2
                    edge_wgt = edge_corr2(dx, dy, dx2, dy2, dij);
                elseif method == 3
                    edge_wgt = edge_corr3(dx, dy, dx2, dy2, dij);
                end
                    
                wij = edge_wgt;
                    
                % Now the weight for point j to point i...
                dx = dist_x(x1(j), xmin, xmax);
                dy = dist_y(y1(j), ymin, ymax); % Distance to boundaries
                dx2 = max_val(xmax - x1(j), x1(j) - xmin);
                dy2 = max_val(ymax - y1(j), y1(j) - ymin);

                method = assess_edge(dij, dx, dy, dx2, dy2);

                if method == 0
                    edge_wgt = 1;
                elseif method == 1 
                    edge_wgt = edge_corr1(min_val(dx, dy), dij);
                elseif method == 2 
                    edge_wgt = edge_corr2(dx, dy, dx2, dy2, dij);
                elseif method == 3 
                    edge_wgt = edge_corr3(dx, dy, dx2, dy2, dij);
                end

                wji = edge_wgt;
                    
                % Get the bin and update K(t) values
                
                b = ceiling(dij / t) + 1;
                if (area == 1 && b > bins)
                    b = bins; % Seems to be occasional error when using unit plot and dij is exactly max_step?
                end 
                k_t(b) = k_t(b) + wij + wji; % Update value of k(t)
            end
        end
    end
    
    for i = 1:bins
        k_t(i) = k_t(i) + k_t(i - 1);
    end
    for i = 1:bins
        k_t(i) = area * (k_t(i) / (n ^ 2)); % Final K(t) values
    end
end