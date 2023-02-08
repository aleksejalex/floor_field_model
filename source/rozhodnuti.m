function rozhodnuti (ped, grid, j)
%% AG: opsano z prednasky, vubec nerucim za kvalitu..
okoli = get_okoli (ped, grid, j); % vrati okoli j-teho chodce (mtx 3x3) 

p = nan(9, 1);

for k = 1:9
    p(k) = okoli(k,3) * okoli(k,4) * exp(- okoli(k,5));
end

p = p/sum(p); %normalize prob.
p = cumsum(p); %cumulative distr.

% hodim si kostkou
r = rand()
% najdu prvni pr, ktera je vetsi nez nahodne cislo
pozice = find(p<r, 1, 'first')
% posunu chodce na misto, ktere odpovida teto prsti
ped(j, [3,4]) = okoli (pozice, pozice, [1,2]);  % je tam, kde chtel byt

end