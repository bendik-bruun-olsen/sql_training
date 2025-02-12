--- HOSPITAL DB ---
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
---
SELECT first_name, last_name, COUNT(*) as num_of_duplicates
FROM patients
group by first_name, last_name
HAVING COUNT(*) > 1
---
SELECT 
	CONCAT(first_name, " ", last_name) as patient_name,
    round(height / 30.48, 1) as 'height "Feet"',
    ROUND(weight * 2.205, 0) as 'weight "Pounds"',
    birth_date,
    CASE
		WHEN gender = "M" THEN "MALE"
		ELSE "FEMALE" 
	END as gender_type
FROM patients
---
SELECT patient_id, first_name, last_name
FROM patients
WHERE patient_id NOT in (SELECT patient_id FROM admissions)
---
SELECT
	MAX(daily_visits) as max_visits,
    MIN(daily_visits) as min_visits,
    ROUND(AVG(daily_visits), 2)
FROM
	(SELECT COUNT(admission_date) AS daily_visits
    FROM admissions
    GROUP BY admission_date)
---
---HARD QUESTIONS---
---
SELECT COUNT(*) as patients_in_group, (weight / 10) * 10 as weight_group
FROM patients
GROUP BY weight_group
order by weight DESC;
---
SELECT 
	patient_id, 
    weight, 
    height,
    CASE
    	WHEN (weight / POWER((height / 100.0), 2)) >= 30 THEN 1
        ELSE 0
    END AS isObese
from patients;
---
SELECT
	p.patient_id,
    p.first_name as patient_first_name,
    p.last_name AS patient_last_name,
    d.specialty as attending_doctor_speciality
FROM patients p
JOIN admissions a on a.patient_id = p.patient_id
JOIN doctors d ON d.doctor_id = a.attending_doctor_id
WHERE a.diagnosis = 'Epilepsy'
AND d.first_name = 'Lisa'
---
SELECT 
	p.patient_id,
    CONCAT(p.patient_id, LEN(p.last_name), YEAR(p.birth_date)) as temp_password
FROM patients p
WHERE p.patient_id IN (SELECT patient_id FROM admissions WHERE discharge_date IS NOT NULL)
---
SELECT
	CASE
    	WHEN patient_id % 2 = 0 THEN 'Yes'
        ELSE 'No'
    END as has_insurance,
    SUM(CASE
    	WHEN patient_id % 2 = 0 THEN 10
        ELSE 50
    END) as cost_after_insurance
from admissions
GROUP BY has_insurance
---
SELECT pn.province_name
FROM province_names pn
join patients p ON p.province_id = pn.province_id  
group by pn.province_name
HAVING COUNT(CASE WHEN p.gender = 'M' THEN 1 END) > COUNT(CASE WHEN p.gender = 'F' THEN 1 END)
---
SELECT *
FROM patients
WHERE first_name LIKE '__r%'
AND gender = 'F'
AND MONTH(birth_date) IN (2, 5, 12)
AND weight BETWEEN 60 and 80
AND patient_id % 2 != 0
AND city = 'Kingston'
---
SELECT
	CONCAT(ROUND(COUNT(CASE WHEN gender = 'M' THEN 1 END) * 100.0 / COUNT(*), 2), '%') as percent_of_male_patients
from patients
---
SELECT admission_date, COUNT(*) as admissions_day, COUNT(*) - LAG(COUNT(*), 1) OVER(ORDER BY admission_date) as admission_count_change
FROM admissions
GROUP BY admission_date
---
SELECT province_name
FROM province_names
ORDER BY 
	CASE 
    	WHEN province_name = 'Ontario' THEN 0
        ELSE 1
    END,
    province_name;
---
SELECT
	d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) as doctor_name,
    d.specialty,
    YEAR(a.admission_date) as selected_year,
    COUNT(a.admission_date) as total_admissions
FROM doctors AS d
LEFT JOIN admissions AS a ON a.attending_doctor_id = doctor_id
GROUP BY d.doctor_id, selected_year