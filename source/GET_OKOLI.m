function okoli = GET_OKOLI(ped,pozice_lidi,urovne,zdi)
%ped jsou souradnice bunky, kterou jsem se rozhodla aktualizovat, nesmi to
%byt z kraje mrizky, tam jsou proste steny
okoli = nan(9,5);
okoli(1,1) = ped(1)-1;
okoli(1,2) = ped(2)-1;
okoli(1,3) = zdi(okoli(1,1),okoli(1,2));
okoli(1,4) = pozice_lidi(okoli(1,1),okoli(1,2));
okoli(1,5) = urovne(okoli(1,1),okoli(1,2));


okoli(2,1) = ped(1)-1;
okoli(2,2) = ped(2);
okoli(2,3) = zdi(okoli(2,1),okoli(2,2));
okoli(2,4) = pozice_lidi(okoli(2,1),okoli(2,2));
okoli(2,5) = urovne(okoli(2,1),okoli(2,2));


okoli(3,1) = ped(1)-1;
okoli(3,2) = ped(2)+1;
okoli(3,3) = zdi(okoli(3,1),okoli(3,2));
okoli(3,4) = pozice_lidi(okoli(3,1),okoli(3,2));
okoli(3,5) = urovne(okoli(3,1),okoli(3,2));


okoli(4,1) = ped(1);
okoli(4,2) = ped(2)-1;
okoli(4,3) = zdi(okoli(4,1),okoli(4,2));
okoli(4,4) = pozice_lidi(okoli(4,1),okoli(4,2));
okoli(4,5) = urovne(okoli(4,1),okoli(4,2));


okoli(5,1) = ped(1);
okoli(5,2) = ped(2);
okoli(5,3) = zdi(okoli(5,1),okoli(5,2));
okoli(5,4) = pozice_lidi(okoli(5,1),okoli(5,2));
okoli(5,5) = urovne(okoli(5,1),okoli(5,2));


okoli(6,1) = ped(1);
okoli(6,2) = ped(2)+1;
okoli(6,3) = zdi(okoli(6,1),okoli(6,2));
okoli(6,4) = pozice_lidi(okoli(6,1),okoli(6,2));
okoli(6,5) = urovne(okoli(6,1),okoli(6,2));


okoli(7,1) = ped(1)+1;
okoli(7,2) = ped(2)-1;
okoli(7,3) = zdi(okoli(7,1),okoli(7,2));
okoli(7,4) = pozice_lidi(okoli(7,1),okoli(7,2));
okoli(7,5) = urovne(okoli(7,1),okoli(7,2));


okoli(8,1) = ped(1)+1;
okoli(8,2) = ped(2);
okoli(8,3) = zdi(okoli(8,1),okoli(8,2));
okoli(8,4) = pozice_lidi(okoli(8,1),okoli(8,2));
okoli(8,5) = urovne(okoli(8,1),okoli(8,2));


okoli(9,1) = ped(1)+1;
okoli(9,2) = ped(2)+1;
okoli(9,3) = zdi(okoli(9,1),okoli(9,2));
okoli(9,4) = pozice_lidi(okoli(9,1),okoli(9,2));
okoli(9,5) = urovne(okoli(9,1),okoli(9,2));

end

