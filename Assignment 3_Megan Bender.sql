DROP DATABASE IF EXISTS map;
CREATE DATABASE map;

USE map;

DROP TABLE IF EXISTS user_info CASCADE;
CREATE TABLE user_info
	(user_id INT NOT NULL AUTO_INCREMENT,
     user_fname VARCHAR(50) NOT NULL,
     user_lname VARCHAR(50) NOT NULL,
     education_level VARCHAR(25) NOT NULL,
     app_id VARCHAR(5),
     PRIMARY KEY (user_id),
	 FOREIGN KEY (app_id) REFERENCES app_info(app_id)
		ON DELETE CASCADE ON UPDATE CASCADE);
        
DROP TABLE IF EXISTS app_info CASCADE;
CREATE TABLE app_info
	(app_id VARCHAR(5) NOT NULL,
    title VARCHAR(75) NOT NULL,
    company_name VARCHAR(50) NOT NULL,
    job_type VARCHAR(25),
    location INT NOT NULL,
    semester INT,
    due_date DATE,
    PRIMARY KEY (app_id),
    FOREIGN KEY (job_type) REFERENCES job_type(job_type_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (location) REFERENCES location(location_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (semester) REFERENCES seasons(season_id)
		ON DELETE CASCADE ON UPDATE CASCADE);

DROP TABLE IF EXISTS seasons CASCADE;
CREATE TABLE seasons
	(season_id INT NOT NULL,
    season_description VARCHAR(25) NOT NULL,
	PRIMARY KEY (season_id));

DROP TABLE IF EXISTS location CASCADE;
CREATE TABLE location
	(location_id INT NOT NULL,
    loc_description varchar(25),
	PRIMARY KEY (location_id));

DROP TABLE IF EXISTS job_type CASCADE;
CREATE TABLE job_type
	(job_type_id VARCHAR(5) NOT NULL,
    type_def VARCHAR(25) NOT NULL,
    PRIMARY KEY (job_type_id));
    
    
    
-- INSERTING TABLE INFORMATION ;
INSERT INTO user_info(user_fname, user_lname, education_level, app_id)
	VALUES ('Mary', 'Lou', 'Undergraduate Junior', 'A00'),
			('Larry', 'Wow', 'B.S. Graduate', 'A04'),
            ('Annie', 'Sue', 'Undergraduate Junior', 'A06'),
            ('Bart', 'Simpson', 'High School Junior', 'A05'),
            ('Stephen', 'Hawking', 'PhD', 'A02'),
            ('Hilda', 'Color', 'DNP', 'A08'),
			('Joe', 'Dirt', 'B.S. Graduate', 'A07'),
            ('Rebecca', 'Pandas', 'B.A. Graduate', 'A09'),
            ('Sheldon', 'Cooper', 'PhD Theoretical Physics', 'A01'),
            ('Lenoard', 'Hofstadter', 'PhD Experimental Physics', 'A03');
            
INSERT INTO app_info(app_id, title, company_name, job_type, location, semester, due_date)
 	VALUES ('A00', 'Brooke Owens Fellowship', 'Various', 'T02', 0, 3, '2023-10-07'),
			('A01', 'Engineering Intern', 'JPL', 'T02', 3, 1, '2023-10-20'),
            ('A02', 'Gateway FSW Intern', 'NASA', 'T02', 0, 3, '2023-10-20'),
            ('A03', 'Development & Testing of an Onboard TAG Guidance System', 'NASA', 'T07', 1, 0, '2023-10-20'),
            ('A04', 'Artificial Intelligence Engineering Intern', 'NASA', 'T02', 2, 3, '2023-10-20'),
            ('A05', 'Entrapenurship', 'Minot State University', 'T00', 1, NULL, '2024-12-15'),
            ('A06', 'Prepare and Cook for National Night Out', 'Target', 'T06', 0, 3, NULL),
            ('A07', 'Store Team Leader', 'Target', 'T05', 0, NULL, NULL),
            ('A08', 'Pulmonology and Critical Care Team', 'Trinity', 'T05', 0, NULL, NULL),
            ('A09', 'Mathematics PhD Program', 'UCLA', 'T00', 0, NULL, '2023-12-15');
    
INSERT INTO seasons(season_id, season_description)
	VALUES (0, 'Fall'),
			(1, 'Spring'),
            (2, 'Full Academic Year'),
            (3, 'Summer');  
            
INSERT INTO location(location_id, loc_description)
	VALUES (0, 'In-person'),
	       (1, 'Hybrid'),
           (2, 'Virtual'),
           (3, 'In-Person/Virtual');
           
INSERT INTO job_type(job_type_id, type_def)
	VALUES ('T00', 'College Application'),
			('T01', 'Apprenticeship'),
			('T02', 'Internship'),
            ('T03', 'Fellowship'),
            ('T04', 'Part-Time'),
            ('T05', 'Full-Time'),
            ('T06', 'Volunteer'),
            ('T07', 'Contract'),
            ('T08', 'Temporary');
            
            
            
/**********************************
			QUERIES
**********************************/
-- 1) query using the date on the app_info table ***
SELECT user_id AS 'User ID',
	CONCAT(user_fname, ' ', user_lname) AS 'Full Name', 
    education_level AS 'Education Level',
    ai.title AS 'Application Title',
    jt.type_def AS 'Application Type',
    loc.loc_description AS 'Location',
    due_date AS 'Due Date'
FROM user_info ui
	INNER JOIN app_info ai
		ON ui.app_id = ai.app_id
	INNER JOIN job_type jt
		ON ai.job_type = jt.job_type_id
	INNER JOIN location loc
		ON ai.location = loc.location_id
ORDER BY due_date ASC;

-- 2) using a wild card: finding company names starting with a T and have at least 5 characters ***
SELECT *
FROM app_info
WHERE company_name LIKE 't_%_%_%_%';

-- 3) use REGEXP ***
SELECT * 
FROM user_info 
WHERE user_lname REGEXP '^be|en$';

-- 4) use aggregate functions at least three; SUM
SELECT MAX(company_name)
FROM app_info;

-- 5) use COUNT aggregate
SELECT MIN(job_type)
FROM app_info;

-- 6) use STD
SELECT AVG(location)
FROM app_info;

-- 7) using IS NOT NULL and ordering by date to find when the earliest application is due ***
SELECT user_id AS 'User ID',
	CONCAT(user_fname, ' ', user_lname) AS 'Full Name', 
    education_level AS 'Education Level',
    ai.title AS 'Application Title',
    jt.type_def AS 'Application Type',
    loc.loc_description AS 'Location',
    due_date AS 'Due Date'
FROM user_info ui
	INNER JOIN app_info ai
		ON ui.app_id = ai.app_id
	INNER JOIN job_type jt
		ON ai.job_type = jt.job_type_id
	INNER JOIN location loc
		ON ai.location = loc.location_id
WHERE due_date IS NOT NULL
ORDER BY due_date ASC;

-- 8) create a useful view 1 (make sure to explain their purpose)
CREATE OR REPLACE VIEW view1
AS
SELECT
	user_id AS 'User ID',
	CONCAT(user_fname, ' ', user_lname) AS 'Full Name', 
    education_level AS 'Education Level',
    ai.title AS 'Application Title',
    jt.type_def AS 'Application Type',
    loc.loc_description AS 'Location',
    due_date AS 'Due Date'
FROM user_info ui
	INNER JOIN app_info ai
		ON ui.app_id = ai.app_id
	INNER JOIN job_type jt
		ON ai.job_type = jt.job_type_id
	INNER JOIN location loc
		ON ai.location = loc.location_id
	INNER JOIN seasons s
		ON ai.semester = s.season_id;

-- 9) useful view 2
CREATE OR REPLACE VIEW view2
AS
SELECT
	user_id as 'User Id',
    CONCAT(user_fname, ' ', user_lname) AS 'User Name',
     ai.title AS 'Application Title',
    jt.type_def AS 'Application Type'
FROM user_info ui
	INNER JOIN app_info ai
		ON ui.app_id = ai.app_id
	INNER JOIN job_type jt
		ON ai.job_type = jt.job_type_id;

-- 10) useful view 3
CREATE OR REPLACE VIEW view3
AS
SELECT
	user_id as 'User Id',
    CONCAT(user_fname, ' ', user_lname) AS 'User Name',
     ai.title AS 'Application Title',
    jt.type_def AS 'Application Type',
    loc.loc_description AS 'Location'
FROM user_info ui
	INNER JOIN app_info ai
		ON ui.app_id = ai.app_id
	INNER JOIN job_type jt
		ON ai.job_type = jt.job_type_id
	INNER JOIN location loc
		ON ai.location = loc.location_id
WHERE loc.location_id = 2;

-- 11) useful view 4
CREATE OR REPLACE VIEW view4
AS
SELECT
	user_id AS 'User ID',
    ai.app_id AS 'Application ID',
    CONCAT(user_fname, ' ', user_lname) AS 'User Name',
    ai.title AS 'Application Title',
    jt.type_def AS 'Application Type',
	loc.loc_description AS 'Location'
FROM user_info ui
	INNER JOIN app_info ai
		ON ui.app_id = ai.app_id
	INNER JOIN job_type jt
		ON ai.job_type = jt.job_type_id
	INNER JOIN location loc
		ON ai.location = loc.location_id
ORDER BY loc.location_id;

-- 12) useful view 5
CREATE OR REPLACE VIEW view5
AS
SELECT
	user_id AS 'User ID',
    ai.app_id AS 'Application ID',
    CONCAT(user_fname, ' ', user_lname) AS 'User Name',
    ai.title AS 'Application Title',
    jt.type_def AS 'Application_Type',
	loc.loc_description AS 'Location',
    s.season_description AS 'Semester',
    due_date AS 'Due Date'
FROM user_info ui
	INNER JOIN app_info ai
		ON ui.app_id = ai.app_id
	INNER JOIN job_type jt
		ON ai.job_type = jt.job_type_id
	INNER JOIN location loc
		ON ai.location = loc.location_id
	INNER JOIN seasons s
		ON ai.semester = s.season_id
ORDER BY user_lname ASC;

-- 13) use NOT ***
SELECT *
FROM view5
WHERE NOT Application_Type = 'Internship';



















