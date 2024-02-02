DROP DATABASE IF EXISTS gilfoyle;  -- ironic considering the database contents ha ha ha
CREATE DATABASE gilfoyle;

USE gilfoyle;

-- MAKING THE AGE TABLE
DROP TABLE IF EXISTS age CASCADE;
CREATE TABLE age
	(AID INT NOT NULL AUTO_INCREMENT,
    ageType VARCHAR(15) NOT NULL,
    PRIMARY KEY (AID));

INSERT INTO age(ageType)
	VALUES ('Infant'),
	       ('Toddler'),
           ('Child'),
           ('Adult');
           
           
 -- MAKING THE TABLE FOR RECIPIENT/GIFTER RELATIONSHIP          
DROP TABLE IF EXISTS relation CASCADE;
CREATE TABLE relation
	(relId INT NOT NULL AUTO_INCREMENT,
     relType VARCHAR(15) NOT NULL,
     PRIMARY KEY (relID));
     
 INSERT INTO relation(relType)
	VALUES ('Friend'),
			('Our Family'),
            ('Sara\'s Side'),
            ('My Side');


-- TABLE FOR GIFT GIVER SPECIFICS
DROP TABLE IF EXISTS giftGiver CASCADE;
CREATE TABLE giftGiver
	(GGID INT NOT NULL AUTO_INCREMENT,
    gg_type VARCHAR(25) NOT NULL,
    PRIMARY KEY(GGID));
    
INSERT INTO giftGiver(gg_type)
	VALUES (' '),
			(' (from kids)');
            

-- TABLE FOR RECIPIENT INFORMATION
DROP TABLE IF EXISTS recipient_info CASCADE;
CREATE TABLE recipient_info
	(RID INT NOT NULL AUTO_INCREMENT,
     rec_fName VARCHAR(50) NOT NULL,
     giver INT NOT NULL,
     gift VARCHAR(50) NOT NULL,
     relationType INT NOT NULL,
     age INT NOT NULL,
     budget VARCHAR(10) NOT NULL,
     total_spent VARCHAR(10) NOT NULL,
     PRIMARY KEY (RID),
     FOREIGN KEY (giver) REFERENCES giftGiver(gg_tpe)
		ON DELETE CASCADE ON UPDATE CASCADE,
	 FOREIGN KEY (relationType) REFERENCES relation(relId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (age) REFERENCES age(AID));

INSERT INTO recipient_info(rec_fName, giver, gift, relationType, age, budget, total_spent)
	VALUES ('Katrina', 1, 'N/a', 2, 4, '$30.00', '$-'),
			('Katrina', 2, 'N/a', 2, 4, '$10.00', '$-'),
            ('Perry', 1, 'N/a', 2, 4, '$30.00', '$-'),
            ('Perry', 2, 'N/a', 2, 4, '$10.00', '$-'),
            ('Thomas', 1, 'Billie Train', 2, 2, '$40.00', '$10.00'),
            ('Chloe', 1, 'Sushine Chair', 2, 2, '$40.00', '$31.00'),
            ('Janet', 1, 'Electronic Photo Frame', 3, 4, '$20.00', '$28.00'),
            ('Alan', 1, 'Magazine Subscription', 3, 4, '$20.00', '$30.00'),
            ('Jim', 1, 'Backgammon, After Shave', 4, 4, '$20.00', '$13.00'),
            ('Ros', 1, 'Travel Hair Dryer', 4, 4, '$20.00', '$1.00'),
            ('Angela', 1, 'N/a', 4, 4, '$20.00', '$-'),
            ('Rob', 1, 'Shirt, Gift Vouchers', 4, 4, '$20.00', '$-'),
            ('Annabel', 1, 'Bouncing Tiger', 4, 1, '$15.00', '$12.00'),
            ('Fay', 1, 'Painting', 4, 4, '$20.00', '$25.00'),
            ('Steve', 1, 'Gadgets', 4, 4, '$20.00', '$-'),
            ('Sasha', 1, 'DVD, Game', 4, 2, '$15.00', '$13.75'),
            ('Philip', 1, 'N/a', 3, 4, '$20.00', '$-'),
            ('Mimi', 1, 'Make Up', 3, 4, '$15.00', '$10.00'),
            ('Trixy', 1, 'Bouncing Tiger', 3, 1, '$15.00', '$12.00'),
            ('Olivia', 1, 'Books', 1, 3, '$10.00', '$6.50'),
            ('Sienna', 1, 'Books', 1, 2, '$10.00', '$6.50'),
            ('Kiera', 1, 'Books', 1, 2, '$10.00', '$6.50'),
            ('Millie', 1, 'DVD', 1, 2, '$10.00', '$6.75'),
            ('Megan', 1, 'Books, Tea Set', 1, 2, '$10.00', '$8.00');
   
   
-- 	CREATING VIEW
CREATE OR REPLACE VIEW view_1
AS
SELECT
	CONCAT(rec_fName, gg.gg_type) AS 'Recipient',
    gift AS 'Gift/s',
    rt.relType AS 'Relationship',
    age.ageType AS 'Age Range',
    budget AS 'Budget',
    total_spent AS 'Actual'
FROM recipient_info ri
	INNER JOIN giftGiver gg
		ON ri.giver = gg.GGID
	INNER JOIN relation rt
		ON ri.relationType = rt.relId
	INNER JOIN age
		ON ri.age = age.AID;