function [out_d, out_r, out_s] = jakob_heuristic_1_relocation(floor, vehicle_r, vehicle_side)

[depth,racks,sides] = size(floor);

for increase=1:racks
border = increase * 5;
%first check oposite side

    for d = depth:-1:1
        if vehicle_side == 1
            s = 2;
        else
            s = 1;
        end

        if floor(d,vehicle_r,s) == 0
            out_d = d;
            out_r = vehicle_r;
            out_s = s;
            return
        end

    end


    for r = 1:border
        for d = depth:-1:1
            for s = 1:sides
                if vehicle_r + r <= racks
                    if floor(d,vehicle_r + r, s) == 0
                        out_d = d;
                        out_r = vehicle_r + r;
                        out_s = s;
                        return
                    end
                end


                if vehicle_r - r >= 1
                    if floor(d,vehicle_r - r, s) == 0
                        out_d = d;
                        out_r = vehicle_r - r;
                        out_s = s;
                        return
                    end
                end
            end
        end
    end
end


out_d = 0;
out_r = 0;
out_s = 0;
disp('THERE ARE NO MORE EMPTY SLOTS RELOCATION')

end
