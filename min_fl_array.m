function min_fl_array = min_fl_array(in_array, n, base)

    min = 9999.9;
    
    for i = base:n
        if in_array(i) <= min
            min = in_array(i);
        end
    end

    min_fl_array = min;

end