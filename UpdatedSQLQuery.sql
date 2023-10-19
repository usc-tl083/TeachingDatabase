SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

### TEMPORARILY DISABLES REFERENTIAL CONSTRAINTS ###
### ALLOWS FOR THE RECREATION OF TABLES AND INPUT OF DATA IN ANY ORDER ###
SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS TEACHING_DATABASE;

CREATE DATABASE TEACHING_DATABASE;
USE TEACHING_DATABASE;
### 'DROP TABLE' DELETES TABLE AND DATA IF EXISTENT ###
### 'IF EXISTS' ALLOWS STATEMENT TO SUCCEED WITHOUT ERROR EVEN IF TABLE DOES NOT EXIST ###
### PURPOSE IS TO REMOVE EXISTING STORED VIEWS AND PROCEDURES TO AVOID REDUCING PROGRAM ###
### SPEED DUE TO STORAGE OF UNNECESSARY DATA ###
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

### RE-ENABLES CHECKING OF FOREIGN KEY CONSTRAINTS AND INCONSITENCIES ###
SET FOREIGN_KEY_CHECKS = 1;

--
-- Database: `teaching_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `additional_notes`
--

CREATE TABLE `additional_notes` (
  `STAFF_ID` int(10) NOT NULL,
  `NOTES` text DEFAULT NULL,
  `RECORDED_BY` varchar(50) DEFAULT NULL,
  `RECORDER_DATE` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `UID` int(11) NOT NULL,
  `USERNAME` varchar(50) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`UID`, `USERNAME`, `EMAIL`, `PASSWORD`) VALUES
(1, 'teachadmin', 'teach@admin.org', '$2a$12$R2d6x2Hz2C99kqJDj/qsZu0R9DCSEkMaNtJo/j/jhnUDYqNi98FSG');

-- --------------------------------------------------------

--
-- Table structure for table `approval`
--

CREATE TABLE `approval` (
  `APPROVAL_ID` int(10) NOT NULL,
  `STAFF_ID` int(10) NOT NULL,
  `STATUS` int(10) DEFAULT NULL,
  `APPROVAL_DATE` datetime NOT NULL,
  `ADMIN_MANAGER_ID` int(10) NOT NULL,
  `REVIEW` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `DOC_ID` int(10) NOT NULL,
  `STAFF_ID` int(10) NOT NULL,
  `DOC_NAME` varchar(100) NOT NULL,
  `DOC_SIGHTED_DATE` date NOT NULL,
  `DOC_SIGHTED_USER_ID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `other_experience`
--

CREATE TABLE `other_experience` (
  `STAFF_ID` int(10) NOT NULL,
  `EMP_NAME` varchar(50) DEFAULT NULL,
  `POSITION` varchar(50) DEFAULT NULL,
  `WORK_STATUS` varchar(50) DEFAULT NULL,
  `EMPLOYMENT_PERIOD` varchar(50) DEFAULT NULL,
  `DUTIES` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `publications`
--

CREATE TABLE `publications` (
  `PUBLICATION_ID` int(10) NOT NULL,
  `STAFF_ID` int(10) DEFAULT NULL,
  `AUTHOR_NAME` varchar(255) DEFAULT NULL,
  `PUBLICATION_TITLE` varchar(100) DEFAULT NULL,
  `PUBLICATION_YEAR` int(4) DEFAULT NULL,
  `PUBLICATION_TYPE` varchar(100) DEFAULT NULL,
  `PEER_REVIEWED` varchar(3) DEFAULT NULL,
  `CLASSIFICATION` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qualifications`
--

CREATE TABLE `qualifications` (
  `STAFF_ID` int(10) DEFAULT NULL,
  `AQF_Level_ID` int(10) NOT NULL,
  `QUALIFICATION_NAME` varchar(100) DEFAULT NULL,
  `SUBJECT_AREA` varchar(100) DEFAULT NULL,
  `INSTITUTION_NAME` varchar(100) DEFAULT NULL,
  `YEAR_ISSUED` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `STAFF_ID` int(10) NOT NULL,
  `GENDER` varchar(6) DEFAULT NULL,
  `FIRST_NAME` varchar(50) DEFAULT NULL,
  `MIDDLE_NAME` varchar(50) DEFAULT NULL,
  `LAST_NAME` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `ADDRESS` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `PHONE` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `teaching_experience`
--

CREATE TABLE `teaching_experience` (
  `STAFF_ID` int(10) NOT NULL,
  `TEACHING_PERIOD` varchar(50) DEFAULT NULL,
  `COURSE_ID` int(10) DEFAULT NULL,
  `COURSE_TITLE` varchar(50) DEFAULT NULL,
  `ORGANISATION_NAME` varchar(255) DEFAULT NULL,
  `ROLE` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additional_notes`
--
ALTER TABLE `additional_notes`
  ADD PRIMARY KEY (`STAFF_ID`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `USERNAME` (`USERNAME`);

--
-- Indexes for table `approval`
--
ALTER TABLE `approval`
  ADD PRIMARY KEY (`APPROVAL_ID`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`DOC_ID`),
  ADD KEY `FK_DOCUMENTS_STAFF_ID` (`STAFF_ID`);

--
-- Indexes for table `other_experience`
--
ALTER TABLE `other_experience`
  ADD PRIMARY KEY (`STAFF_ID`);

--
-- Indexes for table `publications`
--
ALTER TABLE `publications`
  ADD PRIMARY KEY (`PUBLICATION_ID`);

--
-- Indexes for table `qualifications`
--
ALTER TABLE `qualifications`
  ADD PRIMARY KEY (`AQF_Level_ID`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`STAFF_ID`);

--
-- Indexes for table `teaching_experience`
--
ALTER TABLE `teaching_experience`
  ADD PRIMARY KEY (`STAFF_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additional_notes`
--
ALTER TABLE `additional_notes`
  MODIFY `STAFF_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `approval`
--
ALTER TABLE `approval`
  MODIFY `APPROVAL_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `DOC_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `other_experience`
--
ALTER TABLE `other_experience`
  MODIFY `STAFF_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publications`
--
ALTER TABLE `publications`
  MODIFY `PUBLICATION_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qualifications`
--
ALTER TABLE `qualifications`
  MODIFY `AQF_Level_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `STAFF_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teaching_experience`
--
ALTER TABLE `teaching_experience`
  MODIFY `STAFF_ID` int(10) NOT NULL AUTO_INCREMENT;
COMMIT;