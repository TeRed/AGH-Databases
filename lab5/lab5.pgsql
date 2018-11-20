-- 5.1

SELECT COUNT(*)
FROM czekoladki;

SELECT COUNT(*)
FROM czekoladki
WHERE nadzienie IS NOT NULL;

SELECT COUNT(nadzienie)
FROM czekoladki;

SELECT p.idpudelka, SUM(z.sztuk)
FROM pudelka p JOIN zawartosc z USING(idpudelka)
GROUP BY p.idpudelka
ORDER BY 2 DESC
LIMIT 1;

SELECT p.idpudelka, SUM(z.sztuk)
FROM pudelka p JOIN zawartosc z USING(idpudelka)
GROUP BY p.idpudelka
ORDER BY 2 DESC;

SELECT p.idpudelka, SUM(z.sztuk)
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy IS NULL
GROUP BY p.idpudelka
ORDER BY 2 DESC;

SELECT p.idpudelka, SUM(z.sztuk)
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
WHERE c.czekolada = 'mleczna'
GROUP BY p.idpudelka
ORDER BY 2 DESC;

-- 5.2

SELECT p.idpudelka, SUM(c.masa * z.sztuk)
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka
ORDER BY 2 DESC;

SELECT p.idpudelka, SUM(c.masa * z.sztuk)
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka
ORDER BY 2 DESC
LIMIT 1;

SELECT SUM(c.masa * z.sztuk) / COUNT(DISTINCT p.idpudelka)
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki);

SELECT p.idpudelka, SUM(c.masa * z.sztuk) / SUM(z.sztuk)
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka
ORDER BY 2 DESC;

-- 5.3

SELECT datarealizacji, COUNT(datarealizacji)
FROM zamowienia
GROUP BY datarealizacji
ORDER BY 2 DESC;

SELECT COUNT(*)
FROM zamowienia;

SELECT SUM(a.sztuk * p.cena)
FROM    zamowienia z
        JOIN artykuly a USING(idzamowienia)
        JOIN pudelka p USING(idpudelka);

SELECT z.idklienta, COUNT(idzamowienia), SUM(a.sztuk * p.cena)
FROM    zamowienia z
        JOIN artykuly a USING(idzamowienia)
        JOIN pudelka p USING(idpudelka)
GROUP BY z.idklienta
ORDER BY 1;

-- 5.4

SELECT c.idczekoladki, COUNT(c.idczekoladki)
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
GROUP BY c.idczekoladki
ORDER BY 2 DESC;

SELECT p.idpudelka, COUNT(c.idczekoladki)
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy IS NULL
GROUP BY p.idpudelka
ORDER BY 2 DESC;

SELECT c.idczekoladki, COUNT(c.idczekoladki)
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
GROUP BY c.idczekoladki
ORDER BY 2;

SELECT a.idpudelka, COUNT(a.idpudelka)
FROM    zamowienia z
        JOIN artykuly a USING(idzamowienia)
GROUP BY a.idpudelka;

-- 5.5

SELECT count(*), date_part('quarter', datarealizacji), date_part('year', datarealizacji)
FROM zamowienia
GROUP BY 3, 2;

SELECT COUNT(*), date_part('year', datarealizacji), date_part('month', datarealizacji)
FROM zamowienia
GROUP BY 2, 3
ORDER BY 1 DESC;

SELECT COUNT(*), date_part('year', datarealizacji), date_part('week', datarealizacji)
FROM zamowienia
GROUP BY 2, 3
ORDER BY 1 DESC;

SELECT COUNT(*), k.miejscowosc
FROM    zamowienia
        JOIN klienci k USING(idklienta)
GROUP BY k.miejscowosc
ORDER BY 1;

-- 5.6

SELECT p.idpudelka, SUM(c.masa * z.sztuk) * p.stan
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka;

SELECT SUM(p.cena * p.stan)
FROM pudelka p;

-- 5.7

SELECT p.idpudelka, p.cena - SUM(c.koszt * z.sztuk) AS Zysk
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka;

SELECT  SUM(Zysk.zysk * a.sztuk)
FROM    artykuly a
        JOIN (
            SELECT p.idpudelka, p.cena - SUM(c.koszt * z.sztuk) AS Zysk
            FROM    pudelka p
                    JOIN zawartosc z USING(idpudelka)
                    JOIN czekoladki c USING(idczekoladki)
            GROUP BY p.idpudelka
        ) AS Zysk USING(idpudelka);

SELECT SUM(Zysk.Zysk)
FROM (
    SELECT (p.cena - SUM(c.koszt * z.sztuk)) * p.stan AS Zysk
    FROM    pudelka p
            JOIN zawartosc z USING(idpudelka)
            JOIN czekoladki c USING(idczekoladki)
    GROUP BY p.idpudelka
) AS Zysk;

-- 5.8

SELECT
        ROW_NUMBER() OVER (ORDER BY p.idpudelka),
        p.idpudelka
FROM
        pudelka p;
