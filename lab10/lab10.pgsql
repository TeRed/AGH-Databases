-- 10.1

SELECT DISTINCT nazwa 
FROM pudelka NATURAL JOIN zawartosc 
WHERE idczekoladki 
  IN (SELECT idczekoladki FROM czekoladki ORDER BY koszt LIMIT 3);
 
SELECT nazwa 
FROM czekoladki 
WHERE koszt = (SELECT MAX(koszt) FROM czekoladki);

SELECT p.nazwa, idpudelka 
FROM (SELECT idczekoladki FROM czekoladki ORDER BY koszt LIMIT 3) 
  AS ulubioneczekoladki 
NATURAL JOIN zawartosc 
NATURAL JOIN pudelka p;
 
SELECT nazwa, koszt, (SELECT MAX(koszt) FROM czekoladki) AS MAX FROM czekoladki;

-- 10.2

SELECT idklienta, idzamowienia, datarealizacji
FROM zamowienia
WHERE idklienta IN (SELECT idklienta from klienci WHERE nazwa LIKE '% Antoni');

-- 10.4

SELECT idpudelka, nazwa, opis, cena
FROM pudelka
WHERE idpudelka NOT IN
    (
        SELECT DISTINCT z.idpudelka
        FROM
            czekoladki c
            NATURAL JOIN zawartosc z
        WHERE c.czekolada = 'gorzka'
    );

SELECT idpudelka, nazwa, opis, cena
FROM pudelka
WHERE idpudelka NOT IN
    (
        SELECT DISTINCT z.idpudelka
        FROM
            czekoladki c
            NATURAL JOIN zawartosc z
        WHERE c.orzechy IS NOT NULL
    );

-- 10.5


