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
