function set_of_neighbours = get_surroundings(i,j, index_mtx)
%% GET_SURROUNDINGS (function)
% pomocna funce pro funkci 'get_grad_field.m'
% vrati indexy vsech sousedicich dostupnych bunek (tj. jen takovych, 
% ktere nejsou stena ani sloup)
%
% INPUT:
%  - i,j ... souradnice bunky B
%  - index_mtx ... matice velikosti i strukturou shodna s realnou mapou
%   mistnosti 'map', tj. PxQ, je vytvarena ve funkci 'get_grad_field.m'
%
% OUTPUT:
%  - set_of_neighbours ... vektor cisel, predstavujici indexy vsech bunek v
%  okoli bunky B (indexy, ktere jim prirazuje matice 'index_mtx')
%
% Created by AG, 20230110

% Zasadni myslenka: na vstupu bude fce dostavat jen "povolena" i a j. 
% To znamena, ze se nemuze stat, ze by skenovaci okoli 3x3 "vypadlo" z nasi
% matice (ze bych se v kodu nize snazil pristupovat k prvkum matice, ktere 
% jsou mimo rozmer matice).

%% code goes here
set_of_neighbours = [];
size_of_index_mtx = size(index_mtx);
%if i == size_of_index_mtx(1) ||
for ii = i-1:i+1
    for jj = j-1:j+1
        if (ii < size_of_index_mtx(1) && jj < size_of_index_mtx(2) )
            if ( ~isnan(index_mtx(ii,jj)) && index_mtx(ii,jj) ~= index_mtx(i,j) )
                set_of_neighbours = [set_of_neighbours, index_mtx(ii,jj)];
            end
        end
    end
end

end