function [num_of_peds, P, Q, mtx_loc_of_pillars, loc_of_exit, animation_show] = params()
%% nastavi pouzivane konstanty - pro pohodlnejsi ladeni
% Konstanty:
%  - P ... sirka mistnosti (vertikalni smer)
%  - Q ... delka mistnosti (vodorovny smer)
%  - loc_of_exit ... poloha vychodu, tj. vektor o dvou souradnicich. NESMI
%  BYT VE ZDI, MUSI BYT V MISTNOSTI U ZDI
%  - mtx_loc_of_pillars ... polohy sloupu, tj. matice o velikosti 2xS, kde
%  S je pocet sloupu (horni radek matice jsou x-ove polohy sloupu, dolni
%  radek jsou y-ove polohy)

num_of_peds = 5;
P = 7;            
Q = 8;            

mtx_loc_of_pillars = [3, 4, 4, 5; 
                      4, 6, 5, 5];   % tj. sloupy na pozicich (3,4), (4,6) a (5,5)
loc_of_exit = [4, 7];

animation_show = false;
end