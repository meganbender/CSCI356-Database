/*
	Internship database
		- we can have a table for internship names and company, users and what internships they are interested in and what the requirements are for that internship
        - users can keep track of the internships they want to apply for by selcting one of the columns and then
          the users can mark off if they hae completed it, if they have turned in their thigns 
		- MAP (managing application progress)
*/
CREATE DATABASE map;

USE map;

CREATE TABLE user_info
	(user_id INT NOT NULL AUTO_INCREMENT,
     user_fname VARCHAR(50) NOT NULL,
     user_lname VARCHAR(50) NOT NULL,
     application_id INT,
     education_level VARCHAR(25) NOT NULL,
     PRIMARY KEY (user_id),
	 FOREIGN KEY (application_id) REFERENCES app_info(internship_id)
		ON DELETE CASCADE ON UPDATE CASCADE);
        
DROP TABLE user_info;

-- add foreign keys for the season and locaiton to be added to the internship information
CREATE TABLE app_info
	(internship_id INT NOT NULL AUTO_INCREMENT,
    internship_title VARCHAR(75) NOT NULL,
    company_name VARCHAR(50) NOT NULL,
    job_type VARCHAR(25),
    location INT NOT NULL,
    PRIMARY KEY (internship_id),
    FOREIGN KEY (job_type) REFERENCES job_type(job_type_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (location) REFERENCES location(location_id)
		ON DELETE CASCADE ON UPDATE CASCADE);
        
DROP TABLE app_info;
DROP TABLE internship_info;
DROP TABLE season;    -- used to get rid of an unused table

CREATE TABLE seasons
	(season_id INT NOT NULL,
    season_description VARCHAR(25) NOT NULL,
	PRIMARY KEY (season_id));

CREATE TABLE location
	(location_id INT NOT NULL,
    loc_description varchar(25),
	PRIMARY KEY (location_id));
    
DROP TABLE job_type;
CREATE TABLE job_type
	(job_type_id VARCHAR(5) NOT NULL,
    type_def VARCHAR(25) NOT NULL,
    PRIMARY KEY (job_type_id));
    
-- INSERTING TABLE INFORMATION ;
INSERT INTO user_info(user_fname, user_lname, education_level)
	VALUES ('Megan', 'Bender', 'Undergraduate Junior'),
			('Long', 'Nguyen', 'B.S. Graduate'),
            ('Emily', 'Bender', 'Undergraduate Junior'),
            ('Andrew', 'Bender', 'High School Junior'),
            ('Stephen', 'Hawking', 'PhD Graduate');
            
DROP TABLE user_info2;

INSERT INTO app_info(internship_title, company_name, job_type, location)
 	VALUES ('Brooke Owens Fellowship', 'Various', 'T02', 0),
			('Engineering Intern', 'JPL', 'T02', 0),
            ('Gateway FSW Intern', 'NASA', 'T02', 0),
            ('Dvelopment & Testing of an Onboard TAG Guidance System', 'NASA', 'T02', 2),
            ('Artificial Intelligence Engineering Intern', 'NASA', 'T02', 2);
  
INSERT INTO app_info(internship_title, company_name, job_type, location)
	VALUES ('Entrapenurship', 'Minot State University', 'T00', 1);
    
INSERT INTO seasons(season_id, season_description) -- I am only doing 4 attributs for this table since I dont want to use other options
	VALUES (0, 'Fall'),
			(1, 'Spring'),
            (2, 'Full Academic Year'),
            (3, 'Summer');  
            
-- INSERT INTO seasons(season_id, season_description)
--	VALUES (4, ;
DROP TABLE location;
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
    