CREATE DATABASE IF NOT EXISTS `pharmacyclaims`;
USE `pharmacyclaims`;
ALTER TABLE dimension_drug
CHANGE COLUMN drug_ndc drug_ndc VARCHAR(100);
ALTER TABLE dimension_drug
ADD PRIMARY KEY (drug_ndc);

SELECT * FROM `dimension_drug`;

ALTER TABLE dimension_member
CHANGE COLUMN id id VARCHAR(15);
ALTER TABLE dimension_member
ADD PRIMARY KEY(id);

SELECT * FROM `dimension_member`;
ALTER TABLE fact_drug
ADD trans_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE fact_drug
CHANGE COLUMN trans_id trans_id INT(15);
ALTER TABLE fact_drug
CHANGE COLUMN id id VARCHAR(50);

SELECT * FROM `fact_drug`;

ALTER TABLE fact_drug
CHANGE COLUMN drug_ndc drug_ndc VARCHAR(50);
ALTER TABLE fact_drug
ADD FOREIGN KEY (drug_ndc)
REFERENCES dimension_drug(drug_ndc);

ALTER TABLE fact_drug
ADD FOREIGN KEY (ID)
REFERENCES dimension_member(ID)
ON DELETE RESTRICT
ON UPDATE RESTRICT;
SELECT * FROM `fact_drug`;
SELECT a.drug_name Drug_Name,
COUNT(b.fill_date) Prescriptions
FROM fact_drug b
JOIN dimension_drug a ON b.drug_ndc=a.drug_ndc
GROUP BY a.drug_name
ORDER  BY a.drug_name;

/*Age Wise Prescriptions*/
 SELECT 
Age_Number,
COUNT(member_count) TOTAL_MEMBERS,
SUM(prescription_count) TOTAL_PRESCRIPTION,
SUM(total_copay) TOTAL_COPAY,
SUM(total_insuarancepaid) TOTAL_INSUARANCE
FROM 
(SELECT COUNT(a.id) member_count,
COUNT(a.fill_date) prescription_count,
SUM(a.copay) total_copay,
SUM(a.insurancepaid) total_insuarancepaid,
CASE
WHEN c.member_age > 65 THEN 'ABOVE 65'
ELSE 'BELOW 65'
END AS Age_Number
FROM fact_drug a
JOIN dimension_member c ON a.id= c.id
GROUP BY a.id
) Age
GROUP BY Age.Age_Number;

SELECT member_id,
first_name,
last_name,
drug_name,
fill_date,
insurance_amount
FROM(        
SELECT b.id  member_id, 
c.member_first_name first_name, 
c.member_last_name last_name,
b.fill_date fill_date,
d.drug_name drug_name,
b.insurancepaid insurance_amount, 
ROW_NUMBER() OVER (PARTITION BY b.id ORDER BY fill_date DESC, insurancepaid) N_COUNT
FROM fact_drug b
INNER JOIN dimension_drug D ON d.drug_ndc=b.drug_ndc
INNER JOIN dimension_member c ON c.id=b.id
) COUNT_NUMBER
WHERE  COUNT_NUMBER.N_COUNT=1; 
