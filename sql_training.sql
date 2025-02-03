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
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;
---
SELECT city, COUNT(patient_id) as numPatients
FROM patients
GROUP BY city
ORDER BY numPatients DESC, city
---
SELECT first_name, last_name, "Patient" as role from patients
union ALL
SELECT first_name, last_name, "Doctor" as role from doctors;
---
SELECT allergies, COUNT(*) as total_diagnosis FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC
--- 
SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) LIKE '197%'
ORDER BY birth_date;
--- 
SELECT CONCAT(UPPER(last_name), ",", LOWER(first_name)) as new_name_format FROM patients
ORDER BY first_name DESC;
---
SELECT province_id, CEIL(SUM(height)) as sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000
---
SELECT MAX(weight) - MIN(weight)
FROM patients
WHERE last_name = 'Maroni';
---
SELECT DAY(admission_date) as day_number, COUNT(admission_date) as number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC
---
SELECT * FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING admission_date = MAX(admission_date);
---
SELECT patient_id, attending_doctor_id, diagnosis
FROM admissions
WHERE 
	(patient_id % 2 != 0 AND attending_doctor_id IN (1, 5, 19))
OR 
	(attending_doctor_id LIKE '%2%' AND LEN(patient_id) = 3)
---
select d.first_name, d.last_name, COUNT(a.attending_doctor_id) AS admissions_total
FROM doctors d
LEFT JOIN admissions a ON doctor_id = attending_doctor_id
GROUP BY attending_doctor_id;
---
SELECT 
	d.doctor_id, 
    CONCAT(d.first_name, " ", d.last_name) as full_name, 
    MIN(a.admission_date) as first_admission_date,
    MAX(a.admission_date) AS last_admission_date
FROM doctors d
JOIN admissions a ON doctor_id = attending_doctor_id
GROUP BY doctor_id;
---
SELECT pn.province_name, COUNT(*) as patient_count
FROM patients p
JOIN province_names pn ON p.province_id = pn.province_id
GROUP BY p.province_id
ORDER BY patient_count DESC
---
SELECT 
	CONCAT(p.first_name, " ", p.last_name) as patient_name,
    a.diagnosis,
    CONCAT(d.first_name, " ", d.last_name) as doctor_name
FROM patients p
JOIN admissions a ON a.patient_id = p.patient_id
JOIN doctors d ON doctor_id = a.attending_doctor_id