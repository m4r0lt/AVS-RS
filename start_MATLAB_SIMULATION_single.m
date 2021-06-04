clear
clc
addpath('./functions/');

racks=300;
sides=2;
tiers=1;

storing_strategy = 2;
relocating_strategy=2;
stevec_1 = 1;
results = zeros(1,5);


depth=6;
beta = 0.8;
    
%fill = 0.92 + (fill_step-1)*0.01;



%for depth = 9:9
fill = (beta-1+depth)/depth;


list_relo_depth_load = [];
list_relo_depth_unload = [];
list_storing_depth = [];
list_retrieving_depth = [];
list_relocation_number = [];
stevec = 1;


WAREHOUSE = fill_the_warehouse(depth,racks,sides,tiers,fill);

for extra_step=1:10000



    [out_d, out_r, out_s] = STORING_strategy(storing_strategy, WAREHOUSE);
    list_storing_depth(extra_step)=out_d;
    WAREHOUSE(out_d, out_r, out_s) = max(max(max(WAREHOUSE)))+1;
    target_SKU = select_random_SKU_3D(WAREHOUSE);
    [goal_d, goal_r, goal_s] = find_SKU_position(target_SKU, WAREHOUSE);
    list_retrieving_depth(extra_step) = goal_d;

    relo_counter = 0;

    [relo_d, relo_r, relo_s, relo_necessity] = relocation_necessity_test(WAREHOUSE, target_SKU);

    while relo_necessity ~= 0
        relo_counter = relo_counter + 1;

        [new_d, new_r, new_s] = RELOCATION_strategy(relocating_strategy,WAREHOUSE, relo_r, relo_s);

        RELOCATING_SKU = WAREHOUSE(relo_d, relo_r, relo_s);
        list_relo_depth_load(stevec) = relo_d;
        WAREHOUSE(relo_d, relo_r, relo_s) = 0;



        WAREHOUSE(new_d, new_r, new_s) = RELOCATING_SKU;
        list_relo_depth_unload(stevec)=new_d;
        [relo_d, relo_r, relo_s, relo_necessity] = relocation_necessity_test(WAREHOUSE, target_SKU);
        stevec = stevec + 1;
    end
    list_relocation_number(extra_step) = relo_counter;
    WAREHOUSE(goal_d, goal_r, goal_s) = 0;
end


          





