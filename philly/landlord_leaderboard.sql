-- select
-- sum(percent_of_units)*100 as rental_stock_ownership,
-- sum(units) as total_units
-- from (
	select
	*,
	sum(percent_of_units) over (order by units desc rows unbounded preceding) as cumulative_percent,
	row_number() over (partition by true) as number

	from (

		select
		*,
		units::float/sum(units) over (partition by true) as percent_of_units
		from (

			select
			coalesce(properties_business_mailing_address_cleaned,properties_mailing_street) as landlord_address,
			sum(properties_numberofunits) as units
			from renters
			where properties_licensestatus = 'Active'
			or (properties_licensestatus != 'Active' and (properties_mostrecentissuedate::timestamp >= properties_sale_date::timestamp or properties_sale_date is null))
			group by 1
			order by 2 desc

		) a

		where landlord_address is not null
		order by units desc



	) a
-- ) as a
-- where landlord_address ilike '%1200 callowhill%' or landlord_address ilike '%2628 martha%'
