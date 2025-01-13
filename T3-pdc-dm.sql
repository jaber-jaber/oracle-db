--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-pdc-dm.sql

-- ITO Assignment 2 Task 3

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
DROP SEQUENCE ec_seq;

CREATE SEQUENCE ec_seq
    START WITH 100 INCREMENT BY 5;

DROP SEQUENCE patient_seq;

CREATE SEQUENCE patient_seq
    START WITH 100 INCREMENT BY 5;

DROP SEQUENCE appt_seq;

CREATE SEQUENCE appt_seq
    START WITH 100 INCREMENT BY 5;

/*
(b)
*/
INSERT INTO emergency_contact (
    ec_id,
    ec_fname,
    ec_lname,
    ec_phone
) VALUES (
    ec_seq.NEXTVAL,
    'Jonathan',
    'Robey',
    '0412523122'
);

-- Insert LAURA
INSERT INTO patient (
    patient_no,
    patient_fname,
    patient_lname,
    patient_street,
    patient_city,
    patient_state,
    patient_postcode,
    patient_dob,
    patient_contactmobile,
    patient_contactemail,
    ec_id
) VALUES (
    patient_seq.NEXTVAL,
    'Laura',
    'Robey',
    '123 Glenbrill Road',
    'Craigieburn',
    'VIC',
    '3064',
    TO_DATE('13-MAR-2000', 'DD-MON-YYYY'),
    '0412523122',
    'robeyfam@gmail.com',
    ec_seq.CURRVAL
);

-- Insert LAURA'S APPT
INSERT INTO appointment (
    appt_no,
    appt_datetime,
    appt_roomno,
    appt_length,
    patient_no,
    provider_code,
    nurse_no,
    appt_prior_apptno
) VALUES (
    appt_seq.NEXTVAL,
    TO_DATE('04-10-2024 15:30:00', 'DD-MM-YYYY HH24:MI:SS'),
    ( SELECT provider_roomno FROM provider WHERE provider_title = 'Dr' AND upper(provider_lname) = 'STRIPLIN' ),
    'S',
    patient_seq.CURRVAL,
    ( SELECT provider_code FROM provider WHERE provider_title = 'Dr' AND upper(provider_lname) = 'STRIPLIN' ),
    ( SELECT nurse_no FROM nurse WHERE nurse_fname = 'Chelsea' AND nurse_lname = 'Ford' ),
    NULL
);

-- Insert LACHLAN
INSERT INTO patient (
    patient_no,
    patient_fname,
    patient_lname,
    patient_street,
    patient_city,
    patient_state,
    patient_postcode,
    patient_dob,
    patient_contactmobile,
    patient_contactemail,
    ec_id
) VALUES (
    patient_seq.NEXTVAL,
    'Lachlan',
    'Robey',
    '123 Glenbrill Road',
    'Craigieburn',
    'VIC',
    '3064',
    TO_DATE('26-JUL-2005', 'dd-MON-yyyy'),
    '0412523122',
    'robeyfam@gmail.com',
    ec_seq.CURRVAL
);

-- Insert LACHLAN'S APPT
INSERT INTO appointment (
    appt_no,
    appt_datetime,
    appt_roomno,
    appt_length,
    patient_no,
    provider_code,
    nurse_no,
    appt_prior_apptno
) VALUES (
    appt_seq.NEXTVAL,
    TO_DATE('04-10-2024 16:00:00', 'DD-MM-YYYY HH24:MI:SS'),
    ( SELECT provider_roomno FROM provider WHERE provider_title = 'Dr' AND upper(provider_lname) = 'STRIPLIN' ),
    'S',
    patient_seq.CURRVAL,
    ( SELECT provider_code FROM provider WHERE provider_title = 'Dr' AND upper(provider_lname) = 'STRIPLIN' ),
    ( SELECT nurse_no FROM nurse WHERE nurse_fname = 'Chelsea' AND nurse_lname = 'Ford' ),
    NULL
);

/*
(c)
*/


-- LACHLAN'S Follow-up appt
INSERT INTO appointment (
    appt_no,
    appt_datetime,
    appt_roomno,
    appt_length,
    patient_no,
    provider_code,
    nurse_no,
    appt_prior_apptno
) VALUES (
    appt_seq.NEXTVAL,
    TO_DATE('04-10-2024 16:00:00', 'DD-MM-YYYY HH24:MI:SS') + 10,
    ( SELECT provider_roomno FROM provider WHERE provider_title = 'Dr' AND upper(provider_lname) = 'STRIPLIN' ),
    'S',
    ( SELECT patient_no FROM patient WHERE patient_fname = 'Lachlan' AND patient_lname = 'Robey' ),
    ( SELECT provider_code FROM provider WHERE provider_title = 'Dr' AND upper(provider_lname) = 'STRIPLIN' ),
    ( SELECT nurse_no FROM nurse WHERE nurse_fname = 'Katie' ),
    ( SELECT appt_no FROM appointment WHERE appt_datetime >= TO_DATE('04-10-2024 00:00:00', 'DD-MM-YYYY HH24:MI:SS') AND appt_datetime < TO_DATE('05-10-2024 00:00:00', 'DD-MM-YYYY HH24:MI:SS') AND patient_no = ( SELECT patient_no FROM patient WHERE patient_fname = 'Lachlan' AND patient_lname = 'Robey' ) AND provider_code = ( SELECT provider_code FROM provider WHERE provider_title = 'Dr' AND upper(provider_lname) = 'STRIPLIN' ) )
);

/*
(d)
*/
UPDATE appointment
SET
    appt_datetime = TO_DATE(
        '04-10-2024 16:00:00',
        'DD-MM-YYYY HH24:MI:SS'
    ) + 14
WHERE
    appt_no = (
        SELECT
            appt_no
        FROM
            appointment
        WHERE
            appt_datetime = TO_DATE('04-10-2024 00:00:00', 'DD-MM-YYYY HH24:MI:SS') + 10
            AND patient_no = (
                SELECT
                    patient_no
                FROM
                    patient
                WHERE
                    patient_fname = 'Lachlan'
                    AND patient_lname = 'Robey'
            )
            AND provider_code = (
                SELECT
                    provider_code
                FROM
                    provider
                WHERE
                    provider_title = 'Dr'
                    AND upper(provider_lname) = 'STRIPLIN'
            )
    );

/*
(e)
*/
DELETE FROM appointment
WHERE
    appt_datetime >= TO_DATE('14-10-2024 00:00:00', 'DD-MM-YYYY HH24:MI:SS')
    AND appt_datetime < TO_DATE('19-10-2024 00:00:00', 'DD-MM-YYYY HH24:MI:SS')
    AND provider_code = (
        SELECT
            provider_code
        FROM
            provider
        WHERE
            provider_title = 'Dr'
            AND upper(provider_lname) = 'STRIPLIN'
    );