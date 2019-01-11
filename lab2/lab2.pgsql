-- 2.1

SELECT nazwa, ulica, miejscowosc
FROM klienci
ORDER BY nazwa;

SELECT *
FROM klienci
ORDER BY miejscowosc DESC, nazwa;

SELECT *
FROM klienci
WHERE
	miejscowosc = 'Kraków' OR
	miejscowosc = 'Warszawa'
ORDER BY miejscowosc DESC, nazwa;

SELECT *
FROM klienci
WHERE miejscowosc IN ('Kraków', 'Warszawa')
ORDER BY miejscowosc DESC, nazwa;

SELECT *
FROM klienci
ORDER BY miejscowosc DESC;

SELECT *
FROM klienci
WHERE miejscowosc = 'Kraków'
ORDER BY nazwa;

-- 2.2

SELECT nazwa, masa
FROM czekoladki
WHERE masa > 20;

SELECT nazwa, masa, koszt
FROM czekoladki
WHERE
	masa > 20 AND
	koszt > 0.25;

SELECT nazwa, masa, koszt * 100 AS koszt
FROM czekoladki
WHERE
	masa > 20 AND
	koszt > 0.25;

SELECT nazwa, czekolada, nadzienie, orzechy
FROM czekoladki
WHERE
	(czekolada = 'mleczna' AND nadzienie = 'maliny') OR
	(czekolada = 'mleczna' AND nadzienie = 'truskawki') OR
	(czekolada != 'mleczna' AND orzechy = 'laskowe');

SELECT nazwa, koszt
FROM czekoladki
WHERE koszt > 0.25;

SELECT nazwa, czekolada
FROM czekoladki
WHERE czekolada = 'mleczna' OR czekolada = 'biała';

-- 2.3

SELECT	124 * 7 + 45,
		pow(2, 20),
		sqrt(3),
		pi();

-- 2.4

SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa >= 15 AND
	  masa <= 24;

SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt >= 0.25 AND
	  koszt <= 0.35;

SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE (koszt BETWEEN 0.25 AND 0.35) AND
	  (masa BETWEEN 15 AND 24);

-- 2.5

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE orzechy IS NOT NULL;

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE orzechy IS NULL;

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE
	orzechy IS NOT NULL OR
	nadzienie IS NOT NULL;

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE
	czekolada IN ('mleczna', 'biała') AND
	orzechy IS NULL;

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE
	czekolada NOT IN ('mleczna', 'biała') AND
	(orzechy IS NOT NULL OR nadzienie IS NOT NULL);

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nadzienie IS NOT NULL;

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nadzienie IS NULL;

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE
	nadzienie IS NULL AND
	orzechy IS NULL;

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE
	czekolada NOT IN ('mleczna', 'biała') AND
	nadzienie IS NULL;

-- 2.6

SELECT nazwa, masa, koszt
FROM czekoladki
WHERE
	masa BETWEEN 15 AND 24 OR
    koszt BETWEEN 0.15 AND 0.24;

SELECT nazwa, masa, koszt
FROM czekoladki
WHERE
	(masa BETWEEN 15 AND 24 AND
    koszt BETWEEN 0.15 AND 0.24) OR
    (masa BETWEEN 25 AND 35 AND
    koszt BETWEEN 0.25 AND 0.35);

SELECT nazwa, masa, koszt
FROM czekoladki
WHERE
	masa BETWEEN 15 AND 24 AND
    koszt BETWEEN 0.15 AND 0.24;

SELECT nazwa, masa, koszt
FROM czekoladki
WHERE
	masa BETWEEN 25 AND 35 AND
    koszt NOT BETWEEN 0.25 AND 0.35;

SELECT nazwa, masa, koszt
FROM czekoladki
WHERE
	(masa BETWEEN 25 AND 35) AND
    (koszt NOT BETWEEN 0.15 AND 0.24) AND
    (koszt NOT BETWEEN 0.25 AND 0.35);
