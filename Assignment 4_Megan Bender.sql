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
     ref INT,
     prev_emp_id INT,
     PRIMARY KEY (user_id),
	 FOREIGN KEY (app_id) REFERENCES app_info(app_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ref) REFERENCES reference_(ref_id),
    FOREIGN KEY (prev_emp_id) REFERENCES prev_employer(emp_id));
        
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
  
-- *****************The following has been added to help cover various relationships********************** -- 
DROP TABLE IF EXISTS reference_ CASCADE;
CREATE TABLE reference_ 
	(ref_id INT NOT NULL AUTO_INCREMENT,
     f_name VARCHAR(25) NOT NULL,
     l_name VARCHAR(25) NOT NULL,
     birthdate DATE,
     user_id INT NOT NULL,
     PRIMARY KEY (ref_id),
     FOREIGN KEY (user_id) REFERENCES user_info(user_id));
     
 DROP TABLE IF EXISTS prev_employer CASCADE;
 CREATE TABLE prev_employer
	(emp_id INT NOT NULL AUTO_INCREMENT,
     company_name VARCHAR(50) NOT NULL,
     emp_f_name VARCHAR(50) NOT NULL,
     emp_l_name VARCHAR(50) NOT NULL,
     email VARCHAR(50) NOT NULL,
     user_id INT NOT NULL,
     PRIMARY KEY (emp_id),
     FOREIGN KEY (user_id) REFERENCES user_info(user_id));
     
    
    
    
-- INSERTING TABLE INFORMATION ;
INSERT INTO user_info(user_fname, user_lname, education_level, app_id, ref, prev_emp_id)
	VALUES ('Mary', 'Lou', 'Undergraduate Junior', 'A00', 3, 1),
			('Larry', 'Wow', 'B.S. Graduate', 'A04', NULL, NULL),
            ('Annie', 'Sue', 'Undergraduate Junior', 'A06', 1, 2),
            ('Bart', 'Simpson', 'High School Junior', 'A05', NULL, NULL),
            ('Stephen', 'Hawking', 'PhD', 'A02', NULL, NULL),
            ('Hilda', 'Color', 'DNP', 'A08', NULL, 1),
			('Joe', 'Dirt', 'B.S. Graduate', 'A07', 2, 2),
            ('Rebecca', 'Pandas', 'B.A. Graduate', 'A09', NULL, 2),
            ('Sheldon', 'Cooper', 'PhD Theoretical Physics', 'A01', NULL, NULL),
            ('Lenoard', 'Hofstadter', 'PhD Experimental Physics', 'A03', NULL, NULL);
            
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

INSERT INTO reference_(f_name, l_name, birthdate, user_id)
	VALUES ('Heidi', 'Bender', '1900-07-05', 1),
			('John', 'Doe', '2024-03-03', 3),
			('Jane', 'Doe', '1492-06-03', 7),
            ('Rebecca', 'Pandas', '2010-05-20', 5);
            
INSERT INTO prev_employer(company_name, emp_f_name, emp_l_name, email, user_id)
	VALUES ('Trinity', 'Janet', 'Jackson', 'jjackson@yuh.org', 6),
			('Target', 'Robert', 'Downey', 'r.downey@notreal.com', 3);
            
            
/**********************************
			QUERIES
**********************************/
-- 1) bew table created for previous employer
SELECT *
FROM prev_employer;

-- 2) new table created for reference
SELECT *
FROM reference_;

-- 3) full view
CREATE OR REPLACE VIEW view1
AS
SELECT
	ui.user_id AS 'User ID',
    ai.app_id AS 'Application ID',
    CONCAT(user_fname, ' ', user_lname) AS 'User Name',
    ai.title AS 'Application Title',
    jt.type_def AS 'Application_Type',
	loc.loc_description AS 'Location',
    s.season_description AS 'Semester',
    due_date AS 'Due Date',
    CONCAT(ref.f_name, ' ', ref.l_name) AS 'Reference Name',
    pemp.email AS 'Previous Employer Email'
FROM user_info ui
	INNER JOIN app_info ai
		ON ui.app_id = ai.app_id
	INNER JOIN job_type jt
		ON ai.job_type = jt.job_type_id
	INNER JOIN location loc
		ON ai.location = loc.location_id
	INNER JOIN seasons s
		ON ai.semester = s.season_id
	INNER JOIN reference_ ref
		ON ui.ref = ref.ref_id
	INNER JOIN prev_employer pemp
		ON ui.prev_emp_id = pemp.emp_id;