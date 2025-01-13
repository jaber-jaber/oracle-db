--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-pdc-queries.sql

-- ITO Assignment 2 Task 4

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
    provider_code,
    provider_title
    || '. '
    || provider_fname
    || ' '
    || provider_lname AS provider_name
FROM
    provider
WHERE
    spec_id = (
        SELECT
            spec_id
        FROM
            specialisation
        WHERE
            upper(spec_name) = 'PAEDIATRIC DENTISTRY'
    )
ORDER BY
    provider_lname,
    provider_fname,
    provider_code;

/*
(b)
*/
SELECT
    service_code,
    service_desc,
    rpad(to_char(service_stdfee, '$9,999.99'), 50) AS service_fee
FROM
    service
WHERE
    service_stdfee > (
        SELECT
            avg(service_stdfee)
        FROM
            service
    )
ORDER BY
    service_stdfee DESC,
    service_code;

/*
(c)
*/
SELECT
    appointment.appt_no,
    appointment.appt_datetime,
    patient.patient_no,
    patient.patient_fname
    || ' '
    || patient.patient_lname                                                                        AS patient_fullname,
    lpad(to_char(sum(appt_serv.apptserv_fee + appt_serv.apptserv_itemcost), '$999,999,999.00'), 15) AS appt_totalcost
FROM
    appointment
    JOIN patient
    ON appointment.patient_no = patient.patient_no
    LEFT OUTER JOIN appt_serv
    ON appointment.appt_no = appt_serv.appt_no
GROUP BY
    appointment.appt_no,
    appointment.appt_datetime,
    patient.patient_no,
    patient.patient_fname,
    patient.patient_lname
HAVING
    sum(appt_serv.apptserv_fee + appt_serv.apptserv_itemcost) = (
        SELECT
            max(sum(appt_serv.apptserv_fee + appt_serv.apptserv_itemcost))
        FROM
            appointment
            LEFT JOIN appt_serv
            ON appointment.appt_no = appt_serv.appt_no
        GROUP BY
            appointment.appt_no
    )
ORDER BY
    appt_totalcost,
    appointment.appt_no;

/*
(d)
*/
SELECT
    s.service_code,
    s.service_desc,
    s.service_stdfee                                    AS standard_fee,
    round(avg(asrv.apptserv_fee) - s.service_stdfee, 2) AS fee_differential
FROM
    service   s
    JOIN appt_serv asrv
    ON s.service_code = asrv.service_code
GROUP BY
    s.service_code,
    s.service_desc,
    s.service_stdfee
ORDER BY
    s.service_code;

/*
(e)
*/
SELECT
    p.patient_no,
    p.patient_fname
    || ' '
    || p.patient_lname                                 AS patientname,
    floor(months_between(sysdate, p.patient_dob) / 12) AS currentage,
    count(*)                                           AS numappts,
    round((count(
        CASE
            WHEN appt_prior_apptno IS NOT NULL THEN
                1
        END) * 100.0) / count(*), 2)
    || '%'                                             AS followups
FROM
    appointment apt
    JOIN patient p
    ON apt.patient_no = p.patient_no
GROUP BY
    p.patient_no,
    p.patient_fname,
    p.patient_lname,
    p.patient_dob
ORDER BY
    p.patient_no;

/*
(f)
*/
SELECT
    lpad(p.provider_code, 10) AS "PCODE",
    lpad(
        CASE
            WHEN COUNT(DISTINCT apt.appt_no) > 0 THEN
                to_char(COUNT(DISTINCT apt.appt_no))
            ELSE
                '-'
        END, 10)              AS "NUMBERAPPTS",
    lpad(
        CASE
            WHEN sum(asrv.apptserv_fee) IS NOT NULL THEN
                to_char(round(sum(asrv.apptserv_fee), 2), '$9990.00')
            ELSE
                '-'
        END, 10)              AS "TOTALFEES",
    lpad(
        CASE
            WHEN sum(asi.as_item_quantity) IS NOT NULL THEN
                to_char(sum(asi.as_item_quantity))
            ELSE
                '-'
        END, 10)              AS "NOITEMS"
FROM
    provider         p
    LEFT JOIN appointment apt
    ON p.provider_code = apt.provider_code
    AND apt.appt_datetime BETWEEN TO_DATE('05-SEP-2024 09:00:00',
    'DD-MON-YYYY HH24:MI:SS')
    AND TO_DATE('15-SEP-2024 17:00:00',
    'DD-MON-YYYY HH24:MI:SS')
    LEFT JOIN appt_serv asrv
    ON apt.appt_no = asrv.appt_no
    LEFT JOIN apptservice_item asi
    ON asrv.appt_no = asi.appt_no
    AND asrv.service_code = asi.service_code
GROUP BY
    p.provider_code
ORDER BY
    p.provider_code;