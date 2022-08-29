--Develop a way to obtain the weekly average number of trips for an area, defined by a
--bounding box (given by coordinates) or by a region.

WITH weekly_trips as (
    select
        region,
        date_part('year', to_timestamp(datetime, 'YYYY-MM-DD HH24:MI:SS')) as year,
        date_part('week', to_timestamp(datetime, 'YYYY-MM-DD HH24:MI:SS')) as week,
        count(*) as trips
    from trips
    group by 
        region,
        date_part('year', to_timestamp(datetime, 'YYYY-MM-DD HH24:MI:SS')),
        date_part('week', to_timestamp(datetime, 'YYYY-MM-DD HH24:MI:SS'))
    )
    
select
    region,
    avg(trips) as average_weekly_trips
from weekly_trips
group by region;

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
