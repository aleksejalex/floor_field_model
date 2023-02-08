function bool = isneighbour(j, set_of_neighbours)
%% ISNEIGHBOUR (fce)
% pomocna funkce pro funkci 'write_row.m'
%
% projdu cely 'set_of_neighbours', a kazdy prvek porovnam s danym 'j'.
% Pokud ho najdu, vratim bool=true, jinak vratim bool=false.
%
% Created by AG, 20230110

bool = false;  % apriori jako ze jsem ho nenasel
jjj = 1;

while ( jjj<=length(set_of_neighbours) && bool==false )
    if set_of_neighbours(jjj) == j
        bool = true;
    else
        bool = false;
    end
    jjj = jjj+1;
end

end