select
*
from renters
where (
	properties_mailing_address_1_cleaned ilike '%1200 callowhill%'
	or properties_mailing_address_2_cleaned ilike '%1200 callowhill%'
	or properties_business_mailing_address_cleaned ilike '%1200 callowhill%'
)
or (

	properties_mailing_address_1_cleaned ilike '%2628 martha%'
	or properties_mailing_address_2_cleaned ilike '%2628 martha%'
	or properties_business_mailing_address_cleaned ilike '%2628 martha%'
)

order by properties_numberofunits desc
