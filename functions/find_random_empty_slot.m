function [out_d, out_r, out_s] = find_random_empty_slot(floor)

[depth,racks,sides] = size(floor);

%define d,r,s size 
d=zeros(1,sum(sum(floor(1,:,:)==0)));
r=zeros(1,sum(sum(floor(1,:,:)==0)));
s=zeros(1,sum(sum(floor(1,:,:)==0)));

stevec = 1;
for i=1:racks
    for j=1:sides
        for k = depth:-1:1 
            if floor(k,i,j)==0
                d(stevec) = k;
                r(stevec) = i;
                s(stevec) = j;
                stevec = stevec + 1;
                break
            end
        end
    end
end

if ~isempty(d)
    coin_toss = randi([1, length(d)]);
    out_d = d(coin_toss);
    out_r = r(coin_toss);
    out_s = s(coin_toss);
    return
end

    

out_d = 0;
out_r = 0;
out_s = 0;
disp('THERE ARE NO MORE EMPTY SLOTS')

end
