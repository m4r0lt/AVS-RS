function WAREHOUSE = fill_the_warehouse_1_tier(depth,racks,sides,fill)

WAREHOUSE = zeros(depth,racks,sides);

%WAREHOUSE = zeros(depth,60,2,1);
%new_positions = zeros(depth*racks*sides, 4);
% 
%PARTLY FILL THE WAREHOUSE_________________________________________________
SKU_num = round(depth*racks*sides*fill);
SKU_ids = [1:SKU_num];
SKU_ids = SKU_ids(randperm(length(SKU_ids)));

stevec = 1;
stevec_3 = 1;

for i=depth:-1:1
    positions = zeros(racks*sides,3);
    racks_shuffled = [1:racks];
    racks_shuffled = racks_shuffled(randperm(length(racks_shuffled)));
    
    for j=racks_shuffled
        for k=1:sides
           positions(stevec,:) = [i,j,k];
           stevec = stevec + 1;
        end
    end
    
    for position = 1:(stevec-1)
        position_vecktor = positions(position,:);
        dd = position_vecktor (1);
        rr = position_vecktor (2);
        ss = position_vecktor (3);
        WAREHOUSE(dd, rr, ss) = SKU_ids(stevec_3);
        stevec_3 = stevec_3 + 1;
        if stevec_3 > length(SKU_ids)
            return
        end
        
    end
    stevec = 1;
    %new order
end


