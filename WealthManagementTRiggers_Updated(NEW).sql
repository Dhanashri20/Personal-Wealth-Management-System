SET SQL_SAFE_UPDATES = 0;

USE wealthmanagementdb;

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