function t=calculate_shuttle_time(v,a,s)

s_critical = (v^2)/a;

if s < s_critical
    t = 2*((s/a)^0.5);
    return
else
    t = s/v + v/a;
    return
end

end