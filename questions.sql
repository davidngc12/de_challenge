--From the two most commonly appearing regions, which is the latest datasource?
--Answer: "pt_search_app"
select datasource 
from trips
where datetime = (
    select max(datetime)
    from trips
    where region in (
        select distinct region 
        from (
            select region, count(*) 
            from trips 
            group by region
            order by count(*) desc
            limit 2
        ) a
    )
);

--What regions has the "cheap_mobile" datasource appeared in?
--Answer: all 3 regions Hamburg, Prague, Turin
select distinct region
from trips
where datasource = 'cheap_mobile';
