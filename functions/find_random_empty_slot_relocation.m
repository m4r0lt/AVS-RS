function [out_d, out_r, out_s] = find_random_empty_slot_relocation(floor, vehicle_r, vehicle_side)


[depth,racks,sides] = size(floor);

if floor(1,vehicle_r,vehicle_side) == 0
    %define d,r,s size 
    d=zeros(1,sum(sum(floor(1,:,:)==0))-1);
    r=zeros(1,sum(sum(floor(1,:,:)==0))-1);
    s=zeros(1,sum(sum(floor(1,:,:)==0))-1);
else
    %define d,r,s size 
    d=zeros(1,sum(sum(floor(1,:,:)==0)));
    r=zeros(1,sum(sum(floor(1,:,:)==0)));
    s=zeros(1,sum(sum(floor(1,:,:)==0)));
end



stevec = 1;
for rack=1:racks
    for side=1:sides
        for deep = depth:-1:1 
            if floor(deep,rack,side)==0 && (rack~=vehicle_r || side~=vehicle_side)
                d(stevec) = deep;
                r(stevec) = rack;
                s(stevec) = side;
                stevec = stevec + 1;
                break
                    

            end
        end
    end
end

if ~isempty(d)
    coin_toss = randi([1, length(d)]);
    out_d = d(coin_toss);
    out_r = r(coin_toss);
    out_s = s(coin_toss);
    return
end

    

out_d = 0;
out_r = 0;
out_s = 0;
disp('THERE ARE NO MORE EMPTY SLOTS')

end