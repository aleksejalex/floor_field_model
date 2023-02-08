function grad_field = get_grad_field (P, Q, loc_of_exit, mtx_loc_of_pillars)
%% GET_GRAD_FIELD (function)
% function that generates gradient field on map, based on given parameters
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
%  - grad_field ... matice o velikosti PxQ, kde plati:
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
%  - efektivita vyresena
%
% Created by AG, on 20230110
% Updated by AG, on 20230122

%% code goes below

%% inicializace: na zaklade vstupu vytvorime matici 'map', obsahujici steny a sloupy
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

%% ocisluji vsechna pole, na ktera lze vstoupit (vsechna pole, ktera nejsou zed nebo sloup)
num_of_cells = 0;
index_mtx = nan(P,Q);
grad_field = nan(P,Q);
n = 1;

for i=1:P
    for j=1:Q
        if map(i,j) == 0
            num_of_cells = num_of_cells + 1;
            index_mtx(i,j) = n;
            grad_field(i,j) = inf;
            n = n + 1;
        end
    end
end

grad_field(loc_of_exit_x, loc_of_exit_y) = 0;

% num_of_cells ... pocet bunek, na ktere lze (v principu) vkrocit
% index_mtx    ... matice PxQ, vsechny bunky, na ktere lze vkrocit, jsou
%                  postupne ocislovany od 1 do num_of_cells

%% teorie grafu: vytvorime "matici prechodu"
% tj. matici o velikosti num_of_cells x num_of_cells, kde (i,j)-ty prvek je
% roven 0, pokud se z bunky 'i' do bunky 'j' nelze dostat jednim krokem, a
% je roven 1, pokud lze
% Jinymi slovy: pokud bunka 'i' sousedi s bunkou 'j', pak graph_mtx(i,j)=1.
% Pokud nesousedi, graph_mtx(i,j)=0.

%graph_mtx = nan(num_of_cells, num_of_cells);
graph_mtx = [];

for k=1:num_of_cells   % k probiha vsechny bunky, na ktere lze vkrocit
    [i,j] = get_coords(k, index_mtx); % pro k-tou bunku najdu jeji souradnice
    set_of_neighbours = get_surroundings(i,j, index_mtx); % najdu mnozinu sousedu bunky s indexem k
    kth_row_of_graph_mtx = write_row(set_of_neighbours, num_of_cells);
    graph_mtx = [graph_mtx; kth_row_of_graph_mtx];
end
    
%% Dijkstra (shortest path algorithm)  ... podle stazene fce
grad_field = zeros(P,Q);  % inicializace: vsechny cesty jsou nekonecne
l = index_mtx(loc_of_exit_x, loc_of_exit_y); % pozor / je to index :L:, ne jednicka

for k=1:num_of_cells  
    [i,j] = get_coords(k, index_mtx); % pro k-tou bunku najdu jeji souradnice
    grad_field(i,j) = dijkstra(graph_mtx, k, l);
end

grad_field = grad_field + map; % protoze dijkstra za sebou zanechava 
                               % nuly nejen tam, kde byl vychod, ale i 
                               % tam, kde jsou steny a sloupy

end
