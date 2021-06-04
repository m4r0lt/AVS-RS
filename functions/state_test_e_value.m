function [states, num_of_occur] = state_test_e_value(new_state)

[d,r,s]= size(new_state);

b_new_state = new_state > 0;


num_storage_slots = d*r*s;
num_occupied_storage_slots = sum(sum(sum(sum(new_state))));


alpha = num_occupied_storage_slots/num_storage_slots;




expected_E = zeros(d,s);



%loop for calculating (filling) E parameter
j = 1;
for i=1:num_occupied_storage_slots
    
    expected_E(j,1) = expected_E(j,1) + 1;
end


already_known = 0;

for i=1:num_states
    
    test_matrix = b_new_state == b_known_states(:,:,:,i); 
    
    if sum(sum(sum(test_matrix))) == num_storage_slots
        already_known = 1;
        num_of_occur(i) =  num_of_occur(i) +1;
    else
        continue
    end
    
end


if already_known == 0
    %disp('we have found a new matrix!')
    states = b_known_states;
    states(:,:,:,num_states+1) = b_new_state;
    num_of_occur(num_states+1) = 1;
    return
    
else
    %disp('this matrix (state) is not new')
    states = b_known_states;
    return
end

   

