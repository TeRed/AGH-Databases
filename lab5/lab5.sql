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

-- 5.3

SELECT datarealizacji, COUNT(datarealizacji)
FROM zamowienia
GROUP BY datarealizacji
ORDER BY 2 DESC;

SELECT COUNT(*)
FROM zamowienia;

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

-- 5.5

-- SELECT COUNT(*)
-- FROM zamowienia
-- GROUP BY datarealizacji
-- ORDER BY 2 DESC;

SELECT date_part('month', datarealizacji), COUNT(*)
FROM zamowienia
GROUP BY date_part('month', datarealizacji)
ORDER BY 2 DESC;

-- 5.6

SELECT SUM(c.masa * z.sztuk) * p.stan
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka;