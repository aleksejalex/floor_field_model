function data = parameters(i)
%% Fixné parametre
%  - P ... sirka mistnosti (vertikalni smer)
%  - Q ... delka mistnosti (vodorovny smer)
%  - exit ... poloha vychodu, tj. vektor o dvou souradnicich. NESMI
%  BYT VE ZDI, MUSI BYT V MISTNOSTI U ZDI
%  - pillars ... polohy sloupu, tj. matice o velikosti 2xS, kde
%  S je pocet sloupu (horni radek matice jsou x-ove polohy sloupu, dolni
%  radek jsou y-ove polohy)

exit   = [5, 9];
n_peds = 30;
P      = 10;        
Q      = 10;

%% Rozmiestnenie stĺpov v miestnosti
switch i
    case 1
        pillars = [3, 4, 4, 5; 
                   4, 6, 5, 5];     % pôvodné nastavenie stĺpov
        
    case 2
        pillars = [4; 
                   7];              % umiestnenie stĺpu pred východ
               
    case 3
        pillars = [3, 4, 5, 6, 7;
                   7, 7, 7, 7, 7];  % zabarikádovanie východu
               
    case 4
        pillars = [7, 7, 7, 7, 7;
                   3, 4, 5, 6, 7];  % barikada dalej od východu
end

%% Vytvorenie štruktúry
data = struct('P',P,'Q',Q,'exit',exit,'pedestrians',n_peds,'pillars',pillars);
end