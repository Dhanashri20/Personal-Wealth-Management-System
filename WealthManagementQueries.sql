USE WealthManagementDB;

CREATE VIEW salary_v AS
    SELECT 
        UserID, SUM(Salary) AS Total_Salary
    FROM
        income_t
    GROUP BY UserID;
    
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

    
drop view networth;

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

SELECT 
    *
FROM
    networth
WHERE
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

SELECT 
    AVG(Total_Expense)
FROM
    networth;
    

SELECT 
    f.FirstName, f.LastName, i.BonusIncluded
FROM
    family_member_t AS f
        INNER JOIN
    income_t AS i ON f.UserID = i.UserID
WHERE
    i.BonusIncluded = '1';


SELECT 
    u.FirstName, u.LastName
FROM
    users_t AS u
        INNER JOIN
    user_bank_account_t AS t ON u.UserID = t.UserID
WHERE
    (t.BankName = 'Bank of America'
        AND t.AvailableBalance >= 20000);


SELECT 
    AVG(Total_Expense)
FROM
    networth;
    

-- Users Bank Balance
SELECT 
    FirstName, LastName, BankBalance
FROM
    (SELECT 
        inc.UserID AS UserID,
            (TotalIncome - TotalExpenses) AS BankBalance
    FROM
        (SELECT 
        UserID, SUM(Salary) AS TotalIncome
    FROM
        income_t
    GROUP BY UserID) AS inc
    JOIN (SELECT 
        UserID, SUM(Amount) AS TotalExpenses
    FROM
        expenses_t
    GROUP BY UserID) AS exp ON inc.UserID = exp.UserID) AS bal
        JOIN
    users_t USING (UserID);
    
-- UNIONS
-- UNION ALL
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    i.IncomeSource,
    i.Salary,
    ict.InvestmentCategoryName
FROM
    users_t u
        INNER JOIN
    income_t i ON u.UserID = i.UserID
        INNER JOIN
    investments_t it ON it.UserID = i.UserID
        INNER JOIN
    investment_categories_t ict ON it.InvestmentCategoryID = ict.InvestmentCategoryID
WHERE
    i.IncomeSource = 'Vendor' 
UNION ALL SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    i.IncomeSource,
    i.Salary,
    ict.InvestmentCategoryName
FROM
    users_t u
        INNER JOIN
    income_t i ON u.UserID = i.UserID
        INNER JOIN
    investments_t it ON it.UserID = i.UserID
        INNER JOIN
    investment_categories_t ict ON it.InvestmentCategoryID = ict.InvestmentCategoryID
WHERE
    ict.InvestmentCategoryName = 'Real Estate';


-- UNION 
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    i.IncomeSource,
    i.Salary,
    ict.InvestmentCategoryName
FROM
    users_t u
        INNER JOIN
    income_t i ON u.UserID = i.UserID
        INNER JOIN
    investments_t it ON it.UserID = i.UserID
        INNER JOIN
    investment_categories_t ict ON it.InvestmentCategoryID = ict.InvestmentCategoryID
WHERE
    i.IncomeSource = 'Vendor' 
UNION ALL SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    i.IncomeSource,
    i.Salary,
    ict.InvestmentCategoryName
FROM
    users_t u
        INNER JOIN
    income_t i ON u.UserID = i.UserID
        INNER JOIN
    investments_t it ON it.UserID = i.UserID
        INNER JOIN
    investment_categories_t ict ON it.InvestmentCategoryID = ict.InvestmentCategoryID
WHERE
    ict.InvestmentCategoryName = 'Real Estate';

