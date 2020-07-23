function [v] = cumsuccessrate(sr)    
    s = 1 : length(sr);
    v = cumsum(sr) ./ s;
end