function [X, V, G] = init(N, D, R, f)
    % particle variables
    X.X = R(1) + (R(2) - R(1)) .* rand(N, D); % position
    X.FIT = fitness(X.X, f);                 % fitness
    X.OFIT = X.FIT;                           % old fit
    X.G = zeros(N, D);                        % gradient
    X.C = zeros(N, 1);                        % counter
    X.I = zeros(N, 1);                        % decision    
    
    % velocities
    V = zeros(N, D);
    
    % best globlal position
    [G.FIT, i] =  min(X.FIT);
    G.X = X.X(i, :);    
end