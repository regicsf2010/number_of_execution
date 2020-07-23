function [G] = updates1(X, XFIT, G)
    if(XFIT < G.FIT)
        G.X = X;
        G.FIT = XFIT;        
    end
end

