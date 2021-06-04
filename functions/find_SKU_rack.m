function out_r = find_SKU_rack(SKU_ID, W)

[~,r,~,~] = ind2sub(size(W),find(W == SKU_ID));
out_r = r(1);

end