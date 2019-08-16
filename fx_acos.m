% Derive the inverse cosine from defined functions ...
function fx_acos = fx_acos(x)

    x = x * (pi / 180);

    if (abs(x) ~= 1)
        fx_acos = atan(-x / sqrt(-x * x + 1)) + 2 * atan(1);
    else
        if x == 1
            fx_acos = atan(1);
        else
            fx_acos = atan(1) * 4;
        end
    end

end