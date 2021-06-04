function out_d = find_SKU_depth(SKU_ID, W)

[d,~,~,~] = ind2sub(size(W),find(W == SKU_ID));
out_d = d(1);
end