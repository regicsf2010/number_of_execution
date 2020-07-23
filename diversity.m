function d = diversity(X, L, n)
    avg = mean(X);
    d =  sum(sqrt(sum(bsxfun(@minus, X, avg).^2, 2))) / (n * L);
end