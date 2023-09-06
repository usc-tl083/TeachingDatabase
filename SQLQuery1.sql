
/* 'DROP TABLE' DELETES TABLE AND DATA IF EXISTENT */
/* 'IF EXISTS' ALLOWS STATEMENT TO SUCCEED WITHOUT ERROR EVEN IF TABLE DOES NOT EXIST */
/* PURPOSE IS TO REMOVE EXISTING STORED VIEWS AND PROCEDURES TO AVOID REDUCING PROGRAM */
/* SPEED DUE TO STORAGE OF UNNECESSARY DATA */
DROP TABLE IF EXISTS STAFF;
DROP TABLE IF EXISTS TEACHING_EXPERIENCE;
DROP TABLE IF EXISTS OTHER_EXPERIENCE;
DROP TABLE IF EXISTS DOCUMENTS;
DROP TABLE IF EXISTS PUBLICATIONS;
DROP TABLE IF EXISTS ADDITIONAL_NOTES;
DROP TABLE IF EXISTS QUALIFICATIONS;
DROP TABLE IF EXISTS AQF_LEVELS;
DROP TABLE IF EXISTS APPROVAL;
DROP TABLE IF EXISTS REVIEW;

/* CREATION OF DATABASE TABLES */
/* CREATION OF REQUIRED ENTITIES AND SET INPUT VALUE RESTRICTIONS AND REQUIREMENTS */
/* SET PRIMARY KEYS AND FOREIGN KEYS OF DATABASE TABLES */
CREATE TABLE STAFF (
	STAFF_ID INT IDENTITY(1,1) NOT NULL,
	TITLE VARCHAR(5) NOT NULL,
	FIRST_NAME VARCHAR(50) NOT NULL,
	LAST_NAME VARCHAR(50) NOT NULL,
	ADDRESS VARCHAR(50) NOT NULL,
	EMAIL VARCHAR(100) NOT NULL,
	PHONE INT NOT NULL,
    PRIMARY KEY (STAFF_ID)
);

CREATE TABLE TEACHING_EXPERIENCE (
	STAFF_ID INT IDENTITY(1,1) NOT NULL, 
	JOINING_DATE DATE NOT NULL, 
	FINISH_DATE DATE NOT NULL, 
	COURSE_ID INT NOT NULL,
	COURSE_TITLE VARCHAR(50) NOT NULL, 
	ORGANISATION_ID INT NOT NULL, 
	ROLE_ID INT NOT NULL,
    CONSTRAINT FK_STAFF_ID FOREIGN KEY (STAFF_ID) 
    REFERENCES STAFF(STAFF_ID)
);

CREATE TABLE OTHER_EXPERIENCE (
	STAFF_ID INT NOT NULL,
	EMP_NAME VARCHAR(50) NOT NULL,
	POSITION VARCHAR(50),
	WORK_STATUS VARCHAR(50),
	JOINING_DATE DATE NOT NULL, 
	FINISH_DATE DATE NOT NULL,
	DUTIES VARCHAR(250),
    CONSTRAINT FK_STAFF_ID FOREIGN KEY (STAFF_ID) 
    REFERENCES STAFF(STAFF_ID)
    );

CREATE TABLE DOCUMENTS (
	DOC_ID INT IDENTITY(1,1) NOT NULL, 
	STAFF_ID INT NOT NULL, 
	DOC_NAME VARCHAR(100) NOT NULL, 
	DOC_SIGHTED_DATE DATE NOT NULL, 
	DOC_SIGHTED_USER_ID VARCHAR(10) NOT NULL,
	PRIMARY KEY (DOC_ID),
	CONSTRAINT FK_STAFF_ID FOREIGN KEY (STAFF_ID) 
    REFERENCES STAFF(STAFF_ID)
);

CREATE TABLE PUBLICATIONS (
	PUBLICATION_ID INT IDENTITY(1,1) NOT NULL, 
	STAFF_ID INT NOT NULL, 
	PUBLICATION_TITLE VARCHAR(100) NOT NULL, 
	PUBLICATION_YEAR INT NOT NULL, 
	PUBLICATION_TYPE VARCHAR(100) NOT NULL, 
	PEER_REVIEWED VARCHAR(3) NOT NULL, 
	CLASSIFICATION VARCHAR(50) NOT NULL, 
	PRIMARY KEY (PUBLICATION_ID),
	CONSTRAINT FK_STAFF_ID FOREIGN KEY (STAFF_ID) 
    REFERENCES STAFF(STAFF_ID)
);

CREATE TABLE ADDITIONAL_NOTES (
	STAFF_ID INT NOT NULL,
	NOTES VARCHAR(250),
	RECORDED_BY VARCHAR(50) NOT NULL,
	RECORDER_DATE DATE NOT NULL,
	CONSTRAINT FK_STAFF_ID FOREIGN KEY (STAFF_ID) 
    REFERENCES STAFF(STAFF_ID)
);

CREATE TABLE QUALIFICATIONS (
	STAFF_ID INT NOT NULL, 
	AQF_Level_ID INT NOT NULL, 
    QUALIFICATION_NAME VARCHAR(100) NOT NULL,
	SUBJECT_AREA VARCHAR(100) NOT NULL, 
	INSTITUTION_NAME VARCHAR(100) NOT NULL, 
	INSTITUTION_COUNTRY VARCHAR(100) NOT NULL, 
	YEAR_ISSUED INT,
    PRIMARY KEY (AQF_LEVEL_ID),
	CONSTRAINT FK_STAFF_ID FOREIGN KEY (STAFF_ID) 
    REFERENCES STAFF(STAFF_ID)
);

CREATE TABLE AQF_LEVELS (
	AQF_LEVEL_ID INT IDENTITY(1,1) NOT NULL , 
	QUALIFICATION_DEGREE VARCHAR(100) NOT NULL,
	AQF_LEVEL VARCHAR(20) NOT NULL,  
	QUALIFICATION_REQUIREMENT VARCHAR(20) NOT NULL,  
	CONSTRAINT FK_AQF_LEVEL_ID FOREIGN KEY (AQF_LEVEL_ID) 
    REFERENCES QUALIFICATIONS(AQF_LEVEL_ID)
);

CREATE TABLE APPROVAL (
	APPROVAL_ID INT IDENTITY(1,1) NOT NULL, 
	STAFF_ID INT NOT NULL, 
	NEXT_REVIEW_DATE DATE, 
	APPROVAL_DATE DATE NOT NULL, 
	TEACHING_LOCATION VARCHAR(50) NOT NULL, 
	AQF_LEVEL_ID INT NOT NULL, 
	AADMIN_MANAGER_ID INT NOT NULL, 
	COURSE_ID INT NOT NULL, 
	PRIMARY KEY (APPROVAL_ID),
    CONSTRAINT FK_AQF_LEVEL_ID FOREIGN KEY (AQF_LEVEL_ID) 
    REFERENCES QUALIFICATIONS(AQF_LEVEL_ID)
);

CREATE TABLE REVIEW (
	REVIEW_ID INT IDENTITY (1,1) NOT NULL, 
    APPROVAL_ID INT NOT NULL,
	REVIEW_DATE DATE NOT NULL, 
	ADMING_MANAGER_ID INT NOT NULL, 
	OUTCOME VARCHAR(50) NOT NULL, 
	PRIMARY KEY (Review_ID),
	CONSTRAINT FK_APPROVAL_ID FOREIGN KEY (APPROVAL_ID) 
    REFERENCES APPROVAL(APPROVAL_ID)
);