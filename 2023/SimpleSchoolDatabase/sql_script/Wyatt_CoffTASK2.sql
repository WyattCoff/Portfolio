-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`school`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`school` ;

CREATE TABLE IF NOT EXISTS `mydb`.`school` (
  `SchoolName` VARCHAR(100) NOT NULL,
  `Address` VARCHAR(200) NULL,
  `PhoneNumber` VARCHAR(10) NULL,
  `Email` VARCHAR(100) NULL,
  PRIMARY KEY (`SchoolName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`student` ;

CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `StudentID` INT(8) NOT NULL,
  `school_SchoolName` VARCHAR(100) NOT NULL,
  `FirstName` VARCHAR(50) NULL,
  `MiddleInitials` VARCHAR(5) NULL,
  `LastName` VARCHAR(50) NULL,
  `PhoneNumber` VARCHAR(10) NULL,
  `ResidentialAddress` VARCHAR(150) NULL,
  `Email` VARCHAR(100) NULL,
  `Nationality` VARCHAR(50) NULL,
  `DateOfBirth` DATE NULL,
  `DateOfEnrolmentAtSchool` DATE NULL,
  `Gender` VARCHAR(1) NULL,
  PRIMARY KEY (`StudentID`),
  INDEX `school_idx` (`school_SchoolName` ASC) VISIBLE,
  CONSTRAINT `fk_student_school`
    FOREIGN KEY (`school_SchoolName`)
    REFERENCES `mydb`.`school` (`SchoolName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`teacher` ;

CREATE TABLE IF NOT EXISTS `mydb`.`teacher` (
  `TeacherID` INT(8) NOT NULL,
  `school_SchoolName` VARCHAR(100) NOT NULL,
  `FirstName` VARCHAR(50) NULL,
  `MiddleInitials` VARCHAR(8) NULL,
  `LastName` VARCHAR(50) NULL,
  `Email` VARCHAR(50) NULL,
  `PhoneNumber` VARCHAR(10) NULL,
  INDEX `school_idx` (`school_SchoolName` ASC) VISIBLE,
  PRIMARY KEY (`TeacherID`),
  CONSTRAINT `fk_teacher_school`
    FOREIGN KEY (`school_SchoolName`)
    REFERENCES `mydb`.`school` (`SchoolName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`subject` ;

CREATE TABLE IF NOT EXISTS `mydb`.`subject` (
  `SubjectName` VARCHAR(9) NOT NULL,
  `SubjectCoordinator` INT(8) NOT NULL,
  `SubjectDescription` VARCHAR(150) NULL,
  `SubjectCost` DECIMAL(5,2) NULL,
  `DurationInHours` INT NULL,
  `NumberOfAssessmentItems` INT NULL,
  PRIMARY KEY (`SubjectName`),
  INDEX `SubjectCoordinator_idx` (`SubjectCoordinator` ASC) VISIBLE,
  CONSTRAINT `SubjectCoordinator`
    FOREIGN KEY (`SubjectCoordinator`)
    REFERENCES `mydb`.`teacher` (`TeacherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`enrolment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`enrolment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`enrolment` (
  `student_StudentID` INT(8) NOT NULL,
  `subject_SubjectName` VARCHAR(9) NOT NULL,
  `EnrolmentDate` DATE NULL,
  `StudentGrade` VARCHAR(4) NULL,
  `StudentResult` INT NULL,
  `GradeDate` DATE NULL,
  PRIMARY KEY (`student_StudentID`, `subject_SubjectName`),
  INDEX `fk_subject_enrolment_student1_idx` (`student_StudentID` ASC) VISIBLE,
  INDEX `fk_subject_enrolment_subject1_idx` (`subject_SubjectName` ASC) VISIBLE,
  CONSTRAINT `fk_subject_enrolment_student1`
    FOREIGN KEY (`student_StudentID`)
    REFERENCES `mydb`.`student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subject_enrolment_subject1`
    FOREIGN KEY (`subject_SubjectName`)
    REFERENCES `mydb`.`subject` (`SubjectName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Populate the database with data
-- -----------------------------------------------------
-- Insert data into the `school` table
INSERT INTO `mydb`.`school` (`SchoolName`, `Address`, `PhoneNumber`, `Email`) VALUES
('Tafe SA', '2 Woodford Rd, Elizabeth SA 5112', 1234567890, 'info@tafesa.edu.au');

-- Insert your own data as a student
INSERT INTO `mydb`.`student` (`StudentID`, `school_SchoolName`, `FirstName`, `MiddleInitials`, `LastName`, `PhoneNumber`, `ResidentialAddress`, `Email`, `Nationality`, `DateOfBirth`, `DateOfEnrolmentAtSchool`, `Gender`) VALUES
(10000000, 'Tafe SA', 'Wyatt', 'J', 'Coff', '1111111111', '100 Coff Lane', 'wyatt.coff@student.tafesa.edu.au', 'Australian', '2004-12-16', CURDATE(), 'M'),
(10000001, 'Tafe SA', 'Olivia', 'A', 'Smith', '2222222222', '100 Smith Lane', 'Olivia.Smith@student.tafesa.edu.au', 'Australian', '2000-08-12', CURDATE(), 'M'),
(10000002, 'Tafe SA', 'Emma', 'B', 'Thorning', '3333333333', '100 Thorning Lane', 'Emma.Thorning@student.tafesa.edu.au', 'Australian', '2002-10-11', CURDATE(), 'F'),
(10000003, 'Tafe SA', 'Ava', 'C', 'Doutfire', '4444444444', '100 Doutfire Lane', 'Ava.Doutfire@student.tafesa.edu.au', 'Australian', '2004-01-20', CURDATE(), 'F'),
(10000004, 'Tafe SA', 'Liam', 'M', 'Raven', '5555555555', '100 Raven Lane', 'Liam.Raven@student.tafesa.edu.au', 'Australian', '2003-07-22', CURDATE(), 'M');
-- Select all from `student`
SELECT * FROM `mydb`.`student`;

-- Insert data into the `teacher` table
INSERT INTO `mydb`.`teacher` (`TeacherID`, `school_SchoolName`, `FirstName`, `MiddleInitials`, `LastName`, `Email`, `PhoneNumber`) VALUES
(44556677, 'TAFE SA', 'John', 'D', 'Doe', 'JoneDoe@tafesa.edu.au', '3456789012'),
(44556678, 'TAFE SA', 'Mike', 'A', 'Mallet', 'MikeMallet@tafesa.edu.au', '3456789012'),
(44556679, 'TAFE SA', 'Sam', 'J', 'Maw', 'SamMaw@tafesa.edu.au', '3456789012'),
(44556680, 'TAFE SA', 'Frank', 'L', 'Feild', 'FrankFeild@tafesa.edu.au', '3456789012');

-- Insert into `subject` table
INSERT INTO `mydb`.`subject` (`SubjectName`, `SubjectCoordinator`, `SubjectDescription`, `SubjectCost`, `DurationInHours`, `NumberOfAssessmentItems`) VALUES
('WEB451SQL', 44556677, 'Introduction to SQL', 100.00, 40, 4),
('ICT302IWC', 44556677, 'Fundamentals of Python', 100.00, 40, 4),
('IT_PracTL', 44556677, 'Extra Help', 100.00, 40, 4),
('5SDA', 44556677, 'Java Basics', 100.00, 40, 4);
-- Select all from `subject`
SELECT * FROM `mydb`.`subject`;

-- INSERT INTO 'enrolment' table
INSERT INTO `mydb`.`enrolment` (`student_StudentID`, `subject_SubjectName`, `EnrolmentDate`, `StudentGrade`, `StudentResult`, `GradeDate`) VALUES
(10000000, 'WEB451SQL', CURDATE(), 'Cred', 75, '2020-12-10'),
(10000000, 'ICT302IWC', CURDATE(), 'Dist', 90, '2004-12-5'),
(10000000, 'IT_PracTL', CURDATE(), 'Pass', 60, '2004-12-2'),
(10000000, '5SDA', CURDATE(), 'Pass', 60, '2004-12-10'),
(10000001, 'WEB451SQL', CURDATE(), 'Cred', 70, '2020-12-10'),
(10000002, 'ICT302IWC', CURDATE(), 'Pass', 60, '2004-12-5'),
(10000003, 'IT_PracTL', CURDATE(), 'Pass', 55, '2004-12-2'),
(10000004, '5SDA', CURDATE(), 'Dist', 90, '2004-12-10');

-- Query to concatenate first and last name as “Full Name” and display phone number for all students
SELECT CONCAT(`FirstName`, ' ', `LastName`) AS `Full Name`, `PhoneNumber`
FROM `mydb`.`student`
ORDER BY `LastName`, `FirstName`;

-- Query to count all students in the database - expect 5
SELECT COUNT(*) AS `Total Students`
FROM `mydb`.`student`;

-- Query to count students enrolled in each subject - expect 2 in each subject total 10
SELECT e.`subject_SubjectName`, COUNT(e.`student_StudentID`) AS `Total Enrolments`
FROM `mydb`.`enrolment` e
GROUP BY e.`subject_SubjectName`;

-- Query to show the highest result for all students in a subject - expect WEB451SQL 75, IT_PracTL 60, ICT302IWC 90 and 5SDA 90
SELECT e.`subject_SubjectName`, MAX(e.`StudentResult`) AS `Highest Result`
FROM `mydb`.`enrolment` e
GROUP BY e.`subject_SubjectName`;

-- Query to show the lowest result for all students in a subject - expect 5SDA 60, ICT302IWC 60, IT_PracTL 55, WEB451SQL 70
SELECT e.`subject_SubjectName`, MIN(e.`StudentResult`) AS `Lowest Result`
FROM `mydb`.`enrolment` e
GROUP BY e.`subject_SubjectName`;

/* Query to show all results of a specific student
Replace '10000000' with the StudentID of the student you want to query */
SELECT 
  s.`FirstName`, 
  s.`LastName`, 
  sub.`SubjectName`, 
  sub.`SubjectDescription`, 
  e.`StudentResult`, 
  e.`StudentGrade`
FROM 
  `student` s
JOIN 
  `enrolment` e ON s.`StudentID` = e.`student_StudentID`
JOIN 
  `subject` sub ON e.`subject_SubjectName` = sub.`SubjectName`
WHERE 
  s.`StudentID` = 10000000; -- Wyatt Coff's records
  
/* Query to show the results of all students in a subject
Replace '5SDA' with the SubjectName of the subject you want to query */
SELECT 
  sub.`SubjectName`, 
  s.`FirstName`, 
  s.`LastName`, 
  e.`StudentResult`, 
  e.`StudentGrade`
FROM 
  `subject` sub
JOIN 
  `enrolment` e ON sub.`SubjectName` = e.`subject_SubjectName`
JOIN 
  `student` s ON e.`student_StudentID` = s.`StudentID`
WHERE 
  sub.`SubjectName` = '5SDA'; -- Replace with the subject code

-- Alter student table to add 'LanguageSpokenAtHome' column
ALTER TABLE `mydb`.`student`
ADD COLUMN `LanguageSpokenAtHome` VARCHAR(50) NULL AFTER `Gender`;

-- Update this new column with data
UPDATE `mydb`.`student`
SET `LanguageSpokenAtHome` = CASE `StudentID`
  WHEN 10000000 THEN 'English'
  WHEN 10000001 THEN 'English'
  WHEN 10000002 THEN 'English'
  WHEN 10000003 THEN 'English'
  WHEN 10000004 THEN 'English'
END;

-- Select all to show the updated student table
SELECT * FROM `mydb`.`student`;

/* Original Subject Coordinator for WEB451SQL is John Doe, TeacherID 44556677
New Subject Coordinator for WEB451SQL will be Mike Mallet, TeacherID 44556678 

Update subject coordinator*/
UPDATE `mydb`.`subject`
SET `SubjectCoordinator` = 44556678
WHERE `SubjectName` = 'WEB451SQL';

-- Query to show all subjects before and after the update
SELECT * FROM `mydb`.`subject`;

-- Identify a teacher not coordinating any subjects
SELECT * FROM `mydb`.`teacher` AS t
WHERE NOT EXISTS (
  SELECT 1 FROM `mydb`.`subject` AS s
  WHERE s.`SubjectCoordinator` = t.`TeacherID`
);

-- Deleting Frank Feild, TeacherID 44556680
DELETE FROM `mydb`.`teacher`
WHERE `TeacherID` = 44556680;

-- Query to show all teachers before and after the deletion
SELECT * FROM `mydb`.`teacher`;