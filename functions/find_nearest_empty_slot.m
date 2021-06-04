function [out_d, out_r, out_s] = find_nearest_empty_slot(floor)

[depth,racks,sides] = size(floor);


for r = 1:racks
    for d = depth:-1:1
        for s = 1:sides
            if floor(d,r,s) == 0
                out_d = d;
                out_r = r;
                out_s = s;
                return
            end
        end
    end
end

out_d = 0;
out_r = 0;
out_s = 0;
disp('THERE ARE NO MORE EMPTY SLOTS')

end
