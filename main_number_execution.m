%% Method to select the minimum number of execution
close, clear, clc

E = 500;
T = 1000;

fids = [1, 3, 4, 5, 9, 10, 25, 26, 27, 28];
names = {'Bent Cigar', 'Zakharov', ...
         'Rosenbrock', 'Rastrigin', ...
         'Levy', 'Schwefel', ...
         'Composition 5', 'Composition 6', ...
         'Composition 7', 'Composition 8'};
     
nf = length(fids);
sr = zeros(nf, E); % success rate
cum_sr = zeros(nf, E);

for i = 1 : nf
    
    for j = 1 : E
        sr(i, j) = main(fids(i), T);
        disp(['fid = ' num2str(i) ' | ' 'Exec = ' num2str(j)]);
    end
    cum_sr(i, :) = cumsuccessrate(sr(i, :));
end



avg_sr = mean(cum_sr);
std_sr = std(cum_sr);

%% Plot curves of success rate
figure, hold on, box on, grid on
set(gca,'FontSize', 14)
h = zeros(1, nf);
for i = 1 : nf
   h(i) = plot(cum_sr(i, :), 'linewidth', 2);
end
ylim([0 1.05])
xlabel('Number of experiments (E)')
ylabel('Success rate')
l = legend(h(:), names);
l.FontSize = 9;
l.Location = 'southeast';
hold off
save sr.mat sr
save cum_sr.mat cum_sr
print('sr', '-depsc')

%% Plot average curve of success rate
figure, hold on, box on, grid on
set(gca,'FontSize', 14)
shadedErrorBar(1 : E, avg_sr, std_sr, {'-b', 'linewidth', 2'});
set(gca,'FontSize', 14)
p = round(findexecnumber(cum_sr, 1e-4));
stem(p, avg_sr(p), 'linewidth', 2)
txt = ['\downarrow E_{' num2str(p) '} = ' num2str(avg_sr(p))];
text(p - 5, avg_sr(p) + .07, txt, 'Color', 'red', 'FontSize', 14)
xlabel('Number of experiments (E)')
ylabel('Average success rate')
print('sr_avg', '-depsc')

