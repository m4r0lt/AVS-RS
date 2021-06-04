clear;clc;
addpath('./functions/');


columns = 100;
velocity_profile = 1;

    
relocating_strategy = 2;
storing_strategy = 2;
depth = 2;
racks = columns;
sides = 2;
tiers = 1;

fill_factor_beta = 0.5;

fill_alpha = (fill_factor_beta-1+depth)/depth;


%NENAD DATA
loading_unloading_times = [4.5, 5.5, 6.5, 7.5, 8.5, 9.5];
%LERHER PAPER DATA
%loading_unloading_times = [3.4, 5.8, 6.5, 7.5, 8.5, 9.5];


%distance between hand-over and first bin
d_first_rack = 1.5;

%distance between storage bays
d_between_racks = 0.5;

%distance between depths
d_between_depths = 0.4;

%distance first depth
d_first_depth = 0.4;

%SHUTTLES__________________________________________________________________
%acceleration
%accele = [1.5, 3];
a_s = 1.5; %m/s^2
%speed
velo = [1.5, 4];
v_max_s = 1.5; %m/s

a_y = 1;
v_max_y = 1;
% time to pick-up a tote (pick-up time of first slot)
% loading_time_s = 4;
% additional time to pick-up tote from deeper slot 
% loading_time_additional_depth = 1;

%LIFT______________________________________________________________________
%acceleration
a_l = 1.5; %m/s^2
%speed
v_max_l = 1.5; %m/s
%time for pick up a tote (loading and unloading time)
% loading_time_lift = 1.5;
% %switching and positioning times

WAREHOUSE = fill_the_warehouse_1_tier(depth, racks, sides, fill_alpha);


for i=1:1000
    
    [out_d, out_r, out_s] = STORING_strategy(storing_strategy, WAREHOUSE);
    WAREHOUSE(out_d, out_r, out_s) = max(max(max(WAREHOUSE)))+1;
    target_SKU = select_random_SKU_3D(WAREHOUSE);
    [goal_d, goal_r, goal_s] = find_SKU_position(target_SKU, WAREHOUSE);
    [relo_d, relo_r, relo_s, relo_necessity] = relocation_necessity_test(WAREHOUSE, target_SKU);
    
    while relo_necessity ~= 0
        [new_d, new_r, new_s] = RELOCATION_strategy(relocating_strategy,WAREHOUSE, relo_r, relo_s);
        RELOCATING_SKU = WAREHOUSE(relo_d, relo_r, relo_s);
        WAREHOUSE(relo_d, relo_r, relo_s) = 0;
        WAREHOUSE(new_d, new_r, new_s) = RELOCATING_SKU;
        [relo_d, relo_r, relo_s, relo_necessity] = relocation_necessity_test(WAREHOUSE, target_SKU);
    end
    WAREHOUSE(goal_d, goal_r, goal_s) = 0;
end


load('task_bus.mat');

%sim_results = sim('AVS_RS_v10_1_floor.slx', 1000000);
%sim_results_2 = sim('AVS_RS_v11_1_floor.slx', 1000000);
%results(depth - 1,relocation_strategy, fill_step, storing_strategy) = sim_results.throughput.data(end);




