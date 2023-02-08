function room = get_pedestrians(grid_length, grid_width, pillars, n_pedestrians)
%% HELP
% get_pedestrians   ... function used to generate initial positions of a given number of pedestrians 
%
% Input arguments:
% grid_length       ... first array dimension (ie. number of rows)
% grid_width        ... second array dimension (ie. number of columns)
% pillars           ... array of pillar coordinates
% n_pedestrians     ... number of pedestrians
%
% Output argument:
% room              ... array with generated pedestrians
%% Code
max_pedestrians = (grid_length - 2)*(grid_width - 2) - size(pillars, 2);% disposable room area (excludes walls and pillars)
pillar_cells    = grid_length*(pillars(2,:) - 1) + pillars(1,:);        % pillars locations (converted to single subscript indexation)

% Error message
if n_pedestrians > max_pedestrians                              % two pedestrians cannot share the same cell
    disp("Room capacity too low.")

% Generating pedestrians
else
    % Create an empty array
    room = zeros(grid_length, grid_width);                      % empty array to be filled with pedestrians
    
    % Pillars in the same positions as the pedestrians?
    while sum(room, "all") ~= n_pedestrians
        pedestrians = zeros(grid_length - 2, grid_width - 2);   % auxiliary array to be filled with pedestrians (no walls or pillars)
        position = randperm(max_pedestrians, n_pedestrians);    % generating pedestrian positions
        pedestrians(position) = 1;                              % inserting pedestrians
        room(2:grid_length-1, 2:grid_width-1) = pedestrians;    % inserting pedestrian array inside walls
        
        % Insert pillars
        room(pillar_cells) = 0;
    end
end
end