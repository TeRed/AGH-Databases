-- 3.1

SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE dataRealizacji >= '2013-11-12' AND
      dataRealizacji <= '2013-11-20';


SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE (dataRealizacji >= '2013-12-01' AND
      dataRealizacji <= '2013-12-06')
      OR
      (dataRealizacji >= '2013-12-15' AND
      dataRealizacji <= '2013-12-20');

SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE dataRealizacji >= '2013-12-01' AND
      dataRealizacji <= '2013-12-31';

SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE date_part('month', dataRealizacji) = 11;

SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE date_part('month', dataRealizacji) = 11 OR
      date_part('month', dataRealizacji) = 12;

SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE extract(day FROM dataRealizacji) IN (17, 18, 19);

SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE extract(week FROM dataRealizacji) IN (46, 47);

-- 3.2

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'S%';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'S%i';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'S% m%';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa SIMILAR TO '(A|B|C)%';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa SIMILAR TO '%(O|o)rzech%';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa SIMILAR TO 'S%m%';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa SIMILAR TO '%(maliny|truskawki)%';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa NOT SIMILAR TO '([D-K]|S|T)%';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa SIMILAR TO 'Słod%';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa NOT SIMILAR TO '%[\s]%';

-- 3.3

SELECT *
FROM klienci
WHERE miejscowosc SIMILAR TO '% %';

SELECT *
FROM klienci
WHERE length(trim(telefon)) = 13;

SELECT *
FROM klienci
WHERE length(trim(telefon)) = 11;

-- 3.4

(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa >= 15 AND masa <= 24)
    UNION
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt >= 0.15 AND koszt <= 0.24);

(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa >= 25 AND masa <= 35)
    EXCEPT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt >= 0.25 AND koszt <= 0.35);

(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE (koszt BETWEEN 0.15 AND 0.24) AND
	  (masa BETWEEN 15 AND 24))
    UNION
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE (koszt BETWEEN 0.25 AND 0.35) AND
	  (masa BETWEEN 25 AND 35));

(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa >= 15 AND masa <= 24)
    INTERSECT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt >= 0.15 AND koszt <= 0.24);

(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa >= 25 AND masa <= 35)
    EXCEPT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE (koszt BETWEEN 0.15 AND 0.24) OR
	  (koszt BETWEEN 0.29 AND 0.35));

-- 3.5

(SELECT idklienta FROM klienci)
    EXCEPT
(SELECT idklienta FROM zamowienia);

(SELECT idpudelka FROM pudelka)
    EXCEPT
(SELECT idpudelka FROM artykuly);

(SELECT nazwa FROM klienci WHERE nazwa SIMILAR TO '%(rz|Rz)%')
    UNION
(SELECT nazwa FROM czekoladki WHERE nazwa SIMILAR TO '%(rz|Rz)%')
    UNION
(SELECT nazwa FROM pudelka WHERE nazwa SIMILAR TO '%(rz|Rz)%');

(SELECT idczekoladki FROM czekoladki)
    EXCEPT
(SELECT idczekoladki FROM zawartosc);





