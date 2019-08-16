% Distance from point to y boundary
function dist_y = dist_y(y, ymin, ymax)

    dist_y = min(y - ymin, ymax - y);
    
end