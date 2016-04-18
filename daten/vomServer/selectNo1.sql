--#########################################################
-- s1 1330538
-- eine persnr wählen aus angestellten 
-- fanclub die im monat NICHT  von der persnr betreut wird
-- ausgabe: sid, namen von fanclub,

-- select sid, name
-- from zeitraum
-- where persnr!=1330538 
-- and Extract(month from ende) = Extract(month from CURRENT_DATE)
-- and Extract(year from ende) = Extract(year from CURRENT_DATE)-1
-- limit 25
-- ;

--#########################################################
-- s2
-- nachname, persnr
-- von angestellten
-- fanclub betreuen
-- sortiren nachname

-- select zeitraum.persnr, zeitraum.name, zeitraum.anfang, zeitraum.ende, person.nname
-- from zeitraum inner join person on zeitraum.persnr = person.persnr
-- WHERE ende >= '2015-04-01' and ende <= '2015-04-30'
-- order by person.nname ASC
-- ;

--#########################################################
-- s3

-- datum nur einmal
-- select namen.bezeichnung, datum, namen.nname, namen.vname, dauer
-- from beteiligtespieler inner join (select bezeichnung, person.nname, person.vname, spielerinmannschaft.persnr
									-- from spielerinmannschaft inner join person 
									-- on spielerinmannschaft.persnr = person.persnr
									-- order by bezeichnung) as namen
-- on beteiligtespieler.persnr = namen.persnr
-- where Extract(year from datum) = '2015'
-- order by datum
-- ;

--#########################################################
--s4
-- nname vname gesamt dauer
-- jahr 2015

-- select person.nname, person.vname, dauer
-- from beteiligtespieler inner join person 
-- on beteiligtespieler.persnr = person.persnr
-- WHERE Extract(year from datum) = 2015
-- limit 40
-- ;


select *
from beteiligtespieler
WHERE Extract(year from datum) = 2015
limit 40
;






