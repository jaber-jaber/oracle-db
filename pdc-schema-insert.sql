/*
  Databases Assignment 2
  -- PDC Schema and Initial Data--
  -- pdc-schema-insert.sql

  Description:
  This file creates the Precision Dental Care tables
  and populates several of the tables (those shown in purple on the supplied model).
  You should read this schema file carefully
  and be sure you understand the various data requirements.

Author: FIT Database Teaching Team
License: Copyright Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice.

*/

-- Create tables

DROP TABLE appointment CASCADE CONSTRAINTS;

DROP TABLE appt_serv CASCADE CONSTRAINTS;

DROP TABLE apptservice_item CASCADE CONSTRAINTS;

DROP TABLE emergency_contact CASCADE CONSTRAINTS;

DROP TABLE item CASCADE CONSTRAINTS;

DROP TABLE nurse CASCADE CONSTRAINTS;

DROP TABLE patient CASCADE CONSTRAINTS;

DROP TABLE provider CASCADE CONSTRAINTS;

DROP TABLE provider_service CASCADE CONSTRAINTS;

DROP TABLE service CASCADE CONSTRAINTS;

DROP TABLE specialisation CASCADE CONSTRAINTS;

CREATE TABLE appointment (
    appt_no           NUMBER(7) NOT NULL,
    appt_datetime     DATE NOT NULL,
    appt_roomno       NUMBER(2) NOT NULL,
    appt_length       CHAR(1) NOT NULL,
    patient_no        NUMBER(4) NOT NULL,
    provider_code     CHAR(6) NOT NULL,
    nurse_no          NUMBER(3) NOT NULL,
    appt_prior_apptno NUMBER(7)
);

ALTER TABLE appointment
    ADD CONSTRAINT appt_length_chk CHECK ( appt_length IN ( 'L', 'S', 'T' ) );

COMMENT ON COLUMN appointment.appt_no IS
    'Appointment identifier (surrogate PK)';

COMMENT ON COLUMN appointment.appt_datetime IS
    'Date and time of appointment';

COMMENT ON COLUMN appointment.appt_roomno IS
    'Room in which appointment is scheduled to take place';

COMMENT ON COLUMN appointment.appt_length IS
    'Length of appointment - Short, Standard or Long (S, T or L)';

COMMENT ON COLUMN appointment.patient_no IS
    'Patient number (identifier)';

COMMENT ON COLUMN appointment.provider_code IS
    'Provider identifier';

COMMENT ON COLUMN appointment.nurse_no IS
    'Identifier for nurse
';

COMMENT ON COLUMN appointment.appt_prior_apptno IS
    'Appointment identifier (surrogate PK)';

ALTER TABLE appointment ADD CONSTRAINT appointment_pk PRIMARY KEY ( appt_no );

ALTER TABLE appointment ADD CONSTRAINT patient_nk1 UNIQUE ( appt_datetime,
                                                            patient_no );

ALTER TABLE appointment ADD CONSTRAINT patient_nk2 UNIQUE ( provider_code,
                                                            appt_datetime );

ALTER TABLE appointment ADD CONSTRAINT patient_nk3 UNIQUE ( appt_datetime,
                                                            appt_roomno );

ALTER TABLE appointment ADD CONSTRAINT priorappt_uq UNIQUE ( appt_prior_apptno );

CREATE TABLE appt_serv (
    appt_no           NUMBER(7) NOT NULL,
    service_code      CHAR(4) NOT NULL,
    apptserv_fee      NUMBER(6, 2),
    apptserv_itemcost NUMBER(6, 2)
);

COMMENT ON COLUMN appt_serv.appt_no IS
    'Appointment identifier (surrogate PK)';

COMMENT ON COLUMN appt_serv.service_code IS
    'Identifier for services';

COMMENT ON COLUMN appt_serv.apptserv_fee IS
    'Actual fee charged for service';

COMMENT ON COLUMN appt_serv.apptserv_itemcost IS
    'Total cost of items needed for the service';

ALTER TABLE appt_serv ADD CONSTRAINT appoint_serv_pk PRIMARY KEY ( service_code,
                                                                   appt_no );

CREATE TABLE apptservice_item (
    as_id            NUMBER(7) NOT NULL,
    appt_no          NUMBER(7) NOT NULL,
    service_code     CHAR(4) NOT NULL,
    item_id          NUMBER(4) NOT NULL,
    as_item_quantity NUMBER(3) NOT NULL
);

COMMENT ON COLUMN apptservice_item.as_id IS
    'Appointment service item identifier (surrogate PK)';

COMMENT ON COLUMN apptservice_item.appt_no IS
    'Appointment identifier (surrogate PK)';

COMMENT ON COLUMN apptservice_item.service_code IS
    'Identifier for services';

COMMENT ON COLUMN apptservice_item.item_id IS
    'Item identifier';

COMMENT ON COLUMN apptservice_item.as_item_quantity IS
    'Number of item used for the appointment service';

ALTER TABLE apptservice_item ADD CONSTRAINT apptservice_item_pk PRIMARY KEY ( as_id )
;

ALTER TABLE apptservice_item
    ADD CONSTRAINT appserviceitem_nk UNIQUE ( appt_no,
                                              service_code,
                                              item_id );

CREATE TABLE emergency_contact (
    ec_id    NUMBER(4) NOT NULL,
    ec_fname VARCHAR2(30),
    ec_lname VARCHAR2(30),
    ec_phone CHAR(10) NOT NULL
);

COMMENT ON COLUMN emergency_contact.ec_id IS
    'Emergency contact identifier';

COMMENT ON COLUMN emergency_contact.ec_fname IS
    'Emergency contact first name';

COMMENT ON COLUMN emergency_contact.ec_lname IS
    'Emergency contact last name';

COMMENT ON COLUMN emergency_contact.ec_phone IS
    'Emergency contact phone number';

ALTER TABLE emergency_contact ADD CONSTRAINT emergency_contact_pk PRIMARY KEY ( ec_id
);

ALTER TABLE emergency_contact ADD CONSTRAINT emergency_contact_nk UNIQUE ( ec_phone )
;

CREATE TABLE item (
    item_id      NUMBER(4) NOT NULL,
    item_desc    VARCHAR2(50) NOT NULL,
    item_stdcost NUMBER(5, 2) NOT NULL,
    item_stock   NUMBER(4) NOT NULL
);

COMMENT ON COLUMN item.item_id IS
    'Item identifier';

COMMENT ON COLUMN item.item_desc IS
    'Item description';

COMMENT ON COLUMN item.item_stdcost IS
    'Item standard cost';

COMMENT ON COLUMN item.item_stock IS
    'Item quantity on hand (in stock)';

ALTER TABLE item ADD CONSTRAINT item_pk PRIMARY KEY ( item_id );

CREATE TABLE nurse (
    nurse_no           NUMBER(3) NOT NULL,
    nurse_fname        VARCHAR2(30),
    nurse_lname        VARCHAR2(30),
    nurse_contactno    CHAR(10) NOT NULL,
    nurse_employstatus CHAR(1) NOT NULL
);

ALTER TABLE nurse
    ADD CONSTRAINT nrsemploystatus_chk CHECK ( nurse_employstatus IN ( 'C', 'F', 'T' )
    );

COMMENT ON COLUMN nurse.nurse_no IS
    'Identifier for nurse
';

COMMENT ON COLUMN nurse.nurse_fname IS
    'Nurse first name';

COMMENT ON COLUMN nurse.nurse_lname IS
    'Nurse last name';

COMMENT ON COLUMN nurse.nurse_contactno IS
    'Nurse contact number';

COMMENT ON COLUMN nurse.nurse_employstatus IS
    'Nurse employment status: Casual (C), Contract (T), Fulltime (F)
';

ALTER TABLE nurse ADD CONSTRAINT nurse_pk PRIMARY KEY ( nurse_no );

CREATE TABLE patient (
    patient_no            NUMBER(4) NOT NULL,
    patient_fname         VARCHAR2(30),
    patient_lname         VARCHAR2(30),
    patient_street        VARCHAR2(50) NOT NULL,
    patient_city          VARCHAR2(20) NOT NULL,
    patient_state         VARCHAR2(3) NOT NULL,
    patient_postcode      CHAR(4) NOT NULL,
    patient_dob           DATE NOT NULL,
    patient_contactmobile CHAR(10) NOT NULL,
    patient_contactemail  VARCHAR2(25) NOT NULL,
    ec_id                 NUMBER(4) NOT NULL
);

ALTER TABLE patient
    ADD CONSTRAINT patient_state_chk CHECK ( patient_state IN ( 'ACT', 'NSW', 'NT', 'QLD'
    , 'SA',
                                                                'TAS', 'VIC', 'WA' ) )
                                                                ;

COMMENT ON COLUMN patient.patient_no IS
    'Patient number (identifier)';

COMMENT ON COLUMN patient.patient_fname IS
    'Patient first name';

COMMENT ON COLUMN patient.patient_lname IS
    'Patient last name';

COMMENT ON COLUMN patient.patient_street IS
    'Patient residential street address';

COMMENT ON COLUMN patient.patient_city IS
    'Patient residential city';

COMMENT ON COLUMN patient.patient_state IS
    'Patient residential state - NT, QLD, NSW, ACT, VIC, TAS, SA, or WA';

COMMENT ON COLUMN patient.patient_postcode IS
    'Patient residential postcode';

COMMENT ON COLUMN patient.patient_dob IS
    'Patient date of birth';

COMMENT ON COLUMN patient.patient_contactmobile IS
    'Patient contact mobile phone number';

COMMENT ON COLUMN patient.patient_contactemail IS
    'Patient contact email address';

COMMENT ON COLUMN patient.ec_id IS
    'Emergency contact identifier';

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( patient_no );

CREATE TABLE provider (
    provider_code   CHAR(6) NOT NULL,
    provider_title  VARCHAR2(10),
    provider_fname  VARCHAR2(30),
    provider_lname  VARCHAR2(30),
    provider_roomno NUMBER(2) NOT NULL,
    spec_id         NUMBER(3)
);

COMMENT ON COLUMN provider.provider_code IS
    'Provider identifier';

COMMENT ON COLUMN provider.provider_title IS
    'Provider title';

COMMENT ON COLUMN provider.provider_fname IS
    'Provider first name';

COMMENT ON COLUMN provider.provider_lname IS
    'Provider last name';

COMMENT ON COLUMN provider.provider_roomno IS
    'Providers default room number';

COMMENT ON COLUMN provider.spec_id IS
    'Specialisation identifier';

ALTER TABLE provider ADD CONSTRAINT provider_pk PRIMARY KEY ( provider_code );

CREATE TABLE provider_service (
    provider_code CHAR(6) NOT NULL,
    service_code  CHAR(4) NOT NULL
);

COMMENT ON COLUMN provider_service.provider_code IS
    'Provider identifier';

COMMENT ON COLUMN provider_service.service_code IS
    'Identifier for services';

ALTER TABLE provider_service ADD CONSTRAINT provider_service_pk PRIMARY KEY ( provider_code
,
                                                                              service_code
                                                                              );

CREATE TABLE service (
    service_code   CHAR(4) NOT NULL,
    service_desc   VARCHAR2(50) NOT NULL,
    service_stdfee NUMBER(6, 2) NOT NULL
);

COMMENT ON COLUMN service.service_code IS
    'Identifier for services';

COMMENT ON COLUMN service.service_desc IS
    'Service description';

COMMENT ON COLUMN service.service_stdfee IS
    'Standard charge for service';

ALTER TABLE service ADD CONSTRAINT service_pk PRIMARY KEY ( service_code );

CREATE TABLE specialisation (
    spec_id   NUMBER(3) NOT NULL,
    spec_name VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN specialisation.spec_id IS
    'Specialisation identifier';

COMMENT ON COLUMN specialisation.spec_name IS
    'specialisation name';

ALTER TABLE specialisation ADD CONSTRAINT specialisation_pk PRIMARY KEY ( spec_id );

ALTER TABLE appt_serv
    ADD CONSTRAINT appoint_apptserv FOREIGN KEY ( appt_no )
        REFERENCES appointment ( appt_no );

ALTER TABLE appointment
    ADD CONSTRAINT apptmnt_followupappmnt FOREIGN KEY ( appt_prior_apptno )
        REFERENCES appointment ( appt_no );

ALTER TABLE apptservice_item
    ADD CONSTRAINT apptserv_asitem FOREIGN KEY ( service_code,
                                                 appt_no )
        REFERENCES appt_serv ( service_code,
                               appt_no );

ALTER TABLE patient
    ADD CONSTRAINT emercontact_patient FOREIGN KEY ( ec_id )
        REFERENCES emergency_contact ( ec_id );

ALTER TABLE apptservice_item
    ADD CONSTRAINT item_asitem FOREIGN KEY ( item_id )
        REFERENCES item ( item_id );

ALTER TABLE appointment
    ADD CONSTRAINT nurse_appointment FOREIGN KEY ( nurse_no )
        REFERENCES nurse ( nurse_no );

ALTER TABLE appointment
    ADD CONSTRAINT patient_appointment FOREIGN KEY ( patient_no )
        REFERENCES patient ( patient_no );

ALTER TABLE appointment
    ADD CONSTRAINT provider_appointment FOREIGN KEY ( provider_code )
        REFERENCES provider ( provider_code );

ALTER TABLE provider_service
    ADD CONSTRAINT provider_provsrv FOREIGN KEY ( provider_code )
        REFERENCES provider ( provider_code );

ALTER TABLE appt_serv
    ADD CONSTRAINT service_apptserv FOREIGN KEY ( service_code )
        REFERENCES service ( service_code );

ALTER TABLE provider_service
    ADD CONSTRAINT service_provsrv FOREIGN KEY ( service_code )
        REFERENCES service ( service_code );

ALTER TABLE provider
    ADD CONSTRAINT specialisation_provider FOREIGN KEY ( spec_id )
        REFERENCES specialisation ( spec_id );

-- Insert Initial data
--===SERVICE===--
--Diagnostic
insert into service values(
'D001','Oral examination','65');

insert into service values(
'D002','Extended Consultation - 30 mins or more','75');

insert into service values(
'D003','Diagnostic model','60');

--X Ray

insert into service values(
'X001','Intraoral radiograph - per x-ray','45');

insert into service values(
'X002','Panoramic radiograph - per x-ray','85');

--Preventive Dentistry

insert into service values(
'P001','Removal of plaque and / or stain','90');

insert into service values(
'P002','Removal of calculus','165');

insert into service values(
'P003','Fissure sealing','58');

--Periodontics and Gum Care
insert into service values(
'PG01','Treatment of acute periodontal infection','170');

insert into service values(
'PG02','Root planing and subgingival curettage:per tooth','120');

--Extraction and Teeth Removal
insert into service values(
'EX01','Removal of a tooth or part thereof','175');

insert into service values(
'EX02','Surgical removal of a tooth','425');

insert into service values(
'EX03','Dental bone grafts','500');

--Root Canal Treatment
insert into service values(
'RC01','Preparation of root canal - one canal','225');

insert into service values(
'RC02','Preparation of root canal - each additional canal','120');

insert into service values(
'RC03','Root canal obturation - one canal','265');

insert into service values(
'RC04','Root canal obturation - each additional canal','120');

--Composite Dental Fillings
insert into service values(
'DF01','Anterior Filling (front teeth)','175');

insert into service values(
'DF02','Posterior Filling (back teeth)','185');

--Dental Veneers
insert into service values(
'DV01','Veneer Cusp capping','175');

insert into service values(
'DV02','Veneer - composite','185');

insert into service values(
'DV03','Veneer - porcelain','185');

insert into service values(
'DV04','Post Veneer','165');

--Dental Crown and Bridges
insert into service values(
'DC01','Preparation for crown','175');

insert into service values(
'DC02','Full crown - CEREC same day crown','1500');

insert into service values(
'DC03','Full crown','1200');

insert into service values(
'DC04','Post and core for crown','250');

insert into service values(
'DC05','Recementing crown or veneer','150');

--Dentures and Repairs
insert into service values(
'DT01','Impressions of jaw','300');

insert into service values(
'DT02','Denture Occlusive registration','200');

insert into service values(
'DT03','Denture Wax trial','250');

insert into service values(
'DT04','Denture fitting','800');

insert into service values(
'DT05','Cleaning and polishing of existing denture','80');

--Orthodontics
insert into service values(
'OT01','Design treatment','500');

insert into service values(
'OT02','Brace placement','3000');

insert into service values(
'OT03','Wire insertion','1000');

insert into service values(
'OT04','Brace Adjustments','100');

--===ITEM===--
--Endodontic
insert into item values(
1,'Paper tips',1,1000);

insert into item values(
2,'Sodium hypochlorite 5.25%',6,100);

insert into item values(
3,'EDTA Cleansing Gel 17%',8,200);

insert into item values(
4,'Irrigation Solution 2% Chlorhexidine',9,100);

insert into item values(
5,'Sterile K NiTi files',7,150);

insert into item values(
6,'Universal Clamp',15,150);

insert into item values(
7,'Portalimas sponges 1 cm',0.5,500);

insert into item values(
8,'Irrigation Needle and Syringe',2,150);


--Orthodontic
insert into item values(
9,'Metal Bracket',1.5,1000);

insert into item values(
10,'Molar mouth tube',2,1000);

insert into item values(
11,'Archwire',2,1000);

insert into item values(
12,'Curved lingual button',1,1000);

insert into item values(
13,'Direct cementation tubes',1,1000);

--Dental Sutures
insert into item values(
14,'Silk surture',2,500);

insert into item values(
15,'Absorbable surture',3,500);

--Dental Composites (for filling or seals)
insert into item values(
16,'Universal composite',48,100);

insert into item values(
17,'Universal restorative composite',46,50);

insert into item values(
18,'Fluid composite',78,50);

insert into item values(
19,'Herculite XRV: For Dental Fillings',42,100);

--xray
insert into item values(
20,'Phospor imaging plate',75,100);

insert into item values(
21,'Clinasept Film',5,100);

--filling
insert into item values(
22,'Porcelain Etch',35,50);

insert into item values(
23,'Silane',25,50);

--===SPECIALISATION==--

INSERT INTO specialisation VALUES (
    101,
    'Endodontics'
);

INSERT INTO specialisation VALUES (
    102,
    'Oral surgery'
);

INSERT INTO specialisation VALUES (
    103,
    'Orthodontics'
);

INSERT INTO specialisation VALUES (
    104,
    'Paediatric dentistry'
);

INSERT INTO specialisation VALUES (
    105,
    'Periodontics'
);

INSERT INTO specialisation VALUES (
    106,
    'Prosthodontics'
);

--===PROVIDER==--
INSERT INTO provider VALUES (
    'END001',
    'Dr',
    'Mark',
    'Stanton',
    1,
    101
);

INSERT INTO provider VALUES (
    'GEN001',
    'Dr',
    'Bruce',
    'Striplin',
    2,
    NULL
);

INSERT INTO provider VALUES (
    'GEN002',
    'Dr',
    'Amalia',
    'Morris',
    3,
    NULL
);

INSERT INTO provider VALUES (
    'GEN003',
    'Dr',
    NULL,
    'Corner',
    4,
    NULL
);

INSERT INTO provider VALUES (
    'ORS001',
    'Dr',
    'Jessica',
    'Jones',
    5,
    102
);

INSERT INTO provider VALUES (
    'PED001',
    'Dr',
    'Kevin',
    'Barr',
    6,
    104
);

INSERT INTO provider VALUES (
    'PED002',
    'Dr',
    NULL,
    'Lee',
    7,
    104
);

INSERT INTO provider VALUES (
    'ORT001',
    'Dr',
    'Gerry',
    'Elliott',
    8,
    103
);

INSERT INTO provider VALUES (
    'AST001',
    NULL,
    'Katie',
    NULL,
    9,
    NULL
);

INSERT INTO provider VALUES (
    'AST002',
    NULL,
    'James',
    'Remaley',
    10,
    NULL
);

INSERT INTO provider VALUES (
    'PER001',
    'Dr',
    'April',
    'Manahan',
    11,
    105
);

INSERT INTO provider VALUES (
    'PER002',
    'Dr',
    'Joseph',
    'Hazelton',
    12,
    105
);

INSERT INTO provider VALUES (
    'PRO001',
    'Dr',
    'Jane',
    'Fransen',
    13,
    106
);

--===PROVIDER_SERVICE===--
insert into provider_service
values('AST001', 'X001');
insert into provider_service
values('AST001', 'X002');
insert into provider_service
values('AST001', 'P001');
insert into provider_service
values('AST001', 'P002');
insert into provider_service
values('AST001', 'P003');

insert into provider_service
values('AST002', 'X001');
insert into provider_service
values('AST002', 'X002');
insert into provider_service
values('AST002', 'P001');
insert into provider_service
values('AST002', 'P002');
insert into provider_service
values('AST002', 'P003');


insert into provider_service
values('END001', 'D002');
insert into provider_service
values('END001', 'RC01');
insert into provider_service
values('END001', 'RC02');
insert into provider_service
values('END001', 'RC03');
insert into provider_service
values('END001', 'RC04');

insert into provider_service
values('GEN001', 'D001');
insert into provider_service
values('GEN001', 'D002');
insert into provider_service
values('GEN001', 'P001');
insert into provider_service
values('GEN001', 'P002');
insert into provider_service
values('GEN001', 'P003');
insert into provider_service
values('GEN001', 'EX01');
insert into provider_service
values('GEN001', 'DF01');
insert into provider_service
values('GEN001', 'DF02');

insert into provider_service
values('GEN002', 'D001');
insert into provider_service
values('GEN002', 'D002');
insert into provider_service
values('GEN002', 'D003');
insert into provider_service
values('GEN002', 'P001');
insert into provider_service
values('GEN002', 'P002');
insert into provider_service
values('GEN002', 'P003');
insert into provider_service
values('GEN002', 'EX01');
insert into provider_service
values('GEN002', 'DF01');
insert into provider_service
values('GEN002', 'DF02');

insert into provider_service
values('GEN003', 'D001');
insert into provider_service
values('GEN003', 'D002');
insert into provider_service
values('GEN003', 'P001');
insert into provider_service
values('GEN003', 'P002');
insert into provider_service
values('GEN003', 'P003');
insert into provider_service
values('GEN003', 'EX01');
insert into provider_service
values('GEN003', 'DF01');
insert into provider_service
values('GEN003', 'DF02');

insert into provider_service
values('ORS001', 'D002');
insert into provider_service
values('ORS001', 'EX01');
insert into provider_service
values('ORS001', 'EX02');
insert into provider_service
values('ORS001', 'EX03');

insert into provider_service
values('ORT001', 'D002');
insert into provider_service
values('ORT001', 'OT01');
insert into provider_service
values('ORT001', 'OT02');
insert into provider_service
values('ORT001', 'OT03');
insert into provider_service
values('ORT001', 'OT04');

insert into provider_service
values('PED001', 'D001');
insert into provider_service
values('PED001', 'D002');
insert into provider_service
values('PED001', 'P001');
insert into provider_service
values('PED001', 'P002');
insert into provider_service
values('PED001', 'P003');
insert into provider_service
values('PED001', 'EX01');

insert into provider_service
values('PED002', 'D001');
insert into provider_service
values('PED002', 'D002');
insert into provider_service
values('PED002', 'P001');
insert into provider_service
values('PED002', 'P002');
insert into provider_service
values('PED002', 'P003');
insert into provider_service
values('PED002', 'EX01');

insert into provider_service
values('PER001', 'D002');
insert into provider_service
values('PER001', 'PG01');
insert into provider_service
values('PER001', 'PG02');

insert into provider_service
values('PER002', 'D002');
insert into provider_service
values('PER002', 'PG01');
insert into provider_service
values('PER002', 'PG02');

insert into provider_service
values('PRO001', 'D002');
insert into provider_service
values('PRO001', 'DV01');
insert into provider_service
values('PRO001', 'DV02');
insert into provider_service
values('PRO001', 'DV03');
insert into provider_service
values('PRO001', 'DV04');
insert into provider_service
values('PRO001', 'DC01');
insert into provider_service
values('PRO001', 'DC02');
insert into provider_service
values('PRO001', 'DC03');
insert into provider_service
values('PRO001', 'DC04');
insert into provider_service
values('PRO001', 'DC05');
insert into provider_service
values('PRO001', 'DT01');
insert into provider_service
values('PRO001', 'DT02');
insert into provider_service
values('PRO001', 'DT03');
insert into provider_service
values('PRO001', 'DT04');
insert into provider_service
values('PRO001', 'DT05');

--===NURSE==--
INSERT INTO nurse VALUES (
    1,
    'Seth',
    'Raws',
    '0487660799',
    'F'
);

INSERT INTO nurse VALUES (
    2,
    'Spencer',
    'Cazaly',
    '0453790650',
    'C'
);

INSERT INTO nurse VALUES (
    3,
    'Anna',
    'Treloar',
    '0482003895',
    'C'
);

INSERT INTO nurse VALUES (
    4,
    'Ellie',
    'Pattison',
    '0453911718',
    'C'
);

INSERT INTO nurse VALUES (
    5,
    'Ben',
    'Leggatt',
    '0453420898',
    'F'
);

INSERT INTO nurse VALUES (
    6,
    'Chelsea',
    'Ford',
    '0445703528',
    'F'
);

INSERT INTO nurse VALUES (
    7,
    'James',
    NULL,
    '0453967998',
    'T'
);

INSERT INTO nurse VALUES (
    8,
    'Kaitlyn',
    'Rivers',
    '0440359423',
    'T'
);

INSERT INTO nurse VALUES (
    9,
    'Kerry',
    'Corner',
    '0447477384',
    'T'
);

INSERT INTO nurse VALUES (
    10,
    'Tayla',
    'Holloway',
    '0494966133',
    'C'
);

INSERT INTO nurse VALUES (
    11,
    'Harry',
    'Lee',
    '0431251610',
    'C'
);

INSERT INTO nurse VALUES (
    12,
    'Mia',
    'Blackall',
    '0490668828',
    'F'
);

INSERT INTO nurse VALUES (
    13,
    'Phoebe',
    'Irving',
    '0437180467',
    'T'
);

INSERT INTO nurse VALUES (
    14,
    'Katie',
    NULL,
    '0435657357',
    'C'
);

INSERT INTO nurse VALUES (
    15,
    'Mariam',
    'Trebelo',
    '0440000593',
    'T'
);

--===EMERGENCY_CONTACT===--
INSERT INTO emergency_contact VALUES (
    1,
    'Sarah',
    'Johnson',
    '0446129124'
);

INSERT INTO emergency_contact VALUES (
    2,
    'Elizabeth',
    NULL,
    '0345779594'
);

INSERT INTO emergency_contact VALUES (
    3,
    'Alexander',
    'Soares',
    '0482120455'
);

INSERT INTO emergency_contact VALUES (
    4,
    'Andrew',
    'Hansman',
    '0395333172'
);

INSERT INTO emergency_contact VALUES (
    5,
    NULL,
    'Bayldon',
    '049095805'
);

INSERT INTO emergency_contact VALUES (
    6,
    'Mira',
    'Hansman',
    '0493536124'
);

INSERT INTO emergency_contact VALUES (
    7,
    'Madeleine',
    'McBurney',
    '0440831050'
);

INSERT INTO emergency_contact VALUES (
    8,
    'Zac',
    'Harpur',
    '0483010519'
);

INSERT INTO emergency_contact VALUES (
    9,
    'Flynn',
    'Verdon',
    '0445077056'
);

INSERT INTO emergency_contact VALUES (
    10,
    'Austin',
    'Hain',
    '0391379671'
);

--===PATIENT===--
INSERT INTO patient VALUES (
    1,
    'Jake',
    'Auld',
    '46 Glen William Road',
    'Blackburn',
    'VIC',
    '3130',
    TO_DATE('24/APR/1967', 'dd/MON/yyyy'),
    '0482848702',
    'JakeAuld@hourapid.com',
    1
);

INSERT INTO patient VALUES (
    2,
    NULL,
    'Roberts',
    'Unit 3, 13 Moruya Road',
    'Mooroolbark',
    'VIC',
    '3138',
    TO_DATE('04/APR/1996', 'dd/MON/yyyy'),
    '0461643245',
    'BrookeRoberts@spi.com',
    2
);

INSERT INTO patient VALUES (
    3,
    'Darcy',
    NULL,
    '18 Farnell Street',
    'Warrandyte',
    'VIC',
    '3113',
    TO_DATE('03/MAY/1951', 'dd/MON/yyyy'),
    '0440814836',
    'DSoares71@hour.com',
    3
);

INSERT INTO patient VALUES (
    4,
    'Marie-Rose',
    'Johnson',
    '46 Glen William Road',
    'Blackburn',
    'VIC',
    '3130',
    TO_DATE('28/JUN/2010', 'dd/MON/yyyy'),
    '0446129124',
    'Johnsons@klog.com',
    1
);

INSERT INTO patient VALUES (
    5,
    'Sally',
    'Johnson',
    '46 Glen William Road',
    'Blackburn',
    'VIC',
    '3130',
    TO_DATE('31/JAN/2013', 'dd/MON/yyyy'),
    '0446129124',
    'Johnsons@klog.com',
    1
);

INSERT INTO patient VALUES (
    6,
    'Gemma',
    'Hansman',
    '37 Bayview Road',
    'Tyringa',
    'SA',
    '5671',
    TO_DATE('03/MAR/1980', 'dd/MON/yyyy'),
    '0487186889',
    'GemmaHansman@reefblue.com',
    4
);

INSERT INTO patient VALUES (
    7,
    'Charli',
    'Hansman',
    '37 Bayview Road',
    'Tyringa',
    'SA',
    '5671',
    TO_DATE('03/DEC/2015', 'dd/MON/yyyy'),
    '0487186889',
    'GemmaHansman@reefblue.com',
    4
);

INSERT INTO patient VALUES (
    8,
    'Alice',
    'Bayldon',
    '33 Sunset Drive',
    'Saint Helena',
    'VIC',
    '3088',
    TO_DATE('09/NOV/2016', 'dd/MON/yyyy'),
    '0449724439',
    'Bayldons@redkite.com.au',
    5
);

INSERT INTO patient VALUES (
    9,
    'Ashley',
    'Soares',
    '14 Davis Street',
    'Donvale',
    'VIC',
    '3111',
    TO_DATE('16/MAY/1975', 'dd/MON/yyyy'),
    '0440814836',
    'Ashley4173@kmpl.org',
    3
);

INSERT INTO patient VALUES (
    10,
    'Imogen',
    NULL,
    '38 Mandible Street',
    'Yellingbo',
    'VIC',
    '3139',
    TO_DATE('16/JUN/2014', 'dd/MON/yyyy'),
    '0445070410',
    'ImoHan@raindrop.com.au',
    6
);

INSERT INTO patient VALUES (
    11,
    'Joshua',
    'McBurney',
    '42 Bass Street',
    'Mooroolbark',
    'VIC',
    '3138',
    TO_DATE('22/OCT/2017', 'dd/MON/yyyy'),
    '0440831050',
    'McBurneyFam@gmail.com',
    7
);

INSERT INTO patient VALUES (
    12,
    'Thalia',
    'McBurney',
    '42 Bass Street',
    'Mooroolbark',
    'VIC',
    '3138',
    TO_DATE('18/FEB/2019', 'dd/MON/yyyy'),
    '0440831050',
    'McBurneyFam@gmail.com',
    7
);

INSERT INTO patient VALUES (
    13,
    'Rebecca',
    'Ricardo',
    '49 Thule Drive',
    'Warrandyte',
    'VIC',
    '3113',
    TO_DATE('14/MAR/1985', 'dd/MON/yyyy'),
    '0483696525',
    'BecRicardo@telworm.com',
    8
);

INSERT INTO patient VALUES (
    14,
    'Jonathan',
    'Jageurs',
    '18 Banksia Court',
    'Kalkallo',
    'VIC',
    '3064',
    TO_DATE('22/SEP/1961', 'dd/MON/yyyy'),
    '0440352782',
    'JonJageurs@armypet.com',
    9
);
INSERT INTO patient VALUES (
    15,
    'Anthony',
    'Raggatt',
    '51 Ghost Hill Road',
    'Kalkallo',
    'VIC',
    '3064',
    TO_DATE('05/APR/1997', 'dd/MON/yyyy'),
    '0447793731',
    'ARaggat@ylkie.com',
    10
);

INSERT INTO patient VALUES (
    16,
    'Lincoln',
    'Hansman',
    '38 Mandible Street',
    'Yellingbo',
    'VIC',
    '3139',
    TO_DATE('10/SEP/1972', 'dd/MON/yyyy'),
    '0462975870',
    'Lincoln@raindrop.com.au',
    6
);

commit;
