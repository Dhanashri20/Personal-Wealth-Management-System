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
