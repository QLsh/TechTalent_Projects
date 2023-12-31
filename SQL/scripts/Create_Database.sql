-- Project: Payroll Management System creation on MySQL
-- Data from https://controllerdata.lacity.org/Payroll/City-Employee-Payroll-Current-/g9h8-fvhu
-- Create databse with appropriate name
DROP DATABASE Payroll;
CREATE DATABASE Payroll;
USE Payroll;

-- renew table lines:
-- DROP TABLE GENERAL_Table;
-- DROP TABLE DEPARTMENT;
-- DROP TABLE JOB;
-- DROP TABLE WELFARE;
-- DROP TABLE PAYMENT;
-- DROP TABLE EMPLOYEE;

-- Create pipeline table to load all data at once
CREATE TABLE GENERAL_Table(
	DEPARTMENT_NO INT NOT NULL,
    DEPARTMENT_TITLE VARCHAR(255) NOT NULL,
    
    JOB_CLASS_PGRADE VARCHAR(255) NOT NULL,
    JOB_TITLE VARCHAR(255) NOT NULL,
    EMPLOYMENT_TYPE VARCHAR(255) NOT NULL,
    JOB_STATUS VARCHAR(255) NOT NULL,
    
    REGULAR_PAY DECIMAL(32,2) NOT NULL,
    OVERTIME_PAY DECIMAL(32,2) NOT NULL,
    ALL_OTHER_PAY DECIMAL(32,2) NOT NULL,
    TOTAL_PAY DECIMAL(32,2) NOT NULL,
    
    CITY_RETIREMENT_CONTRIBUTIONS DECIMAL(32,2) NOT NULL,
    BENEFIT_PAY DECIMAL(32,2) NOT NULL,
    
    LAST_NAME VARCHAR(255) NOT NULL,
    FIRST_NAME VARCHAR(255) NOT NULL,
	PAY_YEAR INT NOT NULL,
    GENDER VARCHAR(255) NOT NULL,
    ETHNICITY VARCHAR(255) NOT NULL,
    RECORD_ID INT NOT NULL AUTO_INCREMENT
    );


-- SHOW VARIABLES LIKE 'local_infile';
-- SET GLOBAL local_infile=true;
LOAD DATA LOCAL INFILE '/Users/qintongli/Desktop/Techtalent_DS_course/SQL/Project/City_Employee_Payroll__Current_ cleaned.csv' 
INTO TABLE GENERAL_Table
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Create tables for the decided entities
--


-- EMPLOYEE
CREATE TABLE EMPLOYEE(
    LAST_NAME VARCHAR(255) NOT NULL,
    FIRST_NAME VARCHAR(255) NOT NULL,
	PAY_YEAR INT NOT NULL,
    GENDER VARCHAR(255) NOT NULL,
    ETHNICITY VARCHAR(255) NOT NULL,
    RECORD_ID INT NOT NULL AUTO_INCREMENT,
    FULL_NAME VARCHAR(255) NOT NULL,
    PRIMARY KEY(RECORD_ID)
);

INSERT INTO EMPLOYEE
SELECT LAST_NAME, FIRST_NAME, PAY_YEAR, GENDER, ETHNICITY, RECORD_ID, CONCAT(LAST_NAME,' ', FIRST_NAME) AS FULL_NAME
FROM GENERAL_Table;

-- DEPARTMENT 
CREATE TABLE DEPARTMENT(
	RECORD_ID INT NOT NULL,
	DEPARTMENT_NO INT NOT NULL,
	DEPARTMENT_TITLE VARCHAR(255) NOT NULL,
    PRIMARY KEY(RECORD_ID)
);

INSERT INTO DEPARTMENT
SELECT RECORD_ID, DEPARTMENT_NO, DEPARTMENT_TITLE
FROM GENERAL_Table;

-- JOB
CREATE TABLE JOB(
	RECORD_ID INT NOT NULL,
    JOB_CLASS_PGRADE VARCHAR(255) NOT NULL,
    JOB_TITLE VARCHAR(255) NOT NULL,
    EMPLOYMENT_TYPE VARCHAR(255) NOT NULL,
    JOB_STATUS VARCHAR(255) NOT NULL,
    FOREIGN KEY(RECORD_ID) REFERENCES EMPLOYEE(RECORD_ID)
);

INSERT INTO JOB
SELECT RECORD_ID,JOB_CLASS_PGRADE, JOB_TITLE, EMPLOYMENT_TYPE, JOB_STATUS
FROM GENERAL_Table;

-- PAYMENT
CREATE TABLE PAYMENT(
	RECORD_ID INT NOT NULL,
    REGULAR_PAY DECIMAL(32,2) NOT NULL,
    OVERTIME_PAY DECIMAL(32,2) NOT NULL,
    ALL_OTHER_PAY DECIMAL(32,2) NOT NULL,
    TOTAL_PAY DECIMAL(32,2) NOT NULL,
    FOREIGN KEY(RECORD_ID) REFERENCES EMPLOYEE(RECORD_ID)
);

INSERT INTO PAYMENT
SELECT RECORD_ID,REGULAR_PAY, OVERTIME_PAY, ALL_OTHER_PAY, TOTAL_PAY
FROM GENERAL_Table;

-- WELFARE
CREATE TABLE WELFARE(
	RECORD_ID INT NOT NULL,
    CITY_RETIREMENT_CONTRIBUTIONS DECIMAL(32,2) NOT NULL,
    BENEFIT_PAY DECIMAL(32,2) NOT NULL,
    FOREIGN KEY(RECORD_ID) REFERENCES EMPLOYEE(RECORD_ID)
);

INSERT INTO WELFARE
SELECT RECORD_ID,CITY_RETIREMENT_CONTRIBUTIONS, BENEFIT_PAY
FROM GENERAL_Table;


