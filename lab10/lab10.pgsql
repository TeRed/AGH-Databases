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
WHERE idklienta IN (SELECT idklienta FROM klienci WHERE nazwa LIKE '% Antoni');

SELECT idklienta, idzamowienia, datarealizacji
FROM zamowienia
WHERE idklienta IN (SELECT idklienta FROM klienci WHERE ulica LIKE '% %/%');

SELECT idklienta, idzamowienia, datarealizacji
FROM zamowienia
WHERE idklienta IN (
    SELECT idklienta
    FROM klienci
    WHERE miejscowosc = 'Kraków'
)
AND date_part('month', datarealizacji) = 11
AND date_part('year', datarealizacji) = 2013;

-- 10.4

SELECT idpudelka, nazwa, opis, cena
FROM pudelka p
WHERE EXISTS (
    SELECT 1
    FROM zawartosc z
    WHERE p.idpudelka = z.idpudelka
    AND idczekoladki = 'd09'
);

SELECT idpudelka, nazwa, opis, cena
FROM pudelka p
WHERE EXISTS (
    SELECT 1
    FROM zawartosc z NATURAL JOIN czekoladki c
    WHERE p.idpudelka = z.idpudelka
    AND c.nazwa = 'Gorzka truskawkowa'
);

SELECT idpudelka, nazwa, opis, cena
FROM pudelka p
WHERE EXISTS (
    SELECT 1
    FROM zawartosc z NATURAL JOIN czekoladki c
    WHERE p.idpudelka = z.idpudelka
    AND c.nazwa SIMILAR TO 'S%'
);

SELECT idpudelka, nazwa, opis, cena
FROM pudelka p
WHERE EXISTS (
    SELECT 1
    FROM zawartosc z
    WHERE p.idpudelka = z.idpudelka
    AND z.sztuk >= 4
);

SELECT idpudelka, nazwa, opis, cena
FROM pudelka p
WHERE EXISTS (
    SELECT 1
    FROM zawartosc z NATURAL JOIN czekoladki c
    WHERE p.idpudelka = z.idpudelka
    AND c.nazwa = 'Gorzka truskawkowa'
    AND z.sztuk >= 3
);

SELECT idpudelka, nazwa, opis, cena
FROM pudelka p
WHERE EXISTS (
    SELECT 1
    FROM zawartosc z NATURAL JOIN czekoladki c
    WHERE p.idpudelka = z.idpudelka
    AND c.nadzienie = 'truskawki'
);

SELECT idpudelka, nazwa, opis, cena
FROM pudelka
WHERE idpudelka NOT IN (
    SELECT z.idpudelka
    FROM
        czekoladki c
        NATURAL JOIN zawartosc z
    WHERE c.czekolada = 'gorzka'
);

SELECT idpudelka, nazwa, opis, cena
FROM pudelka
WHERE idpudelka NOT IN (
    SELECT z.idpudelka
    FROM
        czekoladki c
        NATURAL JOIN zawartosc z
    WHERE c.orzechy IS NOT NULL
);

SELECT idpudelka, nazwa, opis, cena
FROM pudelka
WHERE idpudelka IN (
    SELECT z.idpudelka
    FROM
        czekoladki c
        NATURAL JOIN zawartosc z
    WHERE c.nadzienie IS NOT NULL
);

-- 10.5

SELECT idczekoladki, nazwa, koszt
FROM czekoladki
WHERE koszt > (
    SELECT koszt
    FROM czekoladki
    WHERE idczekoladki = 'd08'
);

SELECT DISTINCT k.nazwa
FROM
    klienci k 
    NATURAL JOIN zamowienia
    NATURAL JOIN artykuly
    JOIN pudelka p USING(idpudelka)
WHERE p.idpudelka IN (
    SELECT p.idpudelka
    FROM
        klienci k 
        NATURAL JOIN zamowienia
        NATURAL JOIN artykuly
        JOIN pudelka p USING(idpudelka)
    WHERE k.nazwa = 'Górka Alicja'
);

SELECT DISTINCT k.nazwa, k.miejscowosc
FROM
    klienci k 
    NATURAL JOIN zamowienia
    NATURAL JOIN artykuly
    JOIN pudelka p USING(idpudelka)
WHERE p.idpudelka IN (
    SELECT p.idpudelka
    FROM
        klienci k 
        NATURAL JOIN zamowienia
        NATURAL JOIN artykuly
        JOIN pudelka p USING(idpudelka)
    WHERE k.miejscowosc = 'Katowice'
);

-- 10.6

SELECT p.nazwa, SUM(z.sztuk)
FROM
    pudelka p
    NATURAL JOIN zawartosc z
GROUP BY p.idpudelka, p.nazwa
HAVING SUM(z.sztuk) >= ALL (
    SELECT SUM(z.sztuk)
    FROM
        pudelka p
        NATURAL JOIN zawartosc z
    GROUP BY p.idpudelka
);

SELECT p.nazwa, SUM(z.sztuk)
FROM
    pudelka p
    NATURAL JOIN zawartosc z
GROUP BY p.idpudelka, p.nazwa
HAVING NOT SUM(z.sztuk) > ANY (
    SELECT SUM(z.sztuk)
    FROM
        pudelka p
        NATURAL JOIN zawartosc z
    GROUP BY p.idpudelka
);

SELECT p.nazwa, SUM(z.sztuk)
FROM
    pudelka p
    NATURAL JOIN zawartosc z
GROUP BY p.idpudelka, p.nazwa
HAVING SUM(z.sztuk) > (
    SELECT AVG(sztk)
    FROM (
        SELECT SUM(z.sztuk) sztk
        FROM
            pudelka p
            NATURAL JOIN zawartosc z
        GROUP BY p.idpudelka
    ) sum_sztk
);

WITH T AS (
    SELECT SUM(z.sztuk) sztk
    FROM
        pudelka p
        NATURAL JOIN zawartosc z
    GROUP BY p.idpudelka
)
SELECT p.nazwa, SUM(z.sztuk)
FROM
    pudelka p
    NATURAL JOIN zawartosc z
GROUP BY p.idpudelka, p.nazwa
HAVING SUM(z.sztuk) = (
    SELECT MAX(T.sztk)
    FROM T
) OR SUM(z.sztuk) = (
    SELECT MIN(T.sztk)
    FROM T
);

-- 10.7

