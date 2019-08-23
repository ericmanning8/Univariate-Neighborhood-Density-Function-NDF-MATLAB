function [ndf, std_ndf] = ndf_nocorr(x1, y1, st, max_step, points)

    xmin = min(x1); % minimum x value 
    ymin = min(y1); % minimum y value 
    xmax = max(x1); % maximum x value
    ymax = max(y1); % maximum y value 
    area = (xmax - xmin) * (ymax - ymin); % region of interest ROI
    bins = max_step/st;
    ndf = zeros(bins,1); % preallocate ndf vector 
    std_ndf = zeros(bins,1); % preallocate std_ndf vector 

    for i = 1:points
        for j = (i + 1):points

            Distance = EuclDistance(x1(i), y1(i), x1(j), y1(j));

            if (Distance <= max_step)

                bin_class = ceil(Distance / st);
                ndf(bin_class) = ndf(bin_class) + 2;  % + 2 because i to j = j to i
            end
        end
    end

    for i = 1:bins

        w = i * st; % True distance not bin no.
        if (i == 0)
            annuli = (pi * st^2) * points;
        else
            annuli = ((pi * (w)^2) - (pi * (w - st)^2)) * points;
        end

        ndf(i) = ndf(i) / annuli;
        std_ndf(i) = ndf(i) / (points / area);
    end
end
