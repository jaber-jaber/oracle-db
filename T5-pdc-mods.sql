--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T5-pdc-mods.sql

-- ITO Assignment 2 Task 5

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
ALTER TABLE patient
    ADD patient_totalappts NUMBER(
        5
    );

COMMENT ON COLUMN patient.patient_totalappts IS 'Stores the total number of appointments for each patient';

UPDATE patient p
SET
    patient_totalappts = (
        SELECT
            count(*)
        FROM
            appointment a
        WHERE
            a.patient_no = p.patient_no
    );

SELECT
    *
FROM
    patient
ORDER BY
    patient_no;

DESC patient;

/*
(b)
*/
ALTER TABLE emergency_contact RENAME TO ec_backup;

CREATE TABLE emergency_contact (
    contact_id NUMBER(4) NOT NULL,
    ec_id NUMBER(4) NOT NULL,
    patient_no NUMBER(4) NOT NULL,
    ec_fname VARCHAR2(30),
    ec_lname VARCHAR2(30),
    ec_phone CHAR(10)
);

COMMENT ON COLUMN emergency_contact.contact_id IS
    'Contact surrogate key';

COMMENT ON COLUMN emergency_contact.ec_id IS
    'Emergency contact identifier';

COMMENT ON COLUMN emergency_contact.ec_fname IS
    'Emergency contact first name';

COMMENT ON COLUMN emergency_contact.ec_lname IS
    'Emergency contact last name';

COMMENT ON COLUMN emergency_contact.ec_phone IS
    'Emergency contact phone number';

ALTER TABLE emergency_contact
    ADD CONSTRAINT fk_patient_emergency FOREIGN KEY (
        patient_no
    )
        REFERENCES patient (
            patient_no
        );

ALTER TABLE emergency_contact
    ADD CONSTRAINT ec_pk PRIMARY KEY (
        contact_id
    );

DROP SEQUENCE contact_id_seq;

CREATE SEQUENCE contact_id_seq
    START WITH 100
    INCREMENT BY 1;

INSERT INTO emergency_contact (
    contact_id,
    ec_id,
    patient_no,
    ec_fname,
    ec_lname,
    ec_phone
)
    SELECT
        contact_id_seq.nextval,
        ecb.ec_id, -- Retain the existing emergency contact ID
        p.patient_no, -- Maintain the link to the patient
        ecb.ec_fname, -- First name of the emergency contact
        ecb.ec_lname, -- Last name of the emergency contact
        ecb.ec_phone -- Phone number of the contact
    FROM
        ec_backup ecb
        JOIN patient p
        ON ecb.ec_id = p.ec_id;

DROP TABLE ec_backup CASCADE CONSTRAINTS;

ALTER TABLE patient DROP COLUMN ec_id;

DESC patient;

DESC emergency_contact;

SELECT
    ec.contact_id,
    ec.ec_id,
    ec.patient_no,
    p.patient_fname
    || ' '
    || p.patient_lname AS patient_name,
    ec.ec_fname
    || ' '
    || ec.ec_lname     AS contact_name,
    ec.ec_phone
FROM
    emergency_contact ec
    LEFT JOIN patient p
    ON ec.patient_no = p.patient_no
ORDER BY
    ec.contact_id,
    ec.patient_no;

/*
(c)
*/
DROP TABLE training CASCADE CONSTRAINTS;

CREATE TABLE training (
    training_id NUMBER(10) NOT NULL,
    train_desc VARCHAR(255) NOT NULL,
    train_startdt DATE NOT NULL,
    train_enddt DATE NOT NULL
);

ALTER TABLE training
    ADD CONSTRAINT training_pk PRIMARY KEY (
        training_id
    );

COMMENT ON COLUMN training.training_id IS 'Training session identifier';

COMMENT ON COLUMN training.train_desc IS 'Description of training session';

COMMENT ON COLUMN training.train_startdt IS 'Start datetime of training session';

COMMENT ON COLUMN training.train_enddt IS 'End datetime of training session';

DROP TABLE nurse_training CASCADE CONSTRAINTS;

CREATE TABLE nurse_training (
    session_id NUMBER(3) NOT NULL,
    nurse_no NUMBER(3) NOT NULL,
    training_id NUMBER(10) NOT NULL,
    trainer_no NUMBER(3) NOT NULL
);

COMMENT ON COLUMN nurse_training.session_id IS 'Training session surrogate key';

ALTER TABLE nurse_training
    ADD CONSTRAINT fk_nurse_training_nurse FOREIGN KEY (
        nurse_no
    )
        REFERENCES nurse (
            nurse_no
        );

ALTER TABLE nurse_training
    ADD CONSTRAINT fk_nurse_training_training FOREIGN KEY (
        training_id
    )
        REFERENCES training (
            training_id
        );

ALTER TABLE nurse_training
    ADD CONSTRAINT fk_nurse_training_trainer FOREIGN KEY (
        trainer_no
    )
        REFERENCES nurse (
            nurse_no
        );

ALTER TABLE nurse_training
    ADD CONSTRAINT nurse_training_pk PRIMARY KEY (
        session_id
    );

DESC training;

DESC nurse_training;

COMMIT;