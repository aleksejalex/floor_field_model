function map = get_map (P, Q, loc_of_exit, mtx_loc_of_pillars)
%% GET_MAP (function)
% function that generates map, based on given parameters
%
% INPUT:
%  - Q ... delka mistnosti (vodorovny smer)
%  - P ... sirka mistnosti (vertikalni smer)
%  - loc_of_exit ... poloha vychodu, tj. vektor o dvou souradnicich. NESMI
%  BYT VE ZDI, MUSI BYT V MISTNOSTI U ZDI
%  - mtx_loc_of_pillars ... polohy sloupu, tj. matice o velikosti 2xS, kde
%  S je pocet sloupu
%
% OUTPUT:
%  - map ... matice o velikosti PxQ, kde plati:
%     -- pole s vychodem ma hodnotu 0
%     -- pole, na ktere nelze vstoupit (zed nebo sloup) ma
%        hodnotu NaN
%     -- pole, na ktera vstoupit lze, maji hodnotu,
%        odpovidajici minimalnimu poctu kroku, kterych je
%        potreba pro dosazeni vychodu
%
% KNOWN PROBLEMS:
%  - chybi kontrola vstupu. Ocekava se, ze funkce dostane to, co ocekava.
%  Pridat?...
%
% Created by AG, on 20230122

%% code goes below
map = nan(P,Q);
for i=2:P-1
    for j=2:Q-1
        map(i,j) = 0;
    end
end

loc_of_exit_x = loc_of_exit(1);
loc_of_exit_y = loc_of_exit(2);
map(loc_of_exit_x, loc_of_exit_y) = 0;

size_mtx_loc_of_pillars = size(mtx_loc_of_pillars);
num_of_pillars = size_mtx_loc_of_pillars(2);

for pillar = 1:num_of_pillars
    loc_of_pillar_x = mtx_loc_of_pillars(1,pillar);
    loc_of_pillar_y = mtx_loc_of_pillars(2,pillar);
    map(loc_of_pillar_x, loc_of_pillar_y) = NaN;
end





end