function time = calculate_travel_time(start, finish, v, a,d_between_racks, d_first_rack)

path = abs(finish-start) * d_between_racks;

if finish == 0 || start == 0    
    path = path + d_first_rack - d_between_racks;
    
elseif finish == start
    path = 0;   

end
    
critical_path = (v^2)/a;


if path < critical_path
    time = 2*(path/a)^0.5;
    return
    
else
    time = (path/v) + (v/a);
    return
    
end


