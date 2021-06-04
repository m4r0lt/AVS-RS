clear
clc
addpath('./functions/');



results = {};

results(1,:) = {'columns', 'depth', 'relo strategy', 'storing strategy', 'fill factor',...
        'relocation_time_1way_rack', 'relocation_depth_time_to', 'relocation_depth_time_from','relocation frequency', ...
        'empty travel time', ...
        'storing time depth', 'storing time rack',...
        'retrieving time depth', 'retrieving time rack'...
        'cycle time', 'relocation time total'};

%results(1,:) = {'columns', 'depth', 'relo strategy', 'storing strategy', 'fill factor', 'relocation_1way_rack', ...
%    'relocation_depth_to', 'relocation_depth_from', 'relocation frequency', 'empty travel time',...
%    'cycle time', 'storing depth', 'storing rack', 'retrieving depth', 'retrieving rack', 'storing total',...
%    'retrieving total'};



stevec = 1;
columns_data = [600,300,200,150,120,100];
depths_data = [1,2,3,4,5,6];

%3
%for columns = 100:100:300
for iii=1:6
    %5 steps
    for depth = 2:2
        %3 steps
        for relocating_strategy = 1:3
            %2 steps
            for storing_strategy = 1:3
                % 4 steps
                for fill_factor_alpha_steps = 1:10
                    for loading_time_factor = 1

                        disp(stevec)
                        
                        columns = columns_data(iii);
                        depth = depths_data(iii);
                        
                        racks = columns;
                        sides = 2;
                        tiers = 1;

                        %fill_factor_beta = (fill_factor_beta_steps -1) * 0.10;
                        
                        %fill_alpha = (fill_factor_beta-1+depth)/depth;
                        
                        fill_alpha = 0.45 + fill_factor_alpha_steps * 0.05;
                        
                        %loading_unloading_times = [6.94, 8.94, 10.94, 12.94, 14.94, 16.94 ...
                        %     18.94, 20.94, 22.94, 24.94, 26.94, 28.94, 30.94];
                        %loading_unloading_times = loading_unloading_times/loading_time_factor;
                        %loading_unloading_times = [4.5, 5.5, 6.5, 7.5, 8.5, 9.5];

                        %distance between hand-over and first bin
                        d_first_rack = 1.5;
                        %distance between storage bays
                        d_between_racks = 0.5;
                                            
                        d_between_depths = 0.7;
                        d_first_depth = 0.85;                       

                        %SHUTTLES__________________________________________________________________
                        %acceleration
                        a_s = 2; %m/s^2
                        %speed
                        v_max_s = 3; %m/s
                        
                        %SATELITE__________________________________________________________________
                        %acceleration
                        a_y = 1; %m/s^2
                        %speed
                        v_max_y = 1.5; %m/s
                                 
                        % time to pick-up a tote (pick-up time of first slot)
                        % loading_time_s = 4;
                        % additional time to pick-up tote from deeper slot 
                        % loading_time_additional_depth = 1;

                        WAREHOUSE = fill_the_warehouse_1_tier(depth,racks,sides,fill_alpha);

                        for extra_step=1:1000
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

                        tic
                        sim_results = sim('AVS_RS_SIMULINK_FIELDS_v11.slx', 3000000);
                        toc
                        
                        %results(depth - 1,relocation_strategy, fill_step, storing_strategy) = sim_results.throughput.data(end);
                        stevec = stevec + 1;

                        %results(stevec,:) = {columns, depth, relocating_strategy, storing_strategy, fill, sim_results.relocation_rack_1_way.data(end), ...
                        %    sim_results.relocation_depth_to.data(end), sim_results.relocation_depth_from.data(end), sim_results.frequency_of_relocation.data(end), ...
                        %    sim_results.empty_travel.data(end), sim_results.cycle_time.data(end), sim_results.storing_depth.data(end), sim_results.storing_rack.data(end), ...
                        %    sim_results.retrieving_depth.data(end),sim_results.retrieving_rack.data(end)};

                        results(stevec,:) = {columns, depth, relocating_strategy, storing_strategy, fill_alpha, ...
                            sim_results.relocation_time_rack.data(end), sim_results.relocation_time_depth_to.data(end), sim_results.relocation_time_depth_from.data(end), sim_results.frequency_of_relocation.data(end), ...
                            sim_results.empty_travel_time.data(end),...
                            sim_results.storing_time_depth.data(end), sim_results.storing_time_rack.data(end), ...
                            sim_results.retrieving_time_depth.data(end), sim_results.retrieving_time_rack.data(end),...
                            sim_results.cycle_time.data(end),...
                            sim_results.relocation_time_total.data(end)};
                    end
                end
            end
        end
    end
end

filename = 'results_for_JAKOB_3_deep.xlsx';
writecell(results, filename, 'Sheet', 1)














