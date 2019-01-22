
-- 11.1

create or replace function masaPudelka(id char(4))
returns int as
$$
declare
    w int;
begin
    select sum(c.masa) into w
    from
        zawartosc z
        natural join czekoladki c
    where z.idpudelka = id;

    return w;
end;
$$
language plpgsql;

create or replace function liczbaCzekoladek(id char(4))
returns int as
$$
begin
    return (
        select sum(sztuk)
        from zawartosc
        where idpudelka = id
    );
end
$$
language plpgsql;

-- 11.2

create or replace function zyskPudelka(id char(4))
returns numeric(7,2) as
$$
declare
    kosztOpakowania numeric(7,2) := 0.9;
    cenaPudelka numeric(7,2);
    kosztCzekoladek numeric(7,2);
    zysk numeric(7,2);
begin
    select cena into cenaPudelka
    from pudelka
    where idpudelka = id;

    select sum(c.koszt * z.sztuk) into kosztCzekoladek
    from
        zawartosc z
        natural join czekoladki c
    where z.idpudelka = id;

    return (cenaPudelka - kosztOpakowania - kosztCzekoladek);
end;
$$
language plpgsql;

create or replace function zyskDnia(dzien date)
returns numeric(7,2) as
$$
begin
    return (
        select sum(a.sztuk * zyskPudelka(idpudelka))
        from
            zamowienia z
            natural join artykuly a
        where z.datarealizacji = dzien 
    );
end;
$$
language plpgsql;

-- 11.3

create or replace function sumaZamowien(id integer)
returns numeric(7,2) as
$$
begin
    return (
        select sum(a.sztuk * p.cena)
        from
            zamowienia z
            natural join artykuly a
            natural join pudelka p
        where z.idklienta = id
    );
end;
$$
language plpgsql;

create or replace function rabat(id integer)
returns integer as
$$
declare
    sumaZamowienKlienta numeric(7,2);
begin
    sumaZamowienKlienta := sumaZamowien(id);

    if sumaZamowienKlienta > 400 then return 8;
    elseif sumaZamowienKlienta >= 201 then return 7;
    else return 4;
    end if;
end;
$$
language plpgsql;

-- 11.4

create or replace function podwyzka()
returns void as
$$
declare
    z zawartosc%rowtype;
    c czekoladki%rowtype;
    podwyzka numeric(7,2);
begin
    -- Zmiana ceny czekoladek
    for c in (select * from czekoladki)
    loop
        if c.koszt > 0.29 then podwyzka := 0.05;
        elseif c.koszt between 0.20 and 0.29 then podwyzka := 0.04;
        else podwyzka := 0.03;
        end if;

        update czekoladki
        set koszt = koszt + podwyzka
        where idczekoladki = c.idczekoladki;

         -- Zmiana ceny pudelek
        for z in (select * from zawartosc)
        loop
            update pudelka
            set cena = cena + (podwyzka * z.sztuk)
            where
                idpudelka = z.idpudelka
                and z.idczekoladki = c.idczekoladki;
        end loop;
    end loop;
end;
$$
language plpgsql;

-- 11.5

create or replace function obnizka()
returns void as
$$
declare
    z zawartosc%rowtype;
    c czekoladki%rowtype;
    podwyzka numeric(7,2);
begin
    -- Zmiana ceny czekoladek
    for c in (select * from czekoladki)
    loop
        if c.koszt > (0.29 + 0.05) then podwyzka := -0.05;
        elseif c.koszt between (0.20 + 0.04) and (0.29 + 0.04) then podwyzka := -0.04;
        else podwyzka := -0.03;
        end if;

        update czekoladki
        set koszt = koszt + podwyzka
        where idczekoladki = c.idczekoladki;

         -- Zmiana ceny pudelek
        for z in (select * from zawartosc)
        loop
            update pudelka
            set cena = cena + (podwyzka * z.sztuk)
            where
                idpudelka = z.idpudelka
                and z.idczekoladki = c.idczekoladki;
        end loop;
    end loop;
end;
$$
language plpgsql;

-- 11.6

create temporary table zamowieniaKlientaType(
    zamowienia int,
    pudelka char(4),
    data_realizacji date
);

create or replace function zamowieniaKlienta(id integer)
returns setof zamowieniaKlientaType as
$$
begin
    return query
    select z.idzamowienia, a.idpudelka, z.datarealizacji
    from
        zamowienia z
        natural join artykuly a
    where z.idklienta = id;
end;
$$
language plpgsql;

create temporary table klientInfo(
    imie_nazwisko varchar(130),
    ul varchar(30),
    msc varchar(15),
    kod_pocztowy char(6)
);

create or replace function listaKlientow(m varchar)
returns setof klientInfo as
$$
begin
    return query
    select nazwa, ulica, miejscowosc, kod
    from klienci
    where miejscowosc = m;
end;
$$
language plpgsql;

