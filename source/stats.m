function rho = stats(P, Q, pillars, pedestrians)
%% Parametre
n_pillars  = size(pillars, 2);                      % počet stĺpov
max_people = (P - 2)*(Q - 2) - n_pillars;           % kapacita miestnosti (počet buniek bez stien a stĺpov)

%% Výpočet
rho = sum(pedestrians, 'all')/max_people;           % výsledná hustota v danom čase

end