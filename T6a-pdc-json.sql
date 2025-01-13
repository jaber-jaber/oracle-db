--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T6a-pdc-json.sql

-- ITO Assignment 2 Task 6a

--Student ID: 30608643
--Student Name: Jaber Jaber

/* Comments for your marker:




*/

-- ENSURE that your SQL code is formatted and has a semicolon (;)
-- at the end of every statement. When marked this will be run as
-- a script.

/*
(a)
*/
SELECT 
    JSON_OBJECT(
        '_id' VALUE appt.appt_no,
        'datetime' VALUE TO_CHAR(appt.appt_datetime, 'DD/MM/YYYY HH24:MI'),
        'provider_code' VALUE p.provider_code,
        'provider_name' VALUE p.provider_title || ' ' || p.provider_fname || ' ' || p.provider_lname,
        'item_totalcost' VALUE (
            SELECT SUM(i.item_stdcost * asi.as_item_quantity)
            FROM apptservice_item asi
            JOIN item i ON asi.item_id = i.item_id
            WHERE asi.appt_no = appt.appt_no
        ),
        'no_of_items' VALUE (
            SELECT COUNT(*)
            FROM apptservice_item asi
            WHERE asi.appt_no = appt.appt_no
        ),
        'items' VALUE (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id' VALUE i.item_id,
                    'desc' VALUE i.item_desc,
                    'standardcost' VALUE i.item_stdcost,
                    'quantity' VALUE asi.as_item_quantity
                )
            FORMAT JSON ) 
            FROM apptservice_item asi
            JOIN item i ON asi.item_id = i.item_id
            WHERE asi.appt_no = appt.appt_no
        )
     FORMAT JSON ) || ','
FROM 
    appointment appt
JOIN 
    provider p ON appt.provider_code = p.provider_code
WHERE 
    EXISTS (
        SELECT 1
        FROM apptservice_item asi
        WHERE asi.appt_no = appt.appt_no
    )
ORDER BY 
    appt.appt_no;