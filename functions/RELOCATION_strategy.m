function [new_d, new_r, new_s] = RELOCATION_strategy(strategy_number, W, relo_r, relo_s)

if strategy_number == 1
    [new_d, new_r, new_s]=find_deepest_empty_slot_relocation(W, relo_r, relo_s);
    
elseif strategy_number == 2
    [new_d, new_r, new_s]=find_nearest_empty_slot_relocation(W, relo_r, relo_s);

elseif strategy_number == 3
    [new_d, new_r, new_s]=find_random_empty_slot_relocation(W, relo_r, relo_s);
    
else
    [new_d, new_r, new_s]=jakob_heuristic_1_relocation(W, relo_r, relo_s);
    
end


