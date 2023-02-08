function new_position_people = DECISION(position_to_be_updated,position_people,levels,walls,exit)
%INPUT ... %position_to_be_updated ... náhodně vybraný index buňky, jejíž okolí budeme
%aktualizovat v celé mřížce position_people...... NESMI TO BYT ZADNA Z
%BUNEK NA OKRAJI
%position_people ... tabulka 0 a 1 vyjadřující polohy lidí na
%mřížce
%levels ... tabulka potenciálů
%walls ... tabulka stěn a sloupů
%exit ... zvlast vypichnute souradnice vychodu
%OUTPUT ... new_position ... aktualizovaná mřížka position_people

new_position_people = position_people; %inicializace

%v patem sloupci promenne neighborhood jsou hodnoty potenciálů, případně
%NAN pro stěny, nebo sloupce
neighborhood = GET_OKOLI(position_to_be_updated,position_people,levels,walls);

if position_people(position_to_be_updated(1),position_to_be_updated(2)) == 1 %%%%%%nejdriv resim, pokud je ta vybrana bunka plna
    min_pot = min(neighborhood(:,5));

    %nalezeni radku s minimální hodnotou potencialu
    indeces_of_min_pot = find(neighborhood(:,5)==min_pot);
    %pocet radku s tim minimalnim potencialem
    [n_min_pots,~] = size(indeces_of_min_pot);
    %nejriv je snažíme tlacit na pole s minimalnim potencialem
    is_there_a_man = 0;
    is_there_a_wall = 0;
    for ind = 1:n_min_pots
        is_there_a_man(ind) = neighborhood(indeces_of_min_pot(ind),4);
        is_there_a_wall(ind) = neighborhood(indeces_of_min_pot(ind),3);
    end
    if sum(is_there_a_man) < n_min_pots && sum(is_there_a_wall) < n_min_pots %pokud bude mozny vubec nejaky pohyb do vrstvy s nizsim potencialem
        %pocet volnych bunek s nejnizsim potencialem
        free_spots = n_min_pots - sum(is_there_a_man);
        %nahodne vybere jednu v dostupnych volnych pozic
        r = randi(free_spots);
        %ted vyselektuju, kterou volnou pozici jsme vlastne vybrali
        free_spot_position = find(is_there_a_man == 0);
        selected_free_spot = free_spot_position(r);
        selected_neigh_row = neighborhood(indeces_of_min_pot(selected_free_spot),:);

        new_position_people(position_to_be_updated(1),position_to_be_updated(2)) = 0;
        new_position_people(selected_neigh_row(1),selected_neigh_row(2)) = 1;


    elseif  sum(is_there_a_man) == n_min_pots || sum(is_there_a_wall) == n_min_pots %pokud se nelze pohnout z duvodu preplnenosti nebo sten do vrstvy s nejnizsim potencialem
        sec_min_pot = min(neighborhood(:,5))+1;
        %nalezeni radku s druhou minimální hodnotou potencialu
        indeces_of_sec_min_pot = find(neighborhood(:,5)==sec_min_pot);
        %pocet radku s timto potencialem
        [n_sec_min_pots,~] = size(indeces_of_sec_min_pot);
        %nejdriv je snažíme tlacit na pole s minimalnim potencialem
        is_there_a_man = 0;
        is_there_a_wall = 0;
        for ind = 1:n_sec_min_pots
            is_there_a_man(ind) = neighborhood(indeces_of_sec_min_pot(ind),4);
            is_there_a_wall(ind) = neighborhood(indeces_of_sec_min_pot(ind),3);
        end
        if sum(is_there_a_man) < n_sec_min_pots && sum(is_there_a_wall) < n_sec_min_pots %pokud bude mozny vubec nejaky pohyb
            %pocet volnych bunek s nejnizsim potencialem
            free_spots = n_sec_min_pots - sum(is_there_a_man);
            %nahodne vybere jednu v dostupnych volnych pozic
            r = randi(free_spots);
            %ted vyselektuju, kterou volnou pozici jsme vlastne vybrali
            free_spot_position = find(is_there_a_man == 0);
            selected_free_spot = free_spot_position(r);
            selected_neigh_row = neighborhood(indeces_of_sec_min_pot(selected_free_spot),:);

            new_position_people(position_to_be_updated(1),position_to_be_updated(2)) = 0;
            new_position_people(selected_neigh_row(1),selected_neigh_row(2)) = 1;
        end

    end
else %aktualizace prazdne bunky je zalozena na tom, ze se tam prednostne tlaci spis lidi s vetsim potencialem a az potom ti na stejne urovni
    if isnan(neighborhood(5,5)) %5. radek pole neighborhood odpovida bodu, ktery prave aktualizujeme, 5. sloupec pokud ma hodnotu NAN znamena, ze je tam zed/sloup
        ;
    else
        max_pot = max(neighborhood(:,5));
        %nalezeni radku s maximalni hodnotou potencialu
        indeces_of_max_pot = find(neighborhood(:,5)==max_pot);
        %pocet radku s tim maximalnim potencialem
        [n_max_pots,~] = size(indeces_of_max_pot);
        is_there_a_man = 0;
        for ind = 1:n_max_pots
            is_there_a_man(ind) = neighborhood(indeces_of_max_pot(ind),4);
        end
        if sum(is_there_a_man) > 0 %pokud bude mozny vubec nejaky pohyb do vrstvy s nizsim potencialem
            %pocet plnych bunek s nejvyssim potencialem
            full_spots = sum(is_there_a_man);
            %nahodne vybere jednu z dostupnych plnych pozic
            r = randi(full_spots);
            %ted vyselektuju, kterou plnou pozici jsme vlastne vybrali
            full_spot_position = find(is_there_a_man == 1);
            selected_full_spot = full_spot_position(r);
            selected_neigh_row = neighborhood(indeces_of_max_pot(selected_full_spot),:);

            new_position_people(position_to_be_updated(1),position_to_be_updated(2)) = 1;
            new_position_people(selected_neigh_row(1),selected_neigh_row(2)) = 0;
        elseif sum(is_there_a_man) == 0 %z vrstvy s nejvyssim potencialem nema kdo sejit niz
            sec_max_pot = max(neighborhood(:,5))-1;
            %nalezeni radku s druhou nejvyssi hodnotou potencialu
            indeces_of_sec_max_pot = find(neighborhood(:,5)==sec_max_pot);
            %pocet radku s timto potencialem
            [n_sec_max_pots,~] = size(indeces_of_sec_max_pot);
            %nejdriv je snažíme tlacit na pole s minimalnim potencialem
            is_there_a_man = 0;
            for ind = 1:n_sec_max_pots
                is_there_a_man(ind) = neighborhood(indeces_of_sec_max_pot(ind),4);
            end
            if sum(is_there_a_man) > 0 %pokud bude mozny vubec nejaky pohyb
                %pocet plnych bunek s nejvyssim potencialem
                full_spots = sum(is_there_a_man);
                %nahodne vybere jednu z dostupnych plnych pozic
                r = randi(full_spots);
                %ted vyselektuju, kterou plnou pozici jsme vlastne vybrali
                full_spot_position = find(is_there_a_man == 1);
                selected_full_spot = full_spot_position(r);
                selected_neigh_row = neighborhood(indeces_of_sec_max_pot(selected_full_spot),:);

                new_position_people(position_to_be_updated(1),position_to_be_updated(2)) = 1;
                new_position_people(selected_neigh_row(1),selected_neigh_row(2)) = 0;
            elseif sum(is_there_a_man) == 0 %pokud ani z druheho nejvyssiho potencialu neni mozne sejit niz
                thrd_max_pot = max(neighborhood(:,5))-2;
                if thrd_max_pot >= neighborhood(5,5) %vezmu jeste treti mozny potencial, nesmi ale byt nizsi nez ten, ktery prislusi prazdne bunce, kterou se snazim aktualizovat
                    %nalezeni radku s treti nejvyssi hodnotou potencialu
                    indeces_of_thrd_max_pot = find(neighborhood(:,5)==thrd_max_pot);
                    %pocet radku s timto potencialem
                    [n_thrd_max_pots,~] = size(indeces_of_thrd_max_pot);
                    %nejdriv je snažíme tlacit na pole s minimalnim potencialem
                    is_there_a_man = 0;
                    for ind = 1:n_thrd_max_pots
                        is_there_a_man(ind) = neighborhood(indeces_of_thrd_max_pot(ind),4);
                    end
                    if sum(is_there_a_man) > 0 %pokud bude mozny vubec nejaky pohyb
                        %pocet plnych bunek s nejvyssim potencialem
                        full_spots = sum(is_there_a_man);
                        %nahodne vybere jednu z dostupnych plnych pozic
                        r = randi(full_spots);
                        %ted vyselektuju, kterou plnou pozici jsme vlastne vybrali
                        full_spot_position = find(is_there_a_man == 1);
                        selected_full_spot = full_spot_position(r);
                        selected_neigh_row = neighborhood(indeces_of_thrd_max_pot(selected_full_spot),:);

                        new_position_people(position_to_be_updated(1),position_to_be_updated(2)) = 1;
                        new_position_people(selected_neigh_row(1),selected_neigh_row(2)) = 0;
                    end
                end
            end
        end



    end

end
%pokud bude plna bunka se souradnicemi "exit", pred vykreslenim ji vzdy
%vyprazdnim

if new_position_people(exit(1),exit(2)) == 1
    new_position_people(exit(1),exit(2)) = 0;
end

end