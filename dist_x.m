% Distance from point to x boundary
function dist_x = dist_x(x, xmin, xmax)

    dist_x = min(x - xmin, xmax - x);
    
end