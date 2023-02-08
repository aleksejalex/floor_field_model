function [num_of_peds, P, Q, mtx_loc_of_pillars, loc_of_exit, animation_show] = params_big_room_empty()
%% nastavi pouzivane konstanty - pro pohodlnejsi ladeni
% Konstanty:
%  - P ... sirka mistnosti (vertikalni smer)
%  - Q ... delka mistnosti (vodorovny smer)
%  - loc_of_exit ... poloha vychodu, tj. vektor o dvou souradnicich. NESMI
%  BYT VE ZDI, MUSI BYT V MISTNOSTI U ZDI
%  - mtx_loc_of_pillars ... polohy sloupu, tj. matice o velikosti 2xS, kde
%  S je pocet sloupu (horni radek matice jsou x-ove polohy sloupu, dolni
%  radek jsou y-ove polohy)

num_of_peds = 15;
P = 50;   % POZOR: V PRIPADE VYKRESLOVANI JE TREBA ZMENIT SKALOVANI Z 20000 NA 2000 !
Q = 40;

mtx_loc_of_pillars = [3, 4, 4, 5, 20, 21, 22, 23, 24; 
                      4, 6, 5, 5, 20, 20, 20, 20, 20];   
loc_of_exit = [3, 6]; 

animation_show = false;
end