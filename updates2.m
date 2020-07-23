function [X] = updates2(X, G, CMAX, N)
    for i = 1 : N
        if(X.I(i) == 0) % gradient
            if(abs(X.FIT(i) - X.OFIT(i)) < 1e-2 || norm(X.G(i, :)) < 1e-2)
                X.C(i) = X.C(i) + 1;
                if(X.C(i) == CMAX)
                    X.I(i) = 1;
                    X.C(i) = 0;
                end
%             else
%                 X.C(i) = 0;
            end
        else % global
            D = X.X(i, :) - G;
            if(sqrt(D * D') < 1e-5)
                X.I(i) = 0;
                X.C(i) = 0;
            end
        end
    end
    
end