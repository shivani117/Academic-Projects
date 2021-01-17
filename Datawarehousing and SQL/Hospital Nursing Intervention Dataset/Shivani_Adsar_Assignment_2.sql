CREATE DATABASE  IF NOT EXISTS `hospital`;
USE `hospital`;
SELECT * FROM bed_type;
SELECT * FROM bed_fact;
SELECT * FROM business;

-- 4a (1)--
SELECT business.business_name, bed_fact.license_beds AS total_license_beds
FROM bed_fact
INNER JOIN business ON business.ims_org_id = bed_fact.ims_org_id
WHERE bed_id IN (4,15)
ORDER BY license_beds DESC
LIMIT 10;

-- 4a (2)--
SELECT business.business_name, bed_fact.census_beds AS total_census_beds
FROM bed_fact
INNER JOIN business ON business.ims_org_id = bed_fact.ims_org_id
WHERE bed_id IN (4,15)
ORDER BY census_beds DESC
LIMIT 10;

-- 4a (3)--
SELECT business.business_name, bed_fact.staffed_beds AS total_staffed_beds
FROM bed_fact
INNER JOIN business ON business.ims_org_id = bed_fact.ims_org_id
WHERE bed_id IN (4,15)
ORDER BY staffed_beds DESC
LIMIT 10;

-- 5a (1)--
SELECT  business.business_name, sum(bed_fact.license_beds) AS total_license_beds
FROM (
	SELECT bed_fact.ims_org_id FROM bed_fact
	WHERE bed_fact.bed_id=4 AND bed_fact.ims_org_id in (SELECT bed_fact.ims_org_id FROM bed_fact WHERE bed_fact.bed_id= 15)
	GROUP BY ims_org_id	
	) hosp
LEFT JOIN bed_fact ON hosp.ims_org_id=bed_fact.ims_org_id
JOIN business ON business.ims_org_id= bed_fact.ims_org_id
WHERE bed_fact.bed_id IN (4,15)
GROUP BY hosp.ims_org_id
ORDER BY sum(bed_fact.license_beds) DESC
LIMIT 10;

-- 5a (2)--
SELECT  business.business_name, sum(bed_fact.census_beds) AS total_census_beds
FROM (
	SELECT bed_fact.ims_org_id FROM bed_fact
	WHERE bed_fact.bed_id=4 AND bed_fact.ims_org_id in (SELECT bed_fact.ims_org_id FROM bed_fact WHERE bed_fact.bed_id= 15)
	GROUP BY ims_org_id	
	) hosp
LEFT JOIN bed_fact ON hosp.ims_org_id=bed_fact.ims_org_id
JOIN business ON business.ims_org_id=bed_fact.ims_org_id
WHERE bed_fact.bed_id IN (4,15)
GROUP BY hosp.ims_org_id
ORDER BY sum(bed_fact.census_beds) DESC
LIMIT 10;

-- 5a (3)--
SELECT  business.business_name, sum(bed_fact.staffed_beds) AS total_staffed_beds
FROM (
	SELECT bed_fact.ims_org_id FROM bed_fact
	WHERE bed_fact.bed_id=4 AND bed_fact.ims_org_id IN (SELECT bed_fact.ims_org_id FROM bed_fact WHERE bed_fact.bed_id= 15)
	GROUP BY ims_org_id	
	) hosp
LEFT JOIN bed_fact ON hosp.ims_org_id=bed_fact.ims_org_id
JOIN business ON business.ims_org_id= bed_fact.ims_org_id
WHERE bed_fact.bed_id IN (4,15)
GROUP BY hosp.ims_org_id
ORDER BY sum(bed_fact.staffed_beds) DESC
LIMIT 10;