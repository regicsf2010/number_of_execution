function p = findexecnumber(x, e)
%FINDEXECNUMBER Find Execution Number
% This method perfoms the definition of the number of execution based on
% the metric of the algorithm on each test function
% INPUT:
%   x: metric matrix
%   e: error theshold

% OUTPUT:
%   p: average number of exectuion required to converge

    avg_x = mean(x, 2);
    
    
    dd = abs(x - avg_x);
    p = zeros(1, size(x, 1));
    
    for i = 1 : size(x, 1)
       a = find(dd(i, :) < e);
       if(~isempty(a))
            p(i) = a(1);
       end
    end
    p(p == 0) = [];
    p = mean(p);
end

