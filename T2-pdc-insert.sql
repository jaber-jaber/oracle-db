--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-pdc-insert.sql

-- ITO Assignment 2 Task 2

--Student ID: 30608643
--Student Name: Jaber Jaber

/* Comments for your marker:


*/

-- ENSURE that your SQL code is formatted and has a semicolon (;)
-- at the end of every statement. When marked this will be run as
-- a script.


-- Insert into APPOINTMENT
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
    1,
    TO_DATE('10-09-2024 09:00:00', 'DD-MM-YYYY HH24:MI:SS'),
    '1',
    'L',
    1,
    'GEN001',
    3,
    NULL
);

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
    2,
    TO_DATE('10-09-2024 09:00:00', 'DD-MM-YYYY HH24:MI:SS'),
    '3',
    'S',
    2,
    'GEN002',
    4,
    NULL
);

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
    3,
    TO_DATE('14-09-2024 10:15:00', 'DD-MM-YYYY HH24:MI:SS'),
    '10',
    'L',
    3,
    'AST002',
    6,
    NULL
);

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
    4,
    TO_DATE('14-09-2024 11:45:00', 'DD-MM-YYYY HH24:MI:SS'),
    '1',
    'S',
    1,
    'GEN001',
    9,
    1
);

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
    5,
    TO_DATE('14-09-2024 15:30:00', 'DD-MM-YYYY HH24:MI:SS'),
    '5',
    'L',
    4,
    'ORS001',
    1,
    NULL
);

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
    6,
    TO_DATE('16-09-2024 10:00:00', 'DD-MM-YYYY HH24:MI:SS'),
    '13',
    'T',
    5,
    'PRO001',
    11,
    NULL
);

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
    7,
    TO_DATE('16-09-2024 12:50:00', 'DD-MM-YYYY HH24:MI:SS'),
    '5',
    'S',
    4,
    'ORS001',
    12,
    5
);

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
    8,
    TO_DATE('16-09-2024 12:50:00', 'DD-MM-YYYY HH24:MI:SS'),
    '8',
    'S',
    6,
    'ORT001',
    14,
    NULL
);

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
    9,
    TO_DATE('21-09-2024 16:45:00', 'DD-MM-YYYY HH24:MI:SS'),
    '8',
    'L',
    6,
    'ORT001',
    6,
    8
);

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
    10,
    TO_DATE('21-09-2024 09:00:00', 'DD-MM-YYYY HH24:MI:SS'),
    '12',
    'L',
    7,
    'PER002',
    3,
    NULL
);

-- Insert into APPT_SERV
INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    1,
    'D001',
    75,
    15
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    2,
    'D002',
    60,
    10
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    3,
    'X002',
    95,
    20
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    4,
    'P002',
    180,
    35
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    5,
    'P003',
    50,
    20
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    6,
    'PG01',
    170,
    40
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    7,
    'RC01',
    200,
    60
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    8,
    'EX02',
    450,
    150
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    9,
    'DC05',
    140,
    30
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    10,
    'OT04',
    100,
    25
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    1,
    'DV02',
    195,
    50
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    2,
    'DV03',
    175,
    45
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    3,
    'DT01',
    300,
    75
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    4,
    'RC03',
    280,
    85
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    5,
    'EX01',
    175,
    45
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    7,
    'D001',
    80,
    20
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    8,
    'P002',
    190,
    40
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    5,
    'RC01',
    210,
    65
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    3,
    'EX02',
    460,
    155
);

INSERT INTO appt_serv (
    appt_no,
    service_code,
    apptserv_fee,
    apptserv_itemcost
) VALUES (
    10,
    'D002',
    65,
    12
);

-- Insert into APPTSERVICE_ITEM
INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    1,
    1,
    'D001',
    1,
    1
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    2,
    1,
    'D001',
    2,
    1
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    3,
    1,
    'D001',
    3,
    1
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    4,
    2,
    'D002',
    3,
    3
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    5,
    2,
    'D002',
    4,
    1
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    6,
    3,
    'X002',
    4,
    2
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    7,
    3,
    'X002',
    7,
    4
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    8,
    4,
    'P002',
    7,
    3
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    9,
    4,
    'RC03',
    8,
    2
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    10,
    5,
    'P003',
    8,
    3
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    11,
    5,
    'P003',
    9,
    4
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    12,
    5,
    'P003',
    10,
    4
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    13,
    6,
    'PG01',
    11,
    1
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    14,
    6,
    'PG01',
    1,
    5
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    15,
    7,
    'RC01',
    2,
    3
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    16,
    7,
    'RC01',
    12,
    2
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    17,
    8,
    'EX02',
    3,
    1
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    18,
    8,
    'EX02',
    13,
    3
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    19,
    9,
    'DC05',
    14,
    4
);

INSERT INTO apptservice_item (
    as_id,
    appt_no,
    service_code,
    item_id,
    as_item_quantity
) VALUES (
    20,
    9,
    'DC05',
    15,
    2
);