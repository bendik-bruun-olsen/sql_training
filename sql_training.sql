SELECT patient_id, first_name, last_name
FROM patients
WHERE patient_id IN (
	SELECT patient_id 
  	FROM admissions
  	WHERE diagnosis = 'Dementia'
)
---
SELECT first_name
FROM patients
ORDER BY LEN(first_name), first_name;
--
SELECT 
	(SELECT COUNT(*) FROM patients WHERE gender = 'M') as total_males,
  	(SELECT COUNT(*) FROM patients WHERE gender = 'F') AS total_females;
---
SELECT first_name, last_name, allergies
FROM patients
WHERE allergies = 'Penicillin'
OR allergies = 'Morphine'
ORDER BY allergies, first_name, last_name;
---