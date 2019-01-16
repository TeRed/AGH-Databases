
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

