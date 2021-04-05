-- migrating over to postgres means we have to change syntax and have different functionality

drop table if exists renters;
create table renters
as (

	with l as (

		select
		*
		from (
				select
				*,
				row_number() over (partition by properties_address, left(properties_zip::varchar,5) order by properties_mostrecentissuedate::timestamp desc) as rk
				from
				(
					select
					*
					from licenses
					where properties_licensetype = 'Rental'
					and properties_licensestatus != 'Closed'
				) a
			) b
			where rk = 1
	),


	p as (

		select
		*
		from (

			select
			*,
			row_number() over (partition by properties_location, left(properties_zip_code::varchar,5) order by properties_recording_date::timestamp desc) as rk
			from
			(
				select
				*
				from properties
			) a
		) b

		where rk = 1


	),

	combined as (

		select
		l.properties_address
		,l.properties_unit_type
		,l.properties_unit_num
		,l.properties_zip
		,l.properties_censustract
		,l.properties_parcel_id_num
		,l.properties_opa_account_num
		,l.properties_opa_owner
		,l.properties_licensenum
		,l.properties_revenuecode
		,l.properties_licensetype
		,l.properties_initialissuedate
		,l.properties_mostrecentissuedate
		,l.properties_expirationdate
		,l.properties_inactivedate
		,l.properties_licensestatus
		,l.properties_numberofunits
		,l.properties_legalfirstname
		,l.properties_legallastname
		,l.properties_legalname
		,l.properties_legalentitytype
		,l.properties_business_name
		,l.properties_business_mailing_address
		,l.properties_business_mailing_address_cleaned
		,l.latitude as license_latitude
		,l.longitude as license_longitude
		,p.properties_assessment_date
		,p.properties_basements
		,p.properties_beginning_point
		,p.properties_book_and_page
		,p.properties_building_code
		,p.properties_building_code_description
		,p.properties_category_code
		,p.properties_category_code_description
		,p.properties_census_tract
		,p.properties_central_air
		,p.properties_cross_reference
		,p.properties_date_exterior_condition
		,p.properties_depth
		,p.properties_exempt_building
		,p.properties_exempt_land
		,p.properties_exterior_condition
		,p.properties_fireplaces
		,p.properties_frontage
		,p.properties_fuel
		,p.properties_garage_spaces
		,p.properties_garage_type
		,p.properties_general_construction
		,p.properties_geographic_ward
		,p.properties_homestead_exemption
		,p.properties_house_extension
		,p.properties_house_number
		,p.properties_interior_condition
		,p.properties_location
		,p.properties_mailing_address_1
		,p.properties_mailing_address_1_cleaned
		,p.properties_mailing_address_2
		,p.properties_mailing_address_2_cleaned
		,p.properties_mailing_care_of
		,p.properties_mailing_city_state
		,p.properties_mailing_street
		,p.properties_mailing_zip
		,p.properties_market_value
		,p.properties_market_value_date
		,p.properties_number_of_bathrooms
		,p.properties_number_of_bedrooms
		,p.properties_number_of_rooms
		,p.properties_number_stories
		,p.properties_off_street_open
		,p.properties_other_building
		,p.properties_owner_1
		,p.properties_owner_2
		,p.properties_parcel_number
		,p.properties_parcel_shape
		,p.properties_quality_grade
		,p.properties_recording_date
		,p.properties_registry_number
		,p.properties_sale_date
		,p.properties_sale_price
		,p.properties_separate_utilities
		,p.properties_sewer
		,p.properties_site_type
		,p.properties_state_code
		,p.properties_street_code
		,p.properties_street_designation
		,p.properties_street_direction
		,p.properties_street_name
		,p.properties_suffix
		,p.properties_taxable_building
		,p.properties_taxable_land
		,p.properties_topography
		,p.properties_total_area
		,p.properties_total_livable_area
		,p.properties_type_heater
		,p.properties_unfinished
		,p.properties_unit
		,p.properties_utility
		,p.properties_view_type
		,p.properties_year_built
		,p.properties_year_built_estimate
		,p.properties_zip_code
		,p.properties_zoning
		,p.properties_objectid
		,p.latitude as property_latitude
		,p.longitude as property_longitude
		from l
		inner join p on upper(l.properties_address) = upper(p.properties_location) and left(p.properties_zip_code::varchar,5) = left(l.properties_zip::varchar,5)

	)

	select
	*
	from combined



);

select
        properties_address,
        properties_zip,
        properties_census_tract,
        properties_opa_account_num,
        properties_opa_owner,
        properties_licensenum,
        properties_licensestatus,
        properties_numberofunits,
        properties_legalname,
        properties_legalentitytype,
        properties_business_name,
        properties_business_mailing_address_cleaned,
        properties_building_code_description,
        properties_category_code_description,
        properties_mailing_address_1_cleaned,
        properties_mailing_address_2_cleaned,
        properties_mailing_city_state,
        properties_mailing_street,
        properties_mailing_zip,
        properties_market_value,
        properties_number_stories,
        properties_number_of_rooms,
        properties_owner_1,
        properties_owner_2,
        properties_parcel_number,
        properties_recording_date,
        properties_registry_number,
        properties_sale_date,
        properties_sale_price,
        properties_separate_utilities,
        properties_taxable_building,
        properties_taxable_land,
        properties_total_livable_area,
        properties_type_heater,
        properties_unfinished,
        properties_utility,
        properties_unit,
        properties_year_built,
        properties_year_built_estimate,
        properties_zip_code as zip_code_9,
        properties_zoning,
        property_latitude,
        property_longitude
    from
        renters
;
