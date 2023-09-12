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