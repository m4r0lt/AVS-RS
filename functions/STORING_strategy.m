 function [out_d, out_r, out_s] = STORING_strategy(strategy_number, floor)


if strategy_number == 1
    [out_d, out_r, out_s]=find_deepest_empty_slot(floor);

elseif strategy_number == 2
    [out_d, out_r, out_s]=find_nearest_empty_slot(floor);
    
elseif strategy_number == 3
    [out_d, out_r, out_s]=find_random_empty_slot(floor);

elseif strategy_number == 4
    [out_d, out_r, out_s]=strat_test(floor);
    
else
    [out_d, out_r, out_s]=find_deepest_random_empty_slot(floor);
    
end