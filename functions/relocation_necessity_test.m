function [out_d, out_r, out_s, relocation_necessity] = relocation_necessity_test(floor, target_SKU)

[target_d, target_r, target_s] = ...
    ind2sub(size(floor), find(floor == target_SKU));

%to insure that the output will be a scalar
target_d = target_d(1);
target_r = target_r(1);
target_s = target_s(1);

for d = 1:target_d - 1
    if floor(d, target_r, target_s) ~= 0
        out_d = d;
        out_r = target_r;
        out_s = target_s;
        relocation_necessity = 1;
        return 

    end
end


out_d = 0;
out_r = 0;
out_s = 0;
relocation_necessity = 0;
        
   
end
