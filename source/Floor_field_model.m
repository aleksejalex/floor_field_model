%% FLOOR FIELD MODEL - spousteci skript

%% uklid
close all
clear variables

%% Nastaveni konstant (pomoci fce 'params.m')
% lze vytvorit nekolik ruznych sad pocatecnich parametru, treba fce
% 'params1.m', 'params2.m' atd)

params = parameters(4);
P = params.P;
Q = params.Q;
loc_of_exit = params.exit;
mtx_loc_of_pillars = params.pillars;
num_of_peds = params.pedestrians;

%[num_of_peds, P, Q, mtx_loc_of_pillars, loc_of_exit, animation_show] = params();
%[num_of_peds, P, Q, mtx_loc_of_pillars, loc_of_exit, animation_show] = params_big_room_full();  % pozor: Dijkstra bezi cca 4min na tak velke mape
%[num_of_peds, P, Q, mtx_loc_of_pillars, loc_of_exit, animation_show] = params_big_room_empty(); % pozor: Dijkstra bezi cca 4min na tak velke mape

animation_show = true;
%% Nastaveni mapy, rozmisteni sloupu a sten
walls = double(isnan(get_map (P, Q, loc_of_exit, mtx_loc_of_pillars)));  % AG: melo by to vratit mapu, kde na vsech "nevkrocitelnych" polich je 1, a na volnych 0
% nevim, kde presne se to pouzije, ale jestli je potreba, tak tu je.

%% -------------------------- simulace FFM
n_simulations = 30;                         % počet simulácií
iterations    = ones(n_simulations, 1);     % počet krokov do úplnej evakuácie miestnosti
rho           = [];                         % prázdne pole pre ukladanie hustôt

rng(1)                                      % pevný seed

for i = 1:n_simulations
    %% Vypocet potencialu na mape (fce 'get_grad_field.m' od AG)
    tStart = tic;
    levels = get_grad_field(P, Q, loc_of_exit, mtx_loc_of_pillars);  % Dijkstra runs inside
    tEnd = toc(tStart)
    'log: get_grad_field.m successfully done'
    
    %% Umisteni chodcu do mistnosti (fce 'get_pedestrians.m' od SM)
    position_people = get_pedestrians(P, Q, mtx_loc_of_pillars, num_of_peds);
    'log: get_pedestrians.m successfully done'
    
    %% Pomocna matice pro vykresleni polohy exitu zelenou barvou
    exit_matrix = 0*position_people; %stejne rozmery jako matice position people
    exit_matrix(loc_of_exit(1),loc_of_exit(2)) = 1;

    while (sum(sum(position_people)) ~= 0)
        [row_num,col_num] = size(position_people);
        %budu se snazit generovat cisla pouze z te zaplnene casti, abych to
        %urychlila
        first_nonempty_col = 1;
        while sum(position_people(:,first_nonempty_col)) == 0 && (first_nonempty_col + 1) <= (col_num - 1)
            first_nonempty_col = first_nonempty_col + 1;
        end
        
        %ind_row a ind_col budou indexy bunky, kterou prave aktualizuju, nesmi
        %to byt nic z okraju pole
        ind_row = randi([2,row_num-1]);
        ind_col = randi([first_nonempty_col,col_num-1]);
        
        position_people = DECISION([ind_row,ind_col],position_people,levels,walls,loc_of_exit);
        R = 255 * (-position_people+1) - 255*exit_matrix;
        G = 255 * (-position_people+1)-255*walls;
        B = 255 * (-position_people+1)-255*walls - 255*exit_matrix;
        res = cat(3,R,G,B);
        
%         %plot result
%              if animation_show == true
%                  imshow(res,'InitialMagnification',20000)
%                  pause(0.07);
%              end
        
        % Hustota chodcov v miestnosti v danej iterácii
        rho = [rho; stats(P, Q, mtx_loc_of_pillars, position_people)];
        
        iterations(i) = iterations(i)+1;
    end
end

% Stredný počet krokov potrebný pre evakuáciu miestnosti
[mu, delta] = expectation(iterations, n_simulations);
histogram(iterations)
xlabel("number of steps",'interpreter','latex')
ylabel("frequency",'interpreter','latex')
set(gca,'TickLabelInterpreter','latex')

'Done.'















