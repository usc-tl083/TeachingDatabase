SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

### TEMPORARILY DISABLES REFERENTIAL CONSTRAINTS ###
### ALLOWS FOR THE RECREATION OF TABLES AND INPUT OF DATA IN ANY ORDER ###
SET FOREIGN_KEY_CHECKS = 0;

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
-- Table structure for table `approval`
--

CREATE TABLE `approval` (
  `APPROVAL_ID` int(10) NOT NULL,
  `STAFF_ID` int(10) NOT NULL,
  `NEXT_REVIEW_DATE` date DEFAULT NULL,
  `APPROVAL_DATE` date NOT NULL,
  `TEACHING_LOCATION` varchar(50) NOT NULL,
  `AQF_LEVEL_ID` int(10) NOT NULL,
  `AADMIN_MANAGER_ID` int(10) NOT NULL,
  `COURSE_ID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `aqf_levels`
--

CREATE TABLE `aqf_levels` (
  `AQF_LEVEL_ID` int(10) NOT NULL,
  `QUALIFICATION_DEGREE` varchar(100) NOT NULL,
  `AQF_LEVEL` varchar(20) NOT NULL,
  `QUALIFICATION_REQUIREMENT` varchar(20) NOT NULL
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
  `QUALIFICATION_NAME` varchar(100) NOT NULL,
  `SUBJECT_AREA` varchar(100) NOT NULL,
  `INSTITUTION_NAME` varchar(100) NOT NULL,
  `YEAR_ISSUED` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `REVIEW_ID` int(10) NOT NULL,
  `APPROVAL_ID` int(10) NOT NULL,
  `REVIEW_DATE` date NOT NULL,
  `ADMING_MANAGER_ID` int(10) NOT NULL,
  `OUTCOME` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `STAFF_ID` int(10) NOT NULL,
  `GENDER` varchar(6) NOT NULL,
  `FIRST_NAME` varchar(50) NOT NULL,
  `MIDDLE_NAME` varchar(50) DEFAULT NULL,
  `LAST_NAME` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `ADDRESS` varchar(50) NOT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `PHONE` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `teaching_experience`
--

CREATE TABLE `teaching_experience` (
  `STAFF_ID` int(10) NOT NULL,
  `TEACHING_PERIOD` varchar(50) NOT NULL,
  `COURSE_ID` int(10) DEFAULT NULL,
  `COURSE_TITLE` varchar(50) NOT NULL,
  `ORGANISATION_NAME` varchar(255) NOT NULL,
  `ROLE` varchar(255) NOT NULL
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
-- Indexes for table `approval`
--
ALTER TABLE `approval`
  ADD PRIMARY KEY (`APPROVAL_ID`),
  ADD KEY `FK_APPROVAL_AQF_LEVEL_ID` (`AQF_LEVEL_ID`);

--
-- Indexes for table `aqf_levels`
--
ALTER TABLE `aqf_levels`
  ADD KEY `FK_AQF_LEVEL_ID` (`AQF_LEVEL_ID`);

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
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`REVIEW_ID`),
  ADD KEY `FK_REVIEW_APPROVAL_ID` (`APPROVAL_ID`);

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
-- AUTO_INCREMENT for table `approval`
--
ALTER TABLE `approval`
  MODIFY `APPROVAL_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `aqf_levels`
--
ALTER TABLE `aqf_levels`
  MODIFY `AQF_LEVEL_ID` int(10) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `REVIEW_ID` int(10) NOT NULL AUTO_INCREMENT;

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

--
-- Constraints for dumped tables
--

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `FK_REVIEW_APPROVAL_ID` FOREIGN KEY (`APPROVAL_ID`) REFERENCES `approval` (`APPROVAL_ID`);
COMMIT;