
drop table if exists west_philly_targets;
create table west_philly_targets
distkey(address)
sortkey(zip_code)

as (

	with large_units as (

		select
		*
		from renters
		where (
			zip_code ilike '%19139%'

			or

			zip_code ilike '%19143%'

		)
		and number_of_units::float >= 10
		and address in
		(
			'1122 COBBS CREEK PKWY',
			'315 S 50TH ST',
			'5016-22 PINE ST',
			'801 S 47TH ST',
			'4807 CHESTER AVE',
			'4900-08 PINE ST',
			'4501 LARCHWOOD AVE',
			'4520 SPRINGFIELD AVE',
			'4818 CHESTER AVE',
			'5111-21 REGENT ST',
			'913-15 S 51ST ST',
			'4607 CEDAR AVE',
			'5025 WOODLAND AVE',
			'5131 HAZEL AVE',
			'534 S 52ND ST',
			'241 S 49TH ST',
			'6212 CHESTNUT ST',
			'732-72 N 49TH ST',
			'4624-42 WALNUT ST',
			'4701-23 WALNUT ST',
			'5429-55 CHESTNUT ST',
			'5429-55 CHESTNUT ST',
			'5031 RACE ST',
			'131 S 48TH ST',
			'4530 SPRUCE ST',
			'4726 CHESTNUT ST',
			'4728 CHESTNUT ST',
			'4708 CHESTNUT ST',
			'4724 CHESTNUT ST'

		)
	),

	smaller_units as (

		select
		*
		from renters
		where (
			zip_code ilike '%19139%'

			or

			zip_code ilike '%19143%'

		)
		and number_of_units::float < 10
		and building_code not like '%VACANT%'
		and building_code not like '%IND%'
		and building_code not like '%BAR %'
		and building_code not like '%AUTO%'
		and building_code not like '%HOTEL%'
		and building_code not like '%HEALTH%'


	)

  select
  *,
  split_part(replace(replace(coordinates,']',''),'[',''),', ',1)::float as longitude,
  split_part(replace(replace(coordinates,']',''),'[',''),', ',2)::float as latitude
  from (
  	select
  	*,
  	'large unit' as target_type
  	from large_units

  	union

  	select
  	*,
  	'smaller unit' as target_type
  	from smaller_units
  )
);

-- 39.9567, -75.23375 - centered at locust and s. 56th
select
*
from west_philly_targets
where hav_dist(latitude,longitude, 39.9567,-75.23375) <= 1600
