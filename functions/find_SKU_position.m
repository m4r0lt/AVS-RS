function [out_d,out_r, out_s] = find_SKU_position(SKU_ID, W)


[d,r,s,~] = ind2sub(size(W),find(W == SKU_ID));

out_d = d(1);
out_r = r(1);
out_s = s(1);


end