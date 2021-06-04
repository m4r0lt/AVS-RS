function [states, num_of_occur] = state_test(new_state, known_states, num_of_occur)

[d,r,s,num_states]= size(known_states);

b_new_state = new_state > 0;
b_known_states = known_states > 0;

expected_sum = d*r*s;
already_known = 0;

for i=1:num_states
    
    test_matrix = b_new_state == b_known_states(:,:,:,i); 
    
    if sum(sum(sum(test_matrix))) == expected_sum
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

   

