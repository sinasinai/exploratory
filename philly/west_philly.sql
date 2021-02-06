with l as (

	select
	*
	from (
			select
			*,
			row_number() over (partition by properties_address order by properties_mostrecentissuedate desc) as rk
			from
			(
				select
				*
				from licenses
				where properties_address != 'nan'
				and properties_licensetype = 'Rental'
				and properties_mostrecentissuedate != 'nan'
			)
		)
		where rk = 1
),


p as (

	select
	*
	from (

		select
		*,
		row_number() over (partition by properties_location order by properties_recording_date desc) as rk
		from
		(
			select
			*
			from properties
			where properties_recording_date != 'nan'
		)
	)

	where rk = 1


),

combined as (


	select
	*
	from l
	inner join p on l.properties_address = p.properties_location and left(p.properties_zip_code::varchar,5) = left(l.properties_zip::varchar,5)

)




select
properties_address,
properties_market_value,
properties_zip as zip_code,
properties_opa_account_num,
properties_opa_owner,
properties_licensenum as properties_rental_license_number,
properties_mostrecentissuedate as most_recent_license_issue_date,
properties_expirationdate as license_expiration_date,
properties_inactivedate as license_inactive_date,
properties_licensestatus as license_status,
properties_numberofunits as number_of_units,
properties_legalname as legal_property_owner_name,
properties_legalentitytype as legal_entity_type,
properties_business_name as business_name,
properties_business_mailing_address as owner_business_mailing_address,
properties_building_code_description as building_code,
properties_category_code_description as category_code,
properties_census_tract as census_tract,
properties_number_of_bedrooms as bedrooms,
properties_number_of_bathrooms as bathrooms,
properties_number_of_rooms as rooms,
properties_number_stories as stories,
properties_owner_1 as owner_1,
properties_owner_2 as owner_2,
properties_parcel_number as parcel_number,
properties_recording_date,
properties_sale_price as sale_price,
properties_taxable_building as taxable_building,
properties_taxable_land as taxable_land,
properties_total_area as total_area,
properties_total_livable_area as total_livable_area,
properties_zoning as zoning
from combined
where left(properties_zip,5) in ('19134', '19144', '19139', '19131', '19154', '19120', '19124', '19141', '19143', '19104')
and properties_zip != 'nan'
order by properties_zip, properties_address
