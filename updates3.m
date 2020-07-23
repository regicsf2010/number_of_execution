function [dir, I] = updates3(dir, div, I, t, N)
    if(dir > 0 && div < t(1)) % must repulse
        dir = -1;
        I = ones(N, 1);
    elseif(dir < 0 && div > t(2)) % must attract
        dir = 1;
        I = zeros(N, 1);
    end
end