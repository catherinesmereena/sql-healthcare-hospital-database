-- Create the database
CREATE DATABASE Healthcare_Bed_Capacity;

-- Use the newly created database
USE Healthcare_Bed_Capacity;

-- Create bed_category table (Dimension Table 1)
CREATE TABLE bed_category (
    bed_id INT PRIMARY KEY,
    bed_code VARCHAR(10),
    bed_description VARCHAR(255)
);

-- Create the hospital table (Dimension Table 2)
CREATE TABLE hospital (
    ims_org_id VARCHAR(15) PRIMARY KEY,
    hospital_name VARCHAR(255),
    total_license_beds INT,
    total_census_beds INT,
    total_staffed_beds INT,
    bed_cluster_id INT
);


-- Create bed_capacity_fact table (Fact Table)
CREATE TABLE bed_capacity_fact (
    ims_org_id VARCHAR(15),
    bed_id INT,
    license_beds INT,
    census_beds INT,
    staffed_beds INT,
    FOREIGN KEY (ims_org_id) REFERENCES hospital(ims_org_id),
    FOREIGN KEY (bed_id) REFERENCES bed_category(bed_id)
);

-- Sample Queries

-- Query 1: Select all records from the fact table
SELECT * FROM Healthcare_Bed_Capacity.bed_capacity_fact;

-- Query 2: Get the count of records per ims_org_id where there are more than 1 records
SELECT ims_org_id, COUNT(*) as 'Num'
FROM hospital
GROUP BY ims_org_id
HAVING COUNT(*) > 1;

-- Query 3: Get the count of hospitals by name where there are more than 1 record
SELECT hospital_name, COUNT(*)
FROM hospital
GROUP BY hospital_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- Query 4: Get ICU and SICU bed capacity (license, staffed, census) and sum it up by hospital, ordering by license_beds, limit to top 10
SELECT MIN(f.ims_org_id), 
       h.hospital_name, 
       SUM(CASE WHEN LOWER(c.bed_description) = 'icu' THEN f.license_beds ELSE 0 END) AS 'ICU License Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'sicu' THEN f.license_beds ELSE 0 END) AS 'SICU License Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'icu' THEN f.census_beds ELSE 0 END) AS 'ICU Census Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'sicu' THEN f.census_beds ELSE 0 END) AS 'SICU Census Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'icu' THEN f.staffed_beds ELSE 0 END) AS 'ICU Staffed Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'sicu' THEN f.staffed_beds ELSE 0 END) AS 'SICU Staffed Beds'
       
FROM bed_capacity_fact f
LEFT JOIN hospital h ON h.ims_org_id = f.ims_org_id
LEFT JOIN bed_category c ON c.bed_id = f.bed_id
WHERE c.bed_description = 'icu' OR c.bed_description = 'sicu'
GROUP BY h.hospital_name
ORDER BY SUM(f.license_beds) DESC
LIMIT 10;

-- Query 5: Similar query as above but ordered by census beds
SELECT MIN(f.ims_org_id), 
       h.hospital_name, 
      SUM(CASE WHEN LOWER(c.bed_description) = 'icu' THEN f.license_beds ELSE 0 END) AS 'ICU License Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'sicu' THEN f.license_beds ELSE 0 END) AS 'SICU License Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'icu' THEN f.census_beds ELSE 0 END) AS 'ICU Census Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'sicu' THEN f.census_beds ELSE 0 END) AS 'SICU Census Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'icu' THEN f.staffed_beds ELSE 0 END) AS 'ICU Staffed Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'sicu' THEN f.staffed_beds ELSE 0 END) AS 'SICU Staffed Beds'
FROM bed_capacity_fact f
LEFT JOIN hospital h ON h.ims_org_id = f.ims_org_id
LEFT JOIN bed_category c ON c.bed_id = f.bed_id
WHERE c.bed_description = 'icu' OR c.bed_description = 'sicu'
GROUP BY h.hospital_name
ORDER BY SUM(f.census_beds) DESC
LIMIT 10;

-- Query 6: Similar query as above but ordered by staffed beds
SELECT MIN(f.ims_org_id), 
       h.hospital_name, 
       SUM(CASE WHEN LOWER(c.bed_description) = 'icu' THEN f.license_beds ELSE 0 END) AS 'ICU License Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'sicu' THEN f.license_beds ELSE 0 END) AS 'SICU License Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'icu' THEN f.census_beds ELSE 0 END) AS 'ICU Census Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'sicu' THEN f.census_beds ELSE 0 END) AS 'SICU Census Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'icu' THEN f.staffed_beds ELSE 0 END) AS 'ICU Staffed Beds',
       SUM(CASE WHEN LOWER(c.bed_description) = 'sicu' THEN f.staffed_beds ELSE 0 END) AS 'SICU Staffed Beds'
FROM bed_capacity_fact f
LEFT JOIN hospital h ON h.ims_org_id = f.ims_org_id
LEFT JOIN bed_category c ON c.bed_id = f.bed_id
WHERE c.bed_description = 'icu' OR c.bed_description = 'sicu'
GROUP BY h.hospital_name
ORDER BY SUM(f.staffed_beds) DESC
LIMIT 10;


