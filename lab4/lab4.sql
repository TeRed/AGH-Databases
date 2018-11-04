-- 4.1

SELECT k.nazwa FROM klienci k;

SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z;

SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z  
WHERE z.idklienta = k.idklienta;

SELECT k.nazwa, z.idzamowienia FROM klienci k NATURAL JOIN zamowienia z;

SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
ON z.idklienta=k.idklienta;

SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
USING (idklienta);

Odp.:
1: 2, 3 (filtrowany później)
2: 1 (powtórzenia), 2

-- 4.2

SELECT k.nazwa, z.idzamowienia, z.datarealizacji
FROM klienci k NATURAL JOIN zamowienia z
WHERE k.nazwa LIKE '% Antoni';

SELECT k.ulica, z.idzamowienia, z.datarealizacji
FROM klienci k NATURAL JOIN zamowienia z
WHERE k.ulica LIKE '%/%';

SELECT k.miejscowosc, z.idzamowienia, z.datarealizacji
FROM klienci k NATURAL JOIN zamowienia z
WHERE   k.miejscowosc = 'Kraków' AND
        date_part('year', z.datarealizacji) = 2013 AND
        date_part('month', z.datarealizacji) = 11;

-- 4.3

SELECT  k.nazwa, k.ulica, k.miejscowosc,
        z.datarealizacji
FROM klienci k NATURAL JOIN zamowienia z
WHERE date_part('year', NOW()) - date_part('year', z.datarealizacji) > 5

SELECT  k.nazwa, k.ulica, k.miejscowosc,
        p.nazwa
FROM    klienci k NATURAL JOIN
        zamowienia NATURAL JOIN
        artykuly JOIN
        pudelka p USING(idpudelka)
WHERE p.nazwa in ('Kremowa fantazja','Kolekcja jesienna');

SELECT  k.nazwa, k.ulica, k.miejscowosc,
        z.idklienta
FROM klienci k NATURAL JOIN zamowienia z
ORDER BY 1;

SELECT  k.nazwa, k.ulica, k.miejscowosc,
        z.idklienta
FROM klienci k LEFT JOIN zamowienia z USING(idklienta)
WHERE z.idklienta IS NULL;

SELECT  k.nazwa, k.ulica, k.miejscowosc,
        z.datarealizacji
FROM klienci k NATURAL JOIN zamowienia z
WHERE   date_part('year', z.datarealizacji) = 2013 AND
        date_part('month', z.datarealizacji) = 11;

SELECT  k.nazwa, k.ulica, k.miejscowosc,
        c.orzechy
FROM    klienci k JOIN 
        zamowienia USING(idklienta) JOIN 
        artykuly USING(idzamowienia) JOIN
        pudelka USING(idpudelka) JOIN
        zawartosc USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE c.orzechy = 'migdały';

-- 4.4

SELECT  p.nazwa, p.opis, c.nazwa, c.opis
FROM    pudelka p JOIN
        zawartosc USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki);

SELECT  p.nazwa, p.opis, c.nazwa, c.opis,
        p.idpudelka
FROM    pudelka p JOIN
        zawartosc USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   p.idpudelka = 'heav';

SELECT  p.nazwa, p.opis, c.nazwa, c.opis
FROM    pudelka p JOIN
        zawartosc USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   p.nazwa SIMILAR TO '%(K|k)olekcja%';

-- 4.5

SELECT  p.nazwa, p.opis, p.cena, c.idczekoladki
FROM    pudelka p JOIN
        zawartosc USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   c.idczekoladki = 'd09';

SELECT  p.nazwa, p.opis, p.cena, c.nazwa
FROM    pudelka p JOIN
        zawartosc USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   c.nazwa SIMILAR TO 'S%';

SELECT  p.nazwa, p.opis, p.cena, c.nazwa, z.sztuk
FROM    pudelka p JOIN
        zawartosc z USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   z.sztuk >= 4;

SELECT  p.nazwa, p.opis, p.cena, c.nazwa, c.nadzienie
FROM    pudelka p JOIN
        zawartosc USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   c.nadzienie = 'truskawki';

SELECT  p.nazwa, p.opis, p.cena, c.nazwa, c.czekolada
FROM    pudelka p JOIN
        zawartosc USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   c.czekolada != 'gorzka' OR c.czekolada IS NULL;



SELECT  p.nazwa, p.opis, p.cena, c.nazwa, z.sztuk
FROM    pudelka p JOIN
        zawartosc z USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   c.nazwa = 'Gorzka truskawkowa' AND z.sztuk >= 3;

SELECT  p.nazwa, p.opis, p.cena, c.nazwa, c.orzechy
FROM    pudelka p JOIN
        zawartosc z USING(idpudelka) LEFT JOIN
        czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE   c.orzechy IS NULL;

-- Alternative
SELECT DISTINCT p.nazwa
FROM    pudelka p JOIN
        zawartosc z USING(idpudelka) JOIN
        czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE   c.orzechy IS NULL;

SELECT  p.nazwa, p.opis, p.cena, c.nazwa
FROM    pudelka p JOIN
        zawartosc z USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   c.nazwa = 'Gorzka truskawkowa';

SELECT  p.nazwa, p.opis, p.cena, c.nazwa, c.nadzienie
FROM    pudelka p JOIN
        zawartosc z USING(idpudelka) JOIN
        czekoladki c USING(idczekoladki)
WHERE   c.nadzienie IS NULL;