function kth_row_of_graph_mtx = write_row(set_of_neighbours, num_of_cells)
%% WRITE_ROW
% pomocna funkce pro funkci 'get_grad_field.m'
% INPUT:
%   - set_of_neighbours ... cislovaci index volne bunky
%   - index_mtx ... matice velikosti i strukturou shodna s realnou mapou
%   mistnosti 'map', tj. PxQ, je vytvarena ve funkci 'get_grad_field.m'
%
% OUTPUT:
%   - i,j ... souradnice, na kterych se nachazi bunka, ocislovana indexem k
%
% Created by AG, 20230110

%% code goes below
kth_row_of_graph_mtx = [];

for j = 1:num_of_cells
    if isneighbour(j, set_of_neighbours)
        kth_row_of_graph_mtx = [kth_row_of_graph_mtx, 1];
    else
        kth_row_of_graph_mtx = [kth_row_of_graph_mtx, 0];  % puvodne to ma byt nula
    end
end

end
    