SELECT patient_id, first_name, last_name
FROM patients
WHERE patient_id IN (
	SELECT patient_id 
  	FROM admissions
  	WHERE diagnosis = 'Dementia'
)

---

