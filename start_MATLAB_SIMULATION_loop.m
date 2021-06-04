clear
clc
addpath('./functions/');

%racks=250;
sides=2;
tiers=1;

storing_strategy = 3;
relocating_strategy= 2;

stevec_1 = 2;

default_input={'columns', 'depth', 'fill factor beta', 'results'};

results_storing_depth(1,:) = default_input;
results_retrieving_depth(1,:) = default_input;
results_relocation_number(1,:) = default_input;
results_relo_depth_load(1,:) = default_input;
results_relo_depth_unload(1,:) = default_input;
results_storing_rack(1,:) = default_input;
results_retrieving_rack(1,:) = default_input;
results_relocation_rack(1,:) = default_input;
results_empty_travel(1,:) = default_input;



for fill_step = 1:9
    
    beta = 0.1*fill_step;
    
    %fill = 0.92 + (fill_step-1)*0.01;

    for racks = 100:50:300
        for depth = 2:8
            tic
            %disp(stevec_1)

            fill = (beta-1+depth)/depth;

            list_relo_depth_load = [];
            list_relo_depth_unload = [];
            list_relo_rack = [];
            list_storing_depth = [];
            list_storing_rack = [];
            list_retrieving_depth = [];
            list_retrieving_rack = [];
            list_relocation_number = [];
            list_empty_travel = [];
            stevec = 1;


            WAREHOUSE = fill_the_warehouse_1_tier(depth,racks,sides,fill);

            for extra_step=1:1000000



                [out_d, out_r, out_s] = STORING_strategy(storing_strategy, WAREHOUSE);
                list_storing_depth(extra_step)=out_d;
                list_storing_rack(extra_step)=out_r;
                WAREHOUSE(out_d, out_r, out_s) = max(max(max(WAREHOUSE)))+1;
                target_SKU = select_random_SKU_3D(WAREHOUSE);
                [goal_d, goal_r, goal_s] = find_SKU_position(target_SKU, WAREHOUSE);
                list_retrieving_depth(extra_step) = goal_d;
                list_retrieving_rack(extra_step) = goal_r;
                list_empty_travel(extra_step) = abs(goal_r-out_r);

                relo_counter = 0;

                [relo_d, relo_r, relo_s, relo_necessity] = relocation_necessity_test(WAREHOUSE, target_SKU);

                while relo_necessity ~= 0
                    relo_counter = relo_counter + 1;

                    [new_d, new_r, new_s] = RELOCATION_strategy(relocating_strategy,WAREHOUSE, relo_r, relo_s);

                    RELOCATING_SKU = WAREHOUSE(relo_d, relo_r, relo_s);
                    list_relo_depth_load(stevec) = relo_d;
                    WAREHOUSE(relo_d, relo_r, relo_s) = 0;

                    list_relo_rack(stevec) = abs(new_r - relo_r);



                    WAREHOUSE(new_d, new_r, new_s) = RELOCATING_SKU;
                    list_relo_depth_unload(stevec)=new_d;
                    [relo_d, relo_r, relo_s, relo_necessity] = relocation_necessity_test(WAREHOUSE, target_SKU);
                    stevec = stevec + 1;
                end
                
                list_relocation_number(extra_step) = relo_counter;
                WAREHOUSE(goal_d, goal_r, goal_s) = 0;
            end


            [~,results] = count_number_of_events(list_storing_depth);   
            results_storing_depth(stevec_1,:) = {racks, depth, beta, results};

            [~,results] = count_number_of_events(list_retrieving_depth);   
            results_retrieving_depth(stevec_1,:) = {racks, depth, beta, results};

            [~,results] = count_number_of_events(list_relocation_number);   
            results_relocation_number(stevec_1,:) = {racks, depth, beta, results};

            [~,results] = count_number_of_events(list_relo_depth_load);  
            results_relo_depth_load(stevec_1,:) = {racks, depth, beta, results};

            [~,results] = count_number_of_events(list_relo_depth_unload);   
            results_relo_depth_unload(stevec_1,:) = {racks, depth, beta, results};

            [~,results] = count_number_of_events(list_relo_rack);   
            results_relocation_rack(stevec_1,:) = {racks, depth, beta, results};
            
            [~,results] = count_number_of_events(list_storing_rack);   
            results_storing_rack(stevec_1,:) = {racks, depth, beta, results};
            
            [~,results] = count_number_of_events(list_retrieving_rack);   
            results_retrieving_rack(stevec_1,:) = {racks, depth, beta, results};
            
            [~,results] = count_number_of_events(list_empty_travel);   
            results_empty_travel(stevec_1,:) = {racks, depth, beta, results};

            stevec_1 = stevec_1 + 1
            toc
        end
    end
end



filename = 'results sto_RAND relo_NN.xlsx';
%filename = 'test.xlsx';
writecell(results_storing_depth, filename, 'Sheet', 1)
writecell(results_retrieving_depth, filename, 'Sheet', 2)
writecell(results_relo_depth_load, filename, 'Sheet', 3)
writecell(results_relo_depth_unload, filename, 'Sheet', 4)

writecell(results_storing_rack, filename, 'Sheet', 5)
writecell(results_retrieving_rack, filename, 'Sheet', 6)
writecell(results_empty_travel, filename, 'Sheet', 7)
writecell(results_relocation_rack, filename, 'Sheet', 8)

writecell(results_relocation_number, filename, 'Sheet', 9)





