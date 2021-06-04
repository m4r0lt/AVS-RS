function [out_d, out_r, out_s] = strat_test(floor)

W = floor;

[depth, columns, side] = size(W);

for d=depth:-1:1
    for c=1:columns
        for s=1:2
            
            if W(d,c,s) == 0
                out_d = d;
                out_r = c;
                out_s = s;
                return
                
            end
        end
    end
end

out_d = 0;
out_r = 0;
out_s = 0;

end






