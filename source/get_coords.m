function [i,j] = get_coords(k, index_mtx)
%% GET_COORDS (funkce)
% pomocna funkce pro funkci 'get_grad_field.m'
% INPUT:
%   - k ... cislovaci index volne bunky
%   - index_mtx ... matice velikosti i strukturou shodna s realnou mapou
%   mistnosti 'map', tj. PxQ, je vytvarena ve funkci 'get_grad_field.m'
%
% OUTPUT:
%   - i,j ... souradnice, na kterych se nachazi bunka, ocislovana indexem k
%
% Created by AG, 20230110

%% code goes below
i = NaN;
j = NaN;
size_of_index_mtx = size(index_mtx);

for ii = 1:size_of_index_mtx(1)
    for jj = 1:size_of_index_mtx(2)
        if index_mtx(ii,jj) == k
            %return i,j
            i = ii;
            j = jj;
        end
    end
end

if ( isnan(i) || isnan(j) )
    error('Error in get_coords(): such k was not found in given matrix index_mtx. Abort.')
end

end