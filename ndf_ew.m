%%% NDF with edge corrections function 
% Calculate NDF at distance w with edge corrections

%%% input parameters
% x1 = x data
% y1 = y data
% st = step size
% max_step = largest step size
% bins = 
% points = number of points 
% area = 
function [ndf, std_ndf] = ndf_ew(x1, y1, st, max_step, points)
    
    xmin = min(x1); % minimum x value 
    ymin = min(y1); % minimum y value 
    xmax = max(x1); % maximum x value
    ymax = max(y1); % maximum y value 
    area = (xmax - xmin) * (ymax - ymin); % region of interest ROI
    bins = max_step/st;
    ndf = zeros(points,1); % preallocate ndf vector 
    std_ndf = zeros(points,1); % preallocate std_ndf vector 

    for i = 1:points
        for j = (i+1):points
            Distance = EuclDistance(x1(i), y1(i), x1(j), y1(j));
            
            if (Distance <= max_step && i ~= j)
                
                % First we calculate the weighting effect from point i to point j
                dx = dist_x(x1(i), xmin, xmax); 
                dy = dist_y(y1(i), ymin, ymax); 
                % Distance to boundaries
                dx2 = max(xmax - x1(i), x1(i) - xmin); 
                dy2 = max(ymax - y1(i), y1(i) - ymin);

                % Calculate the edge weighting effect for the point itself
                method = assess_edge(Distance, dx, dy, dx2, dy2);

                if (method == 0)
                    point_ew = 1;
                elseif (method == 1)
                    point_ew = edge_corr1(min(dx, dy), Distance);
                elseif (method == 2)
                    point_ew = edge_corr2(dx, dy, dx2, dy2, Distance);
                elseif (method == 3)
                    point_ew = edge_corr3(dx, dy, dx2, dy2, Distance);
                end

                % Now calculate the edge weighting effect for the inner circle (remember NDF is not cumulative) ....
                inner = (Distance / st) * st;
                method = assess_edge(inner, dx, dy, dx2, dy2);

                if (method == 0)
                    inner_ew = 1;
                elseif (method == 1)
                    inner_ew = edge_corr1(min(dx, dy), inner);
                elseif (method == 2)
                    inner_ew = edge_corr2(dx, dy, dx2, dy2, inner);
                elseif (method == 3)
                    inner_ew = edge_corr3(dx, dy, dx2, dy2, inner);
                end

                % Final correction is 1 + (effect of point - effect of circle) ...
                wij = 1 + (point_ew - inner_ew);

                % Now we calculate the weighting effect from point j to point i
                % Calculate the edge weighting effect for the point itself ....
                dx = dist_x(x1(j), xmin, xmax); 
                dy = dist_y(y1(j), ymin, ymax);
                % Distance to boundaries
                dx2 = max(xmax - x1(j), x1(j) - xmin); 
                dy2 = max(ymax - y1(j), y1(j) - ymin);

                method = assess_edge(Distance, dx, dy, dx2, dy2);

                if (method == 0)
                    point_ew = 1;
                elseif (method == 1)
                    point_ew = edge_corr1(min(dx, dy), Distance);
                elseif (method == 2)
                    point_ew = edge_corr2(dx, dy, dx2, dy2, Distance);
                elseif (method == 3)
                    point_ew = edge_corr3(dx, dy, dx2, dy2, Distance);
                end

                % Now calculate the edge weighting effect for the inner circle (remember NDF is not cumulative)
                inner = (Distance / st) * st;
                method = assess_edge(inner, dx, dy, dx2, dy2);

                if (method == 0)
                    inner_ew = 1;
                elseif (method == 1)
                    inner_ew = edge_corr1(min(dx, dy), inner);
                elseif (method == 2)
                    inner_ew = edge_corr2(dx, dy, dx2, dy2, inner);
                elseif (method == 3)
                    inner_ew = edge_corr3(dx, dy, dx2, dy2, inner);
                end

                % Final correction is 1 + (effect of point - effect of circle)
                wji = 1 + (point_ew - inner_ew);

                % Update the ndf list
                bin_class = ceil(Distance / st) + 1; % again +1 for indexing from one!
                ndf(bin_class) = ndf(bin_class) + wij + wji; 
            end
        end
    end

    for i = 1:bins
        w = i * st; % True distance not bin no.
        if (i == 0)
            annuli = (pi * (st^2)) * points;
        else
            annuli = ((pi * (w^2)) - (pi * (w - st)^2)) * points;
        end
        ndf(i) = ndf(i) / annuli;
        std_ndf(i) = ndf(i) / (points / area);
    end
 end
