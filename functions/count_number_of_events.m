function [indeksi,stevci] = count_number_of_events(considering_list)

    considering_list =sort(considering_list);
    indeksi = 0:max(considering_list);
    
    stevci = zeros(1,max(considering_list)+1);
    
    j=1;
    for i=indeksi
        stevci(j) = sum(considering_list == i);
        j=j+1;
    end
    
    stevci = stevci/sum(stevci);

    
end