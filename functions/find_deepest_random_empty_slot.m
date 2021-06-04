function [out_d, out_r, out_s] = find_deepest_random_empty_slot(floor)

[depth,~,~] = size(floor);

for d = depth:-1:1 
    [~,r,s] = ind2sub(size(floor(d,:,:)), find(floor(d,:,:) == 0));
    
    
    [number_of_hits, ~] = size(r);
    
    if number_of_hits == 0
        continue
    else
        coin_toss = randi([1, number_of_hits]);

        out_d = d;
        out_r = r(coin_toss);
        out_s = s(coin_toss);
        return
    end
    
    

end

out_d = 0;
out_r = 0;
out_s = 0;
disp('THERE ARE NO MORE EMPTY SLOTS')

end
