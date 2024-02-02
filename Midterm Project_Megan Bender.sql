/*
		~~Extras that i've added (these are at the bottom of the sql script)~~
        -> I have added an extra table, so instead of 4 I have 5. I wanted it to be easier to join various information
        -> I have also done a couple of queries to sort and find specific information.
        -> Added a view very similar to the original but allows all data to be viewed
		-> I have also added a few bits of data to business, vendor_info, invoice_info, and cost_info tables
*/

/****************************************************************
							SCRIPT ONE
****************************************************************/
DROP DATABASE IF EXISTS finances;
CREATE DATABASE finances;

USE finances;

DROP TABLE IF EXISTS business CASCADE;
CREATE TABLE business
(business_id INT AUTO_INCREMENT NOT NULL,
business_def VARCHAR(50),
PRIMARY KEY (business_id));

DROP TABLE IF EXISTS account_type CASCADE;
CREATE TABLE account_type
(account_id INT AUTO_INCREMENT NOT NULL,
account_def VARCHAR(50),
PRIMARY KEY (account_id));

DROP TABLE IF EXISTS vendor_info CASCADE;
CREATE TABLE vendor_info
( vendor_id INT AUTO_INCREMENT NOT NULL,
  business_ INT NOT NULL,
  account_ VARCHAR(50),
  PRIMARY KEY (vendor_id),
  FOREIGN KEY (account_) REFERENCES account_type(account_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (business_) REFERENCES business(business_id)
	ON DELETE CASCADE ON UPDATE CASCADE);

DROP TABLE IF EXISTS invoice_info CASCADE;
CREATE TABLE invoice_info
(invoice_id INT AUTO_INCREMENT NOT NULL,
vendor VARCHAR(50) NOT NULL,
invoice_number VARCHAR(15) NOT NULL,
invoice_date DATE NOT NULL,
PRIMARY KEY (invoice_id),
FOREIGN KEY (vendor) REFERENCES vendor_info(vendor_id)
	ON DELETE CASCADE ON UPDATE CASCADE);

DROP TABLE IF EXISTS cost_summary CASCADE;
CREATE TABLE cost_summary
( cost_id  INT AUTO_INCREMENT NOT NULL,
invoice INT NOT NULL,
item_cost DECIMAL(10, 2) NOT NULL,
PRIMARY KEY (cost_id),
FOREIGN KEY (invoice) REFERENCES invoice_info(invoice_id)
	ON DELETE CASCADE ON UPDATE CASCADE);

-- Adding data
INSERT INTO business(business_def)
	VALUES ('Blue Cross'),
			('Cardinal Business Media, Inc.'),
            ('Data Reproductions Corp'),
            ('Federal Express Corporation'),
            ('Ford Motor Credit Company'),
            ('Ingram'),
            ('Malloy Lithographing Inc'),
            ('Target Corporation'),
            ('NVIDIA');
            
INSERT INTO account_type(account_def)
	VALUES ('Group Insurance'),
			('Direct Mail Advertising'),
            ('Book Printing Costs'),
            ('Freight'),
            ('Travel and Accomodations'),
            ('Books, Dues, and Subscriptions');
            
INSERT INTO vendor_info(business_, account_)
	VALUES (1, 1),
			(2, 2),
            (3, 3),
            (4, 4),
            (4, 4),
            (4, 4),
            (4, 4),
            (5, 5),
            (6, 6),
            (7, 3),
            (7, 3),
            (8, 4),
            (9, 4);

INSERT INTO invoice_info(vendor, invoice_number, invoice_date)
	VALUES (1, '547480102', '2018-08-01'),
			(2, '134116', '2018-07-28'),
            (3, '39104', '2018-07-10'),
            (4, '263253270', '2018-07-22'),
            (5, '263252268', '2018-07-21'),
            (6, '963253264', '2018-07-18'),
            (7, '263253273', '2018-07-22'),
            (8, '9982771', '2018-07-24'),
            (9, '31361833', '2018-07-21'),
            (10, 'P-0608', '2018-07-23'),
            (11, 'O-2436', '2018-07-31'),
            (12, 'TI89782936', '2023-10-09'),
            (13, 'F829H98', '2022-10-10');
            
INSERT INTO cost_summary(invoice, item_cost)
	VALUES (1, 224.00),
			(2, 90.36),
            (3, 85.31),
            (4, 67.92),
            (5, 59.97),
            (6, 52.25),
            (7, 30.75),
            (8, 503.20),
            (9, 579.42),
            (10, 20551.18),
            (11, 10976.06),
            (12, 5278302.49),
            (13, 3928472.87);
            
            
/*********************************************************
						SCRIPT TWO
**********************************************************/
-- view to repicate the giving view
CREATE OR REPLACE VIEW view_1
AS
SELECT
	b.business_def AS 'Vendor Name',
    ivi.invoice_number,
    ivi.invoice_date,
    cs.item_cost AS 'line_item_amount',
    act.account_def AS 'Account Description'
FROM invoice_info ivi
	INNER JOIN vendor_info vi
		ON ivi.vendor = vi.vendor_id
	INNER JOIN business b
		ON vi.business_ = b.business_id
	INNER JOIN cost_summary cs
		ON ivi.invoice_id = cs.invoice
	INNER JOIN account_type act
		ON vi.account_ = act.account_id
WHERE `invoice_date` < '2019-01-01';

-- view to find vendors that are owed > 500
CREATE OR REPLACE VIEW view_2
AS
SELECT *
FROM view_1
WHERE `line_item_amount` > '500.00'; -- backticks are used to be wrapped around column names where the single quote is to be wrapped around data values

/*
	QUERIES AND EXTRA VIEW
*/
-- Query 1) we are looking for all of the invoices from Federal Express Corporation and ordering by date in descending order
SELECT *
FROM view_1
WHERE `Vendor Name` = 'Federal Express Corporation'
ORDER BY `invoice_date` ASC;

-- Query 2) 
SELECT *
FROM view_1
ORDER BY `line_item_amount` ASC;

-- Extra View
CREATE OR REPLACE VIEW view_3
AS
SELECT
	b.business_def AS 'Vendor Name',
    ivi.invoice_number AS 'Invoice Number',
    ivi.invoice_date AS 'Invoice Date',
    cs.item_cost AS 'Amount',
    act.account_def AS 'Account Description'
FROM invoice_info ivi
	INNER JOIN vendor_info vi
		ON ivi.vendor = vi.vendor_id
	INNER JOIN business b
		ON vi.business_ = b.business_id
	INNER JOIN cost_summary cs
		ON ivi.invoice_id = cs.invoice
	INNER JOIN account_type act
		ON vi.account_ = act.account_id;