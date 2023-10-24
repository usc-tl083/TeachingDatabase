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

--
-- Dumping data for table `additional_notes`
--

INSERT INTO `additional_notes` (`STAFF_ID`, `NOTES`, `RECORDED_BY`, `RECORDER_DATE`) VALUES
(1, 'I have been studying Computer Science for all my life and have achieved 2 different awards until now.', 'JhonDoe', '2023-10-03 03:24:32'),
(2, 'I have been studying computer science.', 'Ciara Fransis', '2023-10-03 03:52:45'),
(3, 'sdfsdfdfdfdfdfddd', 'JohnDoe', '2023-10-04 08:34:54'),
(4, 'Additional notes go here', 'JohnSmith', '2023-10-19 12:37:10'),
(5, 'Please provide us with any other relevant information you believe is relevant.', 'EmilyJohnson', '2023-10-19 13:29:22'),
(7, 'Please provide us with any other relevant information you believe is relevant.', 'JohnDoe', '2023-10-24 02:43:40');

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
  `STATUS` varchar(255) DEFAULT NULL,
  `APPROVAL_DATE` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ADMIN_MANAGER` varchar(255) NOT NULL,
  `REVIEW` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `approval`
--

INSERT INTO `approval` (`APPROVAL_ID`, `STAFF_ID`, `STATUS`, `APPROVAL_DATE`, `ADMIN_MANAGER`, `REVIEW`) VALUES
(1, 2, 'Approve', '2023-10-19 05:42:04', 'teachadmin', NULL),
(2, 3, 'Approve', '2023-10-19 06:20:07', 'teachadmin', NULL),
(3, 1, 'Disapprove', '2023-10-19 13:10:51', 'teachadmin', NULL),
(4, 4, 'Approve', '2023-10-19 13:11:59', 'teachadmin', NULL),
(5, 5, 'Disapprove', '2023-10-19 13:30:19', 'teachadmin', NULL);

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

--
-- Dumping data for table `other_experience`
--

INSERT INTO `other_experience` (`STAFF_ID`, `EMP_NAME`, `POSITION`, `WORK_STATUS`, `EMPLOYMENT_PERIOD`, `DUTIES`) VALUES
(1, 'University of Moreton Bay', 'Teacher', 'full-time', '1 year', 'Teaching'),
(2, 'University of Moreton Bay', 'Teacher', 'full-time', '5 years', 'Teaching'),
(3, 'University of Moreton Bay', 'Teacher', 'full-time', '5 years', 'Duties'),
(4, 'XYZ Inc.', 'Software Engineer', 'full-time', '2016 - 2019', 'Teaching and Research'),
(5, 'University of California', 'Business Analyst', 'full-time', '3 years ', 'University of California'),
(7, '', '', 'full-time', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `publications`
--

CREATE TABLE `publications` (
  `PUBLICATION_ID` int(10) NOT NULL,
  `STAFF_ID` int(10) DEFAULT NULL,
  `AUTHOR_NAME` varchar(255) DEFAULT NULL,
  `PUBLICATION_TITLE` varchar(100) DEFAULT NULL,
  `PUBLICATION_YEAR` varchar(10) DEFAULT NULL,
  `PUBLICATION_TYPE` varchar(100) DEFAULT NULL,
  `PEER_REVIEWED` varchar(3) DEFAULT NULL,
  `CLASSIFICATION` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `publications`
--

INSERT INTO `publications` (`PUBLICATION_ID`, `STAFF_ID`, `AUTHOR_NAME`, `PUBLICATION_TITLE`, `PUBLICATION_YEAR`, `PUBLICATION_TYPE`, `PEER_REVIEWED`, `CLASSIFICATION`) VALUES
(1, NULL, 'Joe Doe', 'How to master Computer', '2020', 'Book', 'yes', 'research-class'),
(2, NULL, 'Ciara Fransis', 'How to master Computer', '2019', 'Book', 'yes', 'research-class'),
(3, NULL, 'Author', 'How to master Computer', '2023', 'Book', 'yes', 'research-class'),
(4, NULL, 'John Smith', 'Advanced Programming', '2021', 'Book', 'yes', 'scholar-class'),
(5, NULL, 'Emily Johnson', 'Strategies for Business Success', '2022', 'Research Paper', 'yes', 'research-class'),
(7, NULL, '', '', '', '', NULL, NULL);

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

--
-- Dumping data for table `qualifications`
--

INSERT INTO `qualifications` (`STAFF_ID`, `AQF_Level_ID`, `QUALIFICATION_NAME`, `SUBJECT_AREA`, `INSTITUTION_NAME`, `YEAR_ISSUED`) VALUES
(NULL, 1, 'Masters Degree', 'Computer Science', 'University of Sunshine Coast', 2023),
(NULL, 2, 'Masters Degree', 'Computer Science', 'University of Sunshine Coast', 2020),
(NULL, 3, 'Masters Degree', 'Computer Science', 'University of Sunshine Coast', 2023),
(NULL, 4, 'Bachelor of Science', 'Computer Science', 'University of XYZ', 2015),
(NULL, 5, 'Masters Degree', 'Business Management', 'University of ABC', 2018),
(NULL, 7, 'Masters Degree', 'Computer Science', 'Institution Name', 2015);

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

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`STAFF_ID`, `GENDER`, `FIRST_NAME`, `MIDDLE_NAME`, `LAST_NAME`, `dob`, `ADDRESS`, `EMAIL`, `PHONE`) VALUES
(1, 'male', 'Jhon', 'Middle', 'Doe', '2000-12-12', 'Brisbane', 'jhon@doe.email', '0451231234'),
(2, 'female', 'Ciara ', '', 'Fransis', '1998-10-10', '22 westacott street, Nundah', 'ciara@gmail.com', '045211786'),
(3, 'male', 'John', 'Middle', 'Doe', '1995-10-10', 'Brisbane', 'jhon@doe.email', '0451231234'),
(4, 'male', 'John', 'Michael', 'Smith', '1990-05-12', '123 Main St, City, State', 'john.smith@example.com', '123-456-7890'),
(5, 'female', 'Emily', 'Grace', 'Johnson', '1992-02-25', '456 Elm street, Town, State', 'emilygrace@gmail.com', '0452365441'),
(7, 'other', 'John', 'Middle', 'Doe', '2023-10-10', 'Brisbane', 'jhon@doe.email', '0451231234');

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
-- Dumping data for table `teaching_experience`
--

INSERT INTO `teaching_experience` (`STAFF_ID`, `TEACHING_PERIOD`, `COURSE_ID`, `COURSE_TITLE`, `ORGANISATION_NAME`, `ROLE`) VALUES
(1, '2 years', NULL, 'Computer Science', 'University of Sunshine Coast', 'Course Coordinator'),
(2, '2 years', NULL, 'Computer Science', 'University of Sunshine Coast', 'Course Coordinator'),
(3, '2 years', NULL, 'Computer Science', 'University of Sunshine Coast', 'Course Coordinator'),
(4, 'Fall 2018 - Spring 2019', NULL, 'Computer Science', 'ABC High School', 'Teacher'),
(5, '15 years', NULL, 'Business Administration', 'University of California', 'Instructor'),
(7, 'Fall 2018 - Spring 2019', NULL, 'Field of Study', 'Organization Name', 'Course Coordinator');

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
  MODIFY `STAFF_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `approval`
--
ALTER TABLE `approval`
  MODIFY `APPROVAL_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `DOC_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `other_experience`
--
ALTER TABLE `other_experience`
  MODIFY `STAFF_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `publications`
--
ALTER TABLE `publications`
  MODIFY `PUBLICATION_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `qualifications`
--
ALTER TABLE `qualifications`
  MODIFY `AQF_Level_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `STAFF_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `teaching_experience`
--
ALTER TABLE `teaching_experience`
  MODIFY `STAFF_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;