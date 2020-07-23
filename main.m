% close, clear, clc
function [sr] = main(idf, T)

%% Parameters
% function
D = 2;
% FNAME = 'rosenbrock';
% f = str2func(FNAME);
faux = str2func('cec17_func');
f = @(z) faux(z', idf);
g = load('g_opt.mat'); g_opt = g.g_opt;
RANGE = [-100, 100];

% PSO parameters
N = 20;
% T = 1000;
STOPC = 1e-2;

CMAX = 3;
DT = [1e-2 .25];
dir = 1; % attractive as default

alpha = 3;

params = struct('IW', .7298, 'SC', 1.4962, 'GC', 1e-2, 'd', D, 'a', alpha * pi / 180, 'i', eye(D));

%% Main iteration
L = norm(ones(1, D) * (RANGE(2) - RANGE(1))); % diagonal length of the space
[X, V, G] = init(N, D, RANGE, f);

%% Aux variables
divs = zeros(1, T);
sr = 0; % no success

for i = 1 : T
    for j = 1 : N
        if(X.I(j) == 0), X.G(j, :) = gradient(f, X.X(j, :)); end
        V(j, :) = velocity(X.X(j, :), V(j, :), X.G(j, :), G, X.I(j), params, dir, D);        
        X.X(j, :) = X.X(j, :) + V(j, :);        
        X.FIT(j) = f(X.X(j, :));
        [G] = updates1(X.X(j, :), X.FIT(j), G);        
    end
    
    X = updates2(X, G.X, CMAX, N);
    X.OFIT = X.FIT;
    
    divs(i) = diversity(X.X, L, N);
    [dir, X.I] = updates3(dir, divs(i), X.I, DT, N);

    if((G.FIT - g_opt(idf)) <= STOPC)
        sr = 1;
        break
    end
end
end
