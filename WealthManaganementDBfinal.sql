DROP DATABASE IF EXISTS WealthManagementDB;

CREATE DATABASE IF NOT EXISTS WealthManagementDB;

USE WealthManagementDB;

DROP TABLE IF EXISTS `user_account_type_t`;
CREATE TABLE IF NOT EXISTS `user_account_type_t` (
    `UserAccountTypeID` INT NOT NULL AUTO_INCREMENT,
    `UserAccountTypeName` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `UserAccountTypeDescription` VARCHAR(400)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    PRIMARY KEY (`UserAccountTypeID`)
);


-- INSERTING RECORDS FOR USER_ACCOUNT_TYPE TABLE;
INSERT INTO user_account_type_t (UserAccountTypeName, UserAccountTypeDescription) 
VALUES ('Primary' , 'Account held by Person  who is primarily accountable'),
( 'Self', 'Account held by individual person'),
('Joint' , 'Account held by two persons in joint'),
('Family', 'Account held by a family');


DROP TABLE IF EXISTS `employment_category_t`;
CREATE TABLE IF NOT EXISTS `employment_category_t` (
    `EmpCategoryID` INT NOT NULL AUTO_INCREMENT,
    `EmpCategoryName` VARCHAR(30)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `EmpCategoryDescription` VARCHAR(400)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    PRIMARY KEY (`EmpCategoryID`)
);

INSERT INTO  employment_category_t (EmpCategoryName, EmpCategoryDescription) VALUES
('Salaried', 'Employee regularly receives a predetermined amount of compensation each pay period '),
('Business' , 'Income received from the sale of products or services'),
('Agriculture', 'Earnings through produces from  farming land'),
('Vendor', 'Earning through contracts');


DROP TABLE IF EXISTS `users_t`;
CREATE TABLE IF NOT EXISTS `users_t` (
    `UserID` INT NOT NULL AUTO_INCREMENT,
    `FirstName` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `LastName` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `Gender` VARCHAR(20)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `DateOfBirth` DATE DEFAULT NULL,
    `SSN` INT DEFAULT NULL,
    `UserAccountTypeID` INT DEFAULT '0',
    `StreetAddress` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `City` VARCHAR(30)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `State` VARCHAR(2)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `ZipCode` INT DEFAULT NULL,
    `AreaCode` INT DEFAULT NULL,
    `PhoneNumber` INT DEFAULT NULL,
    PRIMARY KEY (`UserID`),
    KEY `UserAccountTypeID` (`UserAccountTypeID`),
    CONSTRAINT `users_FK00` FOREIGN KEY (`UserAccountTypeID`)
        REFERENCES `user_account_type_t` (`UserAccountTypeID`),
    CONSTRAINT `CheckRegNumber` CHECK (SSN > 99999999 AND SSN < 999999999)
);


-- INSERTING RECORDS FOR USERS_T;
INSERT INTO users_t (FirstName,LastName,Gender,DateOfBirth,SSN,UserAccountTypeID,StreetAddress,City,State,ZipCode,AreaCode,PhoneNumber)
VALUES
('Suzanne','Viescas','Male','1990-06-21',100999998,1,'9408 Furth Circle','Redmond','WA',98052,425,112233),
('William','Thompson','Female','1987-12-23',100999999,2,'897 Long Airport Avenue','Duvall','WA',98019,425,223344),
('Gary','Hallmark','Male','1985-10-05',100999997,2,'8616 Spinnaker Dr.','Auburn','WA',98002,253,225585),
('Robert','Brown','Female','1982-12-12',101000000,3,'8489 Strong St.','Houston','TX',77201,713,252522),
('Dean','McCrae','Male','1968-01-01',101000001,2,'8 Johnstown Road','Redmond','WA',98052,425,445588),
('John','Viescas','Female','1967-10-15',101000002,2,'78934 Hillside Dr.','Redmond','WA',98052,425,969696),
('Mariya','Sergienko','Male','1964-11-02',101000003,2,'7825 Douglas Av.','Portland','OR',97208,503,141885),
('Neil','Patterson','Female','1958-03-18',101000004,2,'782 First Street','San Diego','CA',92199,619,232363),
('Andrew','Cencini','Male','1990-06-01',101000005,1,'7734 Strong St.','Seattle','WA',98105,206,363636),
('Angel','Kennedy','Female','1995-12-23',101000006,2,'7635 Spinnaker Dr.','Austin','TX',78710,512,969696),
('Alaina','Hallmark','Male','1985-10-05',101000007,2,'7586 Pompton St.','Woodinville','WA',98072,425,788778),
('Liz','Keyser','Male','1972-12-12',101000008,3,'7476 Moss Rd.','Bellevue','WA',98006,425,854854),
('Rachel','Patterson','Male','1968-01-01',101000009,1,'7 Allen Street','San Diego','CA',92199,619,125858),
('Sam','Abolrous','Female','1967-10-15',101000010,1,'5905 Pompton St.','Palm Springs','CA',92263,760,753159),
('Darren','Gehring','Male','1968-01-01',101000011,1,'59 rue de l Abbaye','Chico','CA',95926,530,842645),
('Jim','Wilson','Female','1967-12-15',101000012,1,'5677 Strong St.','Salem','OR',97301,503,268425),
('Manuela','Seidel','Female','1967-12-16',101000013,1,'567 North Pendale Street','Medford','OR',97501,541,258896),
('David','Smith','Male','1970-12-17',101000014,1,'5557 North Pendale Street','Fremont','CA',94538,510,999999),
('Zachary','Ehrlich','Female','1970-12-18',101000015,1,'35 King George','Glendale','CA',91209,818,888555),
('Joyce','Bonnicksen','Female','1970-12-19',101000016,1,'31 Duncan St. West End','Bellevue','WA',98006,425,333666),
('Estella','Pundt','Male','1970-1-20',101000017,2,'3086 Ingle Ln.','Dallas','TX',75260,972,999666),
('Caleb','Viescas','Male','1985-09-21',101000018,2,'3 Hagalim Blv.','Long Beach','CA',90809,562,444888),
('Julia','Schnebly','Female','1985-09-22',101000019,3,'2793 Furth Circle','Seattle','WA',99837,206,999666),
('Mark','Rosales','Female','1985-09-23',101000020,3,'27 rue du Colonel Pierre Avia','El Paso','TX',79915,915,888578),
('Maria','Patterson','Female','1985-09-24',101000021,2,'2678 Kingston Rd.','El Paso','TX',79915,915,444555);


DROP TABLE IF EXISTS `user_bank_account_t`;
CREATE TABLE IF NOT EXISTS `user_bank_account_t` (
    `AccountID` INT NOT NULL AUTO_INCREMENT,
    `UserID` INT DEFAULT '0',
    `BankName` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `AccountType` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `AccountNo` VARCHAR(50),
    `RoutingNo` VARCHAR(50),
    `AvailableBalance` DECIMAL(20, 2) DEFAULT '0', 
    PRIMARY KEY (`AccountID`),
    KEY `UserID` (`UserID`),
    CONSTRAINT `user_bank_account_FK00` FOREIGN KEY (`UserID`)
        REFERENCES `users_t` (`UserID`)
);

INSERT INTO user_bank_account_t(UserID , BankName , AccountType , AccountNo , RoutingNo , AvailableBalance) VALUES
('17' , "Bank of America" ,  "Primary" , '0276914473' , '981503110' , 58178.45),
('7' , "Chase" , "Joint" , '4838432910' , '644335690' , 6750.60),
('2', "Wells Fargo", "Primary" , '5646422095' , '784681200' , 187538.08),
('25', "Chase" , "Self" , '5017529218' , '468226497' , 22835.13),
('1' , "Capital One" , "Self" , '9364933658' , '785910132' , 1663.50),
('13' , "Wells Fargo" , "Primary" , '1349118404' , '728969765' , 33556.21),
('5' , "Capital One" , "Self" , '4557370946' , '490823120' , 542790.99),
('10', "Bank of America" , "Joint" , '2480707766' , '281710596' , 4672.44),
('21' , "Chase" , "Joint" , '59874942761' , '866381611' , 393109.67),
('22' , "Capital One" , "Joint" , '9334101508' , '336132707' , 46516.87),
('8' , "Citizen" , "Primary", '7596374468' , '464045610' , 2805.66),
('3' , "Wells Fargo" , "Self" , '489680294921' , '982877914' , 868.50),
('19' , "Chase" , "Primary" , '5236797958' , '808839951' , 173384.01),
('4' , "Bank of America" , "Joint"  , '5238966827' , '991367527' , 77760.43),
('15' , "Bank of America" , "Self" , '2036413904' , '536440599' , 9398.57),
('24' , "Citibank" , "Primary" , '2669071991' , '549500183' , 56461.00),
('11' , "Citibank" , "Self" , '1801601186' , '252035155' , 317811.49),
('6' , "Chase" , "Primary" , '4567098311' , '862478384' , 82539),
('12' , "Wells Fargo" , "Self" , '4855170407' , '362011758' , 3377.22),
('3' , "Wells Fargo" , "Self" , '6802949215' , '102883914' , 54200.65),
('20' , "Citizen" , "Joint" , 1704058582 , 829782928 , 336807.8),
('14' , "Citibank" , "Primary" , 4723794753 , 720516938 , 7643.66),
('23' , "Capital One" , "Joint" , '3066309463' , '468822627' , 615774.51),
('16' , "Citizen" , "Self" , '2455742154' , '805176178' , 85660.11),
('18', "Bank of America", "Primary", '2036413903', '536440590', 53483.33);


DROP TABLE IF EXISTS `expense_category_t`;
CREATE TABLE IF NOT EXISTS `expense_category_t` (
`ExpenseCategoryID` INT NOT NULL AUTO_INCREMENT,
`ExpenseCategoryType` VARCHAR(30)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
PRIMARY KEY (`ExpenseCategoryID`)
);


INSERT INTO `expense_category_t` (`ExpenseCategoryType`)
VALUES
('ATM/Cash'),
('Entertainment'),
('Electricity'),
('Food'),
('Furniture'),
('Gas'),
('Grocery'),
('Insurance'),
('Medical'),
('Others'),
('Shopping'),
('Travel'),
('Utilities'),
('Water');


DROP TABLE IF EXISTS `expenses_t`;
CREATE TABLE IF NOT EXISTS `expenses_t` (
    `TransactionID` INT NOT NULL AUTO_INCREMENT,
    `UserID` INT DEFAULT '0',
    `TransactionTime` DATETIME DEFAULT NULL,
    `ExpenseCategoryID` INT DEFAULT '0',
    `TransactionLat` DECIMAL(20, 7) DEFAULT NULL,
    `TransactionLon` DECIMAL(20, 7) DEFAULT NULL,
    `Amount` DECIMAL(20, 2) DEFAULT NULL,
    PRIMARY KEY (`TransactionID`),
    KEY `UserID` (`UserID`),
    CONSTRAINT `expenses_FK00` FOREIGN KEY (`UserID`)
        REFERENCES `users_t` (`UserID`),
	CONSTRAINT `expenses_FK01` FOREIGN KEY (`ExpenseCategoryID`)
        REFERENCES `expense_category_t` (`ExpenseCategoryID`)
);

-- INSERTING RECORDS FOR expenses_t;
INSERT INTO expenses_t (UserID,TransactionTime,ExpenseCategoryID,TransactionLat,TransactionLon, Amount)
VALUES
('1','2021-01-03 9:47:56',7,47.606209,-122.332069, 20.12),
('2','2021-11-11 3:17:16',11,32.776665,-96.796989, 122.31),
('3','2022-10-12 19:47:56',2,32.948334,-96.729851, 23.45),
('4','2020-12-19 12:22:10',5,34.052235,-118.243683, 237.99),
('5','2021-09-05 9:10:11',13,37.3361663,-121.890591, 133.56),
('6','2021-08-06 20:20:12',3,40.741895,-73.989308, 26.12),
('7','2022-10-10 1:30:13',1,47.6038321,-122.330062, 14.78),
('8','2019-10-11 5:38:14',8,34.5003,-111.50098, 167.12),
('9','2022-08-09 7:23:56',2,30.2711286,-97.7436995, 1002.10),
('10','2022-11-11 3:27:59',5,41.8755616,-87.6244212, 11.13),
('11','2021-10-10 1:12:52',7,38.91706,-77.00025, 123.12),
('12','2020-10-01 5:45:11',4,34.4221319,-119.702667, 12.05),
('13','2019-05-05 13:12:23',12,39.4225192,-111.714358, 98.88),
('14','2022-03-23 14:37:05',3,39.987551,-84.4874508, 78.12),
('15','2020-11-18 15:11:13',8,37.1232245,-78.4927721, 67.24),
('16','2019-04-07 16:10:12',5,40.2253569,-82.6881395, 45.12),
('17','2022-07-03 19:00:34',6,41.0534302,-73.5387341, 34.23),
('18','2022-12-27 21:45:56',14,42.3554334,-71.060511, 35.23),
('19','2019-10-12 20:42:12',1,39.5162401,-76.9382069, 35.12),
('20','2022-07-12 19:27:02',2,32.7762719,-96.7968559, 56.29),
('21','2020-04-11 23:34:05',8,32.8295183,-96.9442177, 124.99),
('22','2020-10-02 21:47:06',9,33.6856969,-117.8259819, 786.12),
('23','2022-01-03 00:56:12',4,32.7355816,-97.1071186, 78.26),
('24','2022-06-06 7:24:12',11,33.1838787,-97.1413417, 67.78),
('25','2022-05-07 4:23:12',4,37.3688301,-122.036349, 66.19),
('19','2019-11-12 23:22:02',2,39.5162401,-76.9382069, 65.99),
('5','2022-07-10 11:27:29',5,32.7762719,-96.7968559, 102.11),
('1','2020-12-23 12:24:12',1,32.8295183,-96.9442177, 123.11),
('12','2020-01-22 10:17:26',4,33.6856969,-117.8259819, 125.89),
('23','2022-06-10 10:06:12',9,32.7355816,-97.1071186, 599.99);


DROP TABLE IF EXISTS `income_t`;
CREATE TABLE IF NOT EXISTS `income_t` (
	`IncomeID` INT NOT NULL AUTO_INCREMENT,
    `AccountID` INT NOT NULL,
    `IncomeDate` DATE DEFAULT NULL,
    `IncomeSource` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `Salary` DECIMAL(15 , 2 ) DEFAULT NULL,
    `EmpCategoryID` INT DEFAULT '0',
    `BonusIncluded` BOOLEAN DEFAULT NULL,
    PRIMARY KEY (`IncomeID`),
    CONSTRAINT `income_FK00` FOREIGN KEY (`AccountID`)
        REFERENCES `user_bank_account_t` (`AccountID`),
    CONSTRAINT `income_FK01` FOREIGN KEY (`EmpCategoryID`)
        REFERENCES `employment_category_t` (`EmpCategoryID`)
);


-- INSERTING RECORDS FOR income_t
INSERT INTO income_t (AccountID, IncomeDate, IncomeSource, Salary, EmpCategoryID, BonusIncluded)
VALUES
('1', "2022-01-20", "Business", '85000', '1',TRUE),
('2', "2022-01-31", "Salaried", '90000', '2', FALSE),
('3', "2022-01-28", "Vendor", '93000', '3',TRUE),
('4', "2022-01-15", "Agriculture", '150000','4', FALSE),
('5', "2022-01-18", "Business", '160000','4',TRUE),
('6', "2022-01-30", "Salaried", '120000','3', FALSE),
('7', "2022-02-02", "Vendor", '75000', '2', TRUE),
('8', "2022-01-03", "Agriculture", '83000', '1', FALSE),
('9', "2022-01-23", "Business", '120000', '2', TRUE),
('10', "2022-01-29", "Agriculture", '200000', '3', FALSE),
('11', "2022-01-23", "Business", '50000', '4',FALSE),
('12', "2022-01-21", "Agriculture", '95000', '1',TRUE),
('13', "2022-01-29", "Salaried", '100000', '1',TRUE),
('14', "2022-01-30", "Salaried", '120000', '2',FALSE),
('15', "2022-01-23", "Vendor", '75000', '3',TRUE),
('16', "2022-01-30", "Salaried", '200000','4',TRUE),
('17', "2022-01-30", "Salaried", '175000','2',FALSE),
('18', "2022-01-13", "Agriculture", '400000','4',FALSE),
('19', "2022-01-15", "Business", '300000','3',TRUE),
('20', "2022-01-13", "Vendor", '200000','2',TRUE),
('21', "2022-01-30", "Salaried", '75000', '1',FALSE),
('22', "2022-02-03", "Business", '90000', '2',TRUE),
('23', "2022-01-26", "Vendor", '100000','3',FALSE),
('24', "2022-01-11", "Agriculture", '120000','4', FALSE),
('25', "2022-01-17", "Business", '150000', '3', TRUE);


DROP TABLE IF EXISTS `family_member_t`;
CREATE TABLE IF NOT EXISTS `family_member_t` (
    `MemberID` INT NOT NULL,
    `UserID` INT DEFAULT NULL,
    `FirstName` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `LastName` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `Gender` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `DateOfBirth` DATETIME DEFAULT NULL,
    `Income` INT DEFAULT '0',
    `Relationship` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `MemberType` VARCHAR(50),
    PRIMARY KEY (`MemberID`),
    KEY (UserID),
    CONSTRAINT `family_member_FK00` FOREIGN KEY (`UserID`)
        REFERENCES `users_t` (`UserID`)
);


INSERT INTO family_member_t (MemberID , UserID , FirstName , LastName , Gender , DateOfBirth ,Income , Relationship , MemberType)
VALUES ('01' , '2' , 'William','Thompson','Female','1987-12-23' , '75000' , 'wife' , 'dependent') , 
('02' , '9' , 'Andrew','Cencini','Male','1990-06-01', 230000 , 'son' , 'independent'),
('03' , '23','Julia','Schnebly','Female','1985-09-22' , 125000 , 'self' , 'independent'),
('04' , '6','John','Viescas','Female','1967-10-15',58000 , 'aunt' , 'dependent'),
('05' , '1' , 'Suzanne','Viescas','Male','1990-06-21',85000 , 'brother-in-law' , 'independent'),	
('06' , '3' , 'Gary','Hallmark','Male','1985-10-05',68000 , 'brother' , 'dependent'),
('07' , '14' ,'Sam','Abolrous','Female','1967-10-15',170000 , 'aunt' , 'independent'),
('08' , '7' , 'Mariya','Sergienko','Male','1964-11-02',114780 , 'uncle' , 'independent'),
('09' , '4','Robert','Brown','Female','1982-12-12',92000 , 'brother' , 'independent'),
('10' , '5', 'Dean','McCrae','Male','1968-01-01',45000 , 'father' , 'dependent' ),	
('11', '8', 'Neil','Patterson','Female','1958-03-18',92000 , 'aunt' , 'dependent'),
('12' , '19', 'Zachary','Ehrlich','Female','1970-12-18',88000 , 'sister' , 'independent'),	
('13' , '10', 'Angel','Kennedy','Female','1995-12-23',88000 , 'daughter' , 'dependent'),
('14' , '11', 'Alaina','Hallmark','Male','1985-10-05',65000 , 'brother' , 'dependent'),
('15' , '16', 'Jim','Wilson','Female','1967-12-15',136000 , 'mother' , 'independent'),	
('16', '12', 'Liz','Keyser','Male','1972-12-12',120000, 'brother-in-law', 'independent'),		
('17', '18'	,'David','Smith','Male','1970-12-17',76000, 'nephew', 'dependent'),
('18' , '22', 'Caleb','Viescas','Male','1985-09-21',150000, 'brother' , 'independent'),	
('19' , '13', 'Rachel','Patterson','Male','1968-01-01',150000 , 'uncle', 'independent'),
('20', '25', 'Maria','Patterson','Female','1985-09-24',125000 , 'sister' , 'independent'),
('21' , '15', 'Darren','Gehring','Male','1968-01-01',130000 , 'aunt' , 'independent'),
('22' , '24', 'Mark','Rosales','Female','1985-09-23',88000 , 'sister-in-law' , 'dependent'),
('23' , '21', 'Estella','Pundt','Male','1970-1-20',138000 , 'uncle' , 'independent'),
('24' , '17', 'Manuela','Seidel','Female','1967-12-16',110000 , 'niece' , 'dependent'),
('25' , '20', 'Joyce','Bonnicksen','Female','1970-12-19',98000 , 'aunt' , 'dependent');



DROP TABLE IF EXISTS `liabilities_categories_t`;
CREATE TABLE IF NOT EXISTS `liabilities_categories_t` (
    `LiabilityCategoryID` INT NOT NULL AUTO_INCREMENT,
    `LiabilityCategoryName` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `LiabilityCategoryDesc` VARCHAR(200)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    PRIMARY KEY (`LiabilityCategoryID`)
);

-- INSERTING RECORDS FOR liabilities_categories_t;
INSERT INTO liabilities_categories_t (LiabilityCategoryID,LiabilityCategoryName,LiabilityCategoryDesc)
VALUES
( '001' , 'Credit Card' , 'Credit card for Personal Use' ) ,
( '002' , 'Personal Loan' , 'Personal Loan- Non Collateral' ) ,
( '003' , 'Home Loan' , 'Loan on existing home' ) ,
( '004' , 'Education Loan' , 'Loan for Educational purpose' ) ,
( '005' , 'Loan Against Property' , 'Loan against Land or any other property' ) ,
( '006' , 'Gold Loan' , 'Loan on gold as a collateral' ) ,
( '007' , 'Business Loan' , 'Loan for Business' ) ,
( '008' , 'Overdraft/Ready Credit' , 'Extra credit line given on savings account' ) ,
( '009' , 'Loan Against Fixed Deposit' , 'Loan against any deposits' ) ;


DROP TABLE IF EXISTS `liabilities_t`;
CREATE TABLE IF NOT EXISTS `liabilities_t` (
    `LoanID` INT NOT NULL,
    `UserID` INT DEFAULT NULL,
    `LiabilityCategoryID` INT DEFAULT NULL,
    `SanctionedAmount` INT DEFAULT '0',
    `InterestRate` FLOAT DEFAULT '0',
    `LoanTenure` INT DEFAULT '0',
    `DateofLoanSanction` DATE DEFAULT NULL,
    `OutstandingAmount` INT DEFAULT '0',
    `EMI` INT DEFAULT '0',
    PRIMARY KEY (`LoanID`),
    KEY (`UserID`),
    KEY (`LiabilityCategoryID`),
    CONSTRAINT `liabilities_FK00` FOREIGN KEY (`UserID`)
        REFERENCES `users_t` (`UserID`),
    CONSTRAINT `liabilities_FK01` FOREIGN KEY (`LiabilityCategoryID`)
        REFERENCES `liabilities_categories_t` (`LiabilityCategoryID`)
);


-- INSERTING RECORDS FOR liabilities_t;
INSERT INTO liabilities_t (LoanID,UserID,LiabilityCategoryID,SanctionedAmount,InterestRate,LoanTenure,DateofLoanSanction,OutstandingAmount,EMI)
VALUES
( '202202001' , '2' , '002' ,'6000' , '9.2' , '60' , '2022-02-21' , '4875', '125' ),
( '202206010' , '2' , '001' ,NULL , NULL , NULL , '2022-06-15' , '300', NULL ),
( '202201123' , '3' , '003' ,'428000' , '6.87' , '180' , '2022-01-07' , '393620', '3820' ),
( '202201003' , '3' , '001' ,NULL , NULL , NULL , '2021-01-03' , '260', NULL ),
( '202216200' , '4' , '004' ,'40000' , '9.8' , '120' , '2022-02-03' , '33700', '525' ),
( '202212145' , '5' , '003' ,'368000' , '7.2' , '144' , '2022-01-15' , '333593', '3823' ),
( '202211123' , '11' , '003' ,'500000' , '5.2' , '160' , '2022-05-06' , '460949', '4339' ),
( '202200825' , '14' , '003' ,'1200000' , '6.3' , '240' , '2022-10-06' , '1120746', '8806' ),
( '202200178' , '21' , '003' ,'140000' , '8.2' , '96' , '2022-01-13' , '122063', '1993' ),
( '202201957' , '10' , '003' ,'460000' , '7.5' , '108' , '2022-07-07' , '407170', '5870' ),
( '202212617' , '1' , '002' ,'5500' , '8.3' , '48' , '2021-09-21' , '3745', '135' ),
( '202204524' , '12' , '003' ,'500000' , '5.2' , '160' , '2022-05-06' , '460949', '4339' ),
( '202211184' , '17' , '006' ,'3200' , '6.4' , '36' , '2022-01-08' , '2327', '97' ),
( '202212415' , '18' , '003' ,'500000' , '5.2' , '160' , '2022-05-06' , '460949', '4339' ),
( '202206359' , '11' , '001' ,NULL , NULL , NULL , '2021-11-03' , '156', NULL ),
( '202210440' , '9' , '002' ,'7200' , '9.4' , '72' , '2022-02-14' , '6021', '131' ),
( '202204765' , '25' , '001' ,NULL , NULL , NULL , '2022-01-03' , '210', NULL );



DROP TABLE IF EXISTS `investment_categories_t`;
CREATE TABLE IF NOT EXISTS `investment_categories_t` (
    `InvestmentCategoryID` INT NOT NULL AUTO_INCREMENT,
    `InvestmentCategoryName` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `InvestmentCategoryDescription` VARCHAR(50)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    PRIMARY KEY (`InvestmentCategoryID`)
);


-- INSERTING RECORDS FOR investment_categories_t;
INSERT INTO investment_categories_t (InvestmentCategoryName,InvestmentCategoryDescription)
VALUES
('Shares/Stocks', 'Investment in Market shares and stocks') ,
('Real Estate', 'Investment in any property like land, house') ,
('Gold', 'Gold purchase' ) ,
('Deposits/Fixed interest', 'Investment in terms of fixed interest in bank') ,
('Bonds', 'Investment in bond'),
('Cash', 'Cash kept aside as a part of investment') ;


DROP TABLE IF EXISTS `investments_t`;
CREATE TABLE IF NOT EXISTS `investments_t` (
    `UserID` INT DEFAULT NULL,
    `InvestmentID` INT NOT NULL,
    `InvestmentCategoryID` INT DEFAULT '0',
    `DateofInvestment` DATE DEFAULT NULL,
    `InvestmentType` VARCHAR(15)CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI DEFAULT NULL,
    `Amount` DECIMAL(20 , 2 ) DEFAULT '0',
    PRIMARY KEY (`InvestmentID`),
    KEY (`UserID`),
    KEY (`InvestmentCategoryID`),
    CONSTRAINT `investments_FK00` FOREIGN KEY (`UserID`)
        REFERENCES `users_t` (`UserID`),
    CONSTRAINT `investments_FK01` FOREIGN KEY (`InvestmentCategoryID`)
        REFERENCES `investment_categories_t` (`InvestmentCategoryID`)
);


INSERT INTO investments_t (UserID, InvestmentID, InvestmentCategoryID, DateofInvestment, InvestmentType, Amount)
VALUES
('20', '162390' ,'6' , '2022-02-01', 'Credit', '60'),
('19', '150510' ,'4' , '2022-12-10', 'Debit', '100'),
('3' , '162623' ,'6' , '2022-09-01', 'Credit', '55'),
('16' , '138689' ,'3' , '2022-08-13', 'Credit', '100'),
('2' , '121520' ,'2' , '2022-01-29', 'Credit', '100000'),
('10' , '176955' ,'6' , '2022-06-11', 'Debit', '100'),
('3' , '124299' ,'4' , '2022-07-20', 'Debit', '500') ,
('23' , '135574' ,'4' , '2022-09-01', 'Credit', '400'),
('4' , '168276' ,'6' , '2022-02-01', 'Debit', '250'),
('18' , '161999' ,'4' , '2022-12-10', 'Debit', '210'),
('25' , '198473' ,'2' , '2022-09-01', 'Credit', '250000'),
('20' , '192320' ,'1' , '2022-05-01', 'Credit', '230'),
('15' , '108134' ,'5' , '2022-09-01', 'Debit', '340'),
('11' , '173882' ,'5' , '2022-11-29', 'Debit', '440'),
('9' , '125318' ,'5' , '2022-02-01', 'Credit', '160'),
('16' , '127867' ,'4' , '2022-01-28', 'Credit', '280'),
('23' , '123959' ,'2' , '2022-09-01', 'Credit', '540000'),
('1' , '110221' ,'1' , '2022-02-01', 'Debit', '100'),
('4' , '142483' ,'3' , '2022-12-10', 'Credit', '500');

-- Queries

USE WealthManagementDB;

#Calculation the net worth of the user.
CREATE VIEW salary_v AS
    (SELECT 
        u.UserID, SUM(inc.Salary) AS Total_Salary
    FROM
        income_t inc right join user_bank_account_t u
    on inc.AccountID = u.AccountID group by u.UserID);
    
CREATE VIEW liability_v AS
    SELECT 
        UserID, SUM(OutstandingAmount) AS Total_oa
    FROM
        liabilities_t
    GROUP BY UserID;
    
CREATE VIEW invest_v AS
    SELECT 
        UserID, SUM(Amount) AS Total_Invest
    FROM
        investments_t
    GROUP BY UserID;
    
    
CREATE VIEW expense_v AS
    SELECT 
        UserID, SUM(Amount) AS Total_Expense
    FROM
        expenses_t
    GROUP BY UserID;


CREATE VIEW networth AS
    (SELECT 
        a.UserID,
        a.Total_Salary,
        IFNULL(b.Total_Invest, 0) AS Total_Invest,
        IFNULL(c.Total_oa, 0) AS Total_OutStand_Amt,
        IFNULL(d.Total_Expense, 0) AS Total_Expense,
        (a.Total_Salary - IFNULL(d.Total_Expense, 0) + IFNULL(b.Total_Invest, 0) - IFNULL(c.Total_oa, 0)) AS Net_worth
    FROM
        salary_v a
            LEFT JOIN
        invest_v b ON a.UserID = b.UserID
            LEFT JOIN
        liability_v c ON a.UserID = c.UserID
            LEFT JOIN
        expense_v d ON a.UserID = d.UserID);
        
SELECT 
    UserID, Net_Worth
FROM
    networth;

select * from networth where
    Net_worth > (SELECT 
            AVG(Net_Worth)
        FROM
            networth)
        AND Total_Invest != 0;

SELECT 
    UserID, Net_Worth
FROM
    networth
WHERE
    Net_Worth < 0;
    

#Check the liability status of the user:

CREATE TABLE nw AS (SELECT * FROM
    networth);
alter table nw add dtar float;
SET SQL_SAFE_UPDATES = 0;
UPDATE nw 
SET 
    dtar = (Total_OutStand_Amt / (Total_Salary + Total_Invest - Total_Expense));
alter table nw add liability_status varchar(50);
UPDATE nw 
SET 
    liability_status = IF(dtar < 0.6,
        'Green',
        IF(dtar BETWEEN 0.6 AND 0.8,
            'Yellow',
            'Red'));

SELECT 
    *
FROM
    nw;
    
#Average spendings by each User:
SELECT 
    AVG(Total_Expense)
FROM
    networth;

#Users who have bank accounts in BANK OF AMERICA and their Available balance is greater than 20000:
SELECT 
    u.FirstName, u.LastName
FROM
    users_t AS u
        INNER JOIN
    user_bank_account_t AS t ON u.UserID = t.UserID
WHERE
    (t.BankName = 'Bank of America'
        AND t.AvailableBalance >= 20000);

    

#Users Bank Balance
SELECT 
    FirstName, LastName, BankBalance
FROM
    (SELECT 
        inc.UserID AS UserID,
            (TotalIncome - TotalExpenses) AS BankBalance
    FROM
        (SELECT 
        u.UserID, SUM(i.Salary) AS TotalIncome
    FROM
        income_t i left join user_bank_account_t u on i.AccountID = u.AccountID
    GROUP BY u.UserID) AS inc
    JOIN (SELECT 
        UserID, SUM(Amount) AS TotalExpenses
    FROM
        expenses_t
    GROUP BY UserID) AS exp ON inc.UserID = exp.UserID) AS bal
        JOIN
    users_t USING (UserID);
    
-- Stored Procedures

-- Procedure to estimate the expense level of the user.
DROP PROCEDURE IF EXISTS expense_level;

DELIMITER //
CREATE PROCEDURE expense_level(
IN user_id_param INT
)
BEGIN

DECLARE Expense_level VARCHAR(50);
DECLARE Expense_Amount DECIMAL(9,2);
SELECT Total_Expense INTO Expense_Amount FROM expense_v WHERE UserID = user_id_param;
IF Expense_Amount > 500 THEN
SELECT "Large" INTO Expense_level;
ELSEIF Expense_Amount BETWEEN 150 AND 500 THEN
SELECT "Moderate" INTO Expense_level;
ELSEIF Expense_Amount < 150 THEN
SELECT "Small" INTO Expense_level;
END IF;

SELECT UserID, Expense_level FROM expense_v WHERE UserID = user_id_param;
END //
DELIMITER ;

CALL expense_level(9);
CALL expense_level(8);


-- Procedure to check if liabilities greater than investments

CREATE VIEW net_liabilities_v AS (SELECT
UserID, NetInvestment - NetLiabilities AS Dues
FROM
(SELECT
    UserID, SUM(Amount) AS NetInvestment
FROM
    investments_t
WHERE
    InvestmentType = 'Credit'
GROUP BY UserID) AS investments
JOIN
(SELECT UserID, SUM(OutStandingAmount) AS NetLiabilities
FROM liabilities_t GROUP BY UserID) AS liabilities
USING(UserID));

select * from net_liabilities_v;

DROP PROCEDURE IF EXISTS check_liabilities;

DELIMITER //
CREATE PROCEDURE check_liabilities(
IN user_id_param INT
)
BEGIN
DECLARE net_liabilities DECIMAL(20, 2);
DECLARE liability_level VARCHAR(50);
SELECT Dues INTO net_liabilities FROM net_liabilities_v WHERE UserID = user_id_param;
IF net_liabilities > 0 THEN
SELECT "Positive Investments" INTO liability_level;
ELSEIF net_liabilities < 0 THEN
SELECT "Negative Investments" INTO liability_level;
ELSE
SELECT "Balanced Investments" INTO liability_level;
END IF;

SELECT UserID, liability_level FROM net_liabilities_v WHERE UserID = user_id_param;

END //

CALL check_liabilities(9);

-- Procedure to calculate average monthly investments
DELIMITER //

CREATE PROCEDURE avg_monthly_investments()
BEGIN
SELECT
UserID,
EXTRACT(MONTH FROM DateOfInvestment) AS Month,
AVG(Amount)
FROM
investments_t
WHERE 
InvestmentType = 'Credit'
GROUP BY UserID, Month;
END //
DELIMITER ;

CALL avg_monthly_investments();

-- Procedure to calculate total monthly expenses occured by essentials

DROP PROCEDURE IF EXISTS total_monthly_expenses;
DELIMITER //

CREATE PROCEDURE total_monthly_expenses()
BEGIN
SELECT
UserId,
EXTRACT(MONTH FROM TransactionTime) AS Month,
SUM(Amount)
FROM
expenses_t
WHERE 
ExpenseCategoryId IN ('3', '4', '6', '7','8','9','14')
GROUP BY UserID, Month;
END //

DELIMITER ;

CALL total_monthly_expenses();

-- Functions
-- Function to calculate Simple Interest
DROP FUNCTION IF EXISTS simple_interest;

DELIMITER //

CREATE FUNCTION simple_interest
(
principal_amount_param DECIMAL(20, 2),
si_rate_param DECIMAL(3, 2),
n_periods_param INT
)
RETURNS DECIMAL(20, 2)
DETERMINISTIC
BEGIN DECLARE si_amount DECIMAL(20,2);
SET si_amount = principal_amount_param * si_rate_param * n_periods_param / 100;
RETURN (si_amount);
END //
DELIMITER ;

-- Function to calculate compound interest
DROP FUNCTION IF EXISTS compound_interest;

DELIMITER //

CREATE FUNCTION compound_interest
(
principal_amount_param DECIMAL(20,2),
ci_rate_interest_param DECIMAL(10,2),
time_interest INT
)
RETURNS DECIMAL(20,2)
DETERMINISTIC
BEGIN DECLARE ci_amount DECIMAL(20,2);
SET ci_amount =  principal_amount_param  * POWER(1 + (ci_rate_interest_param/100), time_interest);
RETURN (ci_amount);
END//
DELIMITER ;


-- Check if the bank account has positive balance
DROP FUNCTION IF EXISTS is_over_draft;

DELIMITER //

CREATE FUNCTION is_over_draft
(
bank_balance_param DECIMAL(20, 2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN DECLARE balance_type VARCHAR(20);
IF bank_balance_param >= 0 THEN SET balance_type = "Positive Balance";
ELSE SET balance_type = "Over Draft";
END IF;
RETURN (balance_type);
END //
DELIMITER ;

-- Triggers
-- TRIGGER ( PRE INSERT)
DROP TRIGGER IF EXISTS Check_age;

DELIMITER $$

CREATE TRIGGER Check_age BEFORE INSERT ON users_t
FOR EACH ROW
BEGIN
IF datediff(CURDATE(), NEW.DateOfBirth)/365 < 18 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: 
         AGE MUST BE ATLEAST 18 YEARS!';
END IF;
END $$

DELIMITER ;

INSERT INTO users_t(FirstName,LastName,DateOfBirth,SSN,UserAccountTypeID)
VALUES('Tom','Cruise','1971-11-02',101000003,2);


-- TRIGGER 2 ( Pre DELETE)
DROP TABLE IF EXISTS liabilities_t_backup;

CREATE TABLE liabilities_t_backup ( `LoanID` INT,
    `LiabilityCategoryID` INT ,
    `SanctionedAmount` INT ,
    `InterestRate` FLOAT,
    `LoanTenure` INT ,
    `DateofLoanSanction` DATE ,
    `OutstandingAmount` INT ,
    `EMI` INT , 
      PRIMARY KEY(LoanID)); 
      
      
DROP TRIGGER IF EXISTS liabilities_backup;

DELIMITER $$

CREATE TRIGGER liabilities_backup BEFORE DELETE ON  liabilities_t
FOR EACH ROW
BEGIN
INSERT INTO liabilities_t_backup
VALUES ( OLD.LoanID,
    OLD.LiabilityCategoryID,
    OLD.SanctionedAmount,
    OLD.InterestRate,
    OLD.LoanTenure,
    OLD.DateofLoanSanction,
    OLD.OutstandingAmount,
    OLD.EMI);
END $$
DELIMITER ;

DELETE FROM liabilities_t WHERE LoanID = 202200178;
SELECT * FROM liabilities_t_backup;
SELECT * FROM liabilities_t where LoanID = 202200178;


-- POST UPDATE TRIGGER
DROP TABLE IF EXISTS income_change;
CREATE TABLE income_change (
    IncomeID INT PRIMARY KEY,	
    beforeSalary INT,
    afterSalary INT,
    changedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS after_income_update;
DELIMITER $$
CREATE TRIGGER after_income_update
AFTER UPDATE
ON income_t FOR EACH ROW
BEGIN
    IF OLD.Salary <> new.Salary THEN
        INSERT INTO income_change(IncomeID,beforeSalary, afterSalary)
        VALUES(old.IncomeID, old.Salary, new.Salary);
    END IF;
END $$

DELIMITER ;

UPDATE income_t
SET Salary = CAST(Salary * 1.1 AS UNSIGNED);

SELECT * FROM income_change;


-- TRIGGER TO TRACK ADDRESS CHANGE (BEFORE UPDATE)
DROP TABLE IF EXISTS user_address_change_t;
CREATE TABLE user_address_change_t (
UserID INT PRIMARY KEY,
StreetAddress VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(50) NOT NULL,
ZipCode VARCHAR(10) NOT NULL,
changedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
action VARCHAR(50) DEFAULT NULL
);

DROP TRIGGER IF EXISTS user_address_change;

DELIMITER $$

CREATE TRIGGER user_address_change
BEFORE UPDATE ON users_t
FOR EACH ROW
BEGIN 
INSERT INTO user_address_change_t
SET action = 'update',
UserID = OLD.UserID,
StreetAddress = OLD.StreetAddress,
City = OLD.City,
State = OLD.State,
ZipCode = OLD.ZipCode,
changedat = NOW();
END $$

DELIMITER ;

UPDATE users_t SET State = "TX" WHERE UserID = 2;

SELECT * FROM user_address_change_t;

SELECT * FROM users_t WHERE UserID = 1;