select *from renters
where
(
	zip_code ilike '%19134%'
	or
	zip_code ilike '%19144%'
	or
	zip_code ilike '%19139%'
	or
	zip_code ilike '%19131%'
	or
	zip_code ilike '%19154%'
	or
	zip_code ilike '%19120%'
	or
	zip_code ilike '%19124%'
	or
	zip_code ilike '%19141%'
	or
	zip_code ilike '%19143%'
	or
	zip_code ilike '%19104%'
)
and number_of_units::float > 10
order by zip_code
