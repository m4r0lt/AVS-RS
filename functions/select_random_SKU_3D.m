function out = select_random_SKU_3D(W)

[d,r,s] = ind2sub(size(W), find(W > 0));
[number_of_hits, ~] = size(d);

if number_of_hits == 0
    disp('THERE ARE NO SKUs IN THE WAREHOSUE')
    out = 0;
    return
end

coin_toss = randi([1, number_of_hits]);

out_d = d(coin_toss);
out_r = r(coin_toss);
out_s = s(coin_toss);

out = W(out_d, out_r, out_s);

end




