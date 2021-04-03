select
*
from renters
where (
	properties_mailing_address_1 ilike '%1200 callowhill%'
	or properties_mailing_address_2 ilike '%1200 callowhill%'
	or properties_business_mailing_address ilike '%1200 callowhill%'
)
or (

	properties_mailing_address_1 ilike '%2628 martha%'
	or properties_mailing_address_2 ilike '%2628 martha%'
	or properties_business_mailing_address ilike '%2628 martha%'
)

order by properties_numberofunits desc
