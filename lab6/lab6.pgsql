-- 6.1

INSERT INTO czekoladki VALUES
('W98', 'Biały Kieł', 'biała', 'laskowe', 'marcepan', 'Rozpływające się w rękach i kieszeniach', 0.45, 20);

INSERT INTO klienci VALUES
(90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
(91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
(92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324');

INSERT INTO klienci 
    SELECT 93, 'Matusiak Iza', ulica, miejscowosc, kod, telefon FROM klienci 
    WHERE idklienta = 90;

SELECT *
FROM klienci
WHERE idklienta IN(90,91,92,93);

-- 6.2

INSERT INTO czekoladki VALUES
('X91', 'Nieznana Nieznajoma',
NULL, NULL, NULL,
'Niewidzialna czekoladka wspomagajaca odchudzanie.',
0.26, 0),
('M98', 'Mleczny Raj',
'mleczna', NULL, NULL,
'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.',
0.26, 36);

SELECT *
FROM czekoladki
WHERE idczekoladki IN('X91', 'M98');

-- 6.3

DELETE FROM czekoladki
WHERE idczekoladki IN ('X91', 'M98');

SELECT *
FROM czekoladki
WHERE idczekoladki IN('X91', 'M98');

INSERT INTO czekoladki
(idczekoladki, nazwa, opis, koszt, masa) VALUES
('X91', 'Nieznana Nieznajoma',
'Niewidzialna czekoladka wspomagajaca odchudzanie.',
0.26, 0);

INSERT INTO czekoladki
(idczekoladki, nazwa, czekolada, opis, koszt, masa) VALUES
('M98', 'Mleczny Raj', 'mleczna',
'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.',
0.26, 36);

SELECT *
FROM czekoladki
WHERE idczekoladki IN('X91', 'M98');

-- 6.4

UPDATE klienci SET nazwa = 'Nowak Iza'
WHERE nazwa = 'Matusiak Iza';

UPDATE czekoladki SET koszt = (koszt * 0.9)
WHERE idczekoladki IN('X91', 'M98');

UPDATE czekoladki
SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98')
WHERE nazwa = 'Nieznana Nieznajoma';

UPDATE klienci SET miejscowosc = 'Piotrograd'
WHERE miejscowosc = 'Leningrad';

UPDATE czekoladki SET koszt =  koszt + 0.15
WHERE idczekoladki SIMILAR TO '_9(1|2|3|4|5|6|7|8|9)';

-- 6.5

