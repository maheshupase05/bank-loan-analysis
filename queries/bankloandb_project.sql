CREATE DATABASE BankLoanDB;
USE BankLoanDB;

# changing issue_date column datatype into varchar
ALTER TABLE financial_loan
MODIFY COLUMN address_state VARCHAR(10),
MODIFY COLUMN application_type VARCHAR(20),
MODIFY COLUMN emp_length VARCHAR(20),
MODIFY COLUMN  emp_title VARCHAR(255),
MODIFY COLUMN  grade CHAR(1),
MODIFY COLUMN home_ownership VARCHAR(20),
MODIFY COLUMN sub_grade VARCHAR(5),
MODIFY COLUMN term VARCHAR(20),
MODIFY COLUMN verification_status VARCHAR(50),
MODIFY COLUMN  annual_income DECIMAL(10,2),
MODIFY COLUMN dti DECIMAL(5,4),
MODIFY COLUMN installment DECIMAL(10,2),
MODIFY COLUMN int_rate DECIMAL(5,4),
MODIFY COLUMN issue_date DATE;


ALTER TABLE financial_loan  
MODIFY COLUMN issue_date VARCHAR(20);


select * from financial_loan;
select count(*) from financial_loan;
 
# (A) BANKLOANREPORT|SUMMARY
# (1) KPI’s:
# (1) Number of Application
# (a) Total loan applications
SELECT count(id) as Total_Loan_Application FROM financial_loan;

# Total loan applications
SELECT count(id) as Total_Loan_Application 
FROM financial_loan;

# (b) MTD Loan Applications
SELECT COUNT(id) AS Total_Applications 
FROM financial_loan
WHERE MONTH(issue_date) = 3;

# (c) PMTD Loan Applications
SELECT COUNT(id) AS Total_Applications 
FROM financial_loan
WHERE MONTH(issue_date) = 2;

# (2) FundedAmount(TotalLoanAmountapproved
# (a) Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM financial_loan;

# (b) MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) =3;

# (c) PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 2;

# (3)Amount Received (Loan Amount paid)
# (a) Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM financial_loan;

# (b) MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM financial_loan
WHERE MONTH(issue_date) = 3;

# (c) PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM financial_loan
WHERE MONTH(issue_date) = 2;

# (4) InterestRate
# (a) Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate
FROM financial_loan;

# (b) MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate 
FROM financial_loan
WHERE MONTH(issue_date) =3;

# (c) PMTD Average Interest
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate 
FROM financial_loan
WHERE MONTH(issue_date) = 2;

# (5) DTI(Debt to Income ratio
# (a) Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI 
FROM financial_loan;

# (b) MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI 
FROM financial_loan
WHERE MONTH(issue_date) = 3;

# (c) PMTD Avg DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI 
FROM financial_loan
WHERE MONTH(issue_date) = 2;



# (2). GOOD LOAN ISSUED
# (1). Good Loan Percentage
SELECT
(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
COUNT(id) AS Good_Loan_Percentage
FROM financial_loan;


# (2). Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications 
FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

# (3). Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount 
FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


# (4). Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

# (3). BAD LOANISSUED
# (1). Bad Loan Percentage
SELECT
(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
COUNT(id) AS Bad_Loan_Percentage
FROM financial_loan;

# (2). Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications 
FROM financial_loan
WHERE loan_status = 'Charged Off';

# (3). Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount 
FROM financial_loan
WHERE loan_status = 'Charged Off';

# (4). Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received 
FROM financial_loan
WHERE loan_status = 'Charged Off';

# (4). LOAN STATUS
# (1). Complete Loan Status Summary
SELECT loan_status,
COUNT(id) AS LoanCount,
SUM(total_payment) AS Total_Amount_Received,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate * 100) AS Interest_Rate,
AVG(dti * 100) AS DTI
FROM  financial_loan
GROUP BY loan_status;

 # (2). MTD Loan Status Summary
SELECT loan_status, 
SUM(total_payment) AS MTD_Total_Amount_Received, 
SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE  MONTH(issue_date) =3 
GROUP  BY loan_status;


# (B). BANK LOAN REPORT|OVERVIEW
# Showcase total number of applications, total loan amount and total amount received for the following parameters

# (a). MONTH OVERVIEW 
SELECT MONTH(issue_date) AS Month_Number,  
       MONTHNAME(issue_date) AS Month_Name,  
       COUNT(id) AS Total_Loan_Applications,  
       SUM(loan_amount) AS Total_Funded_Amount,  
       SUM(total_payment) AS Total_Amount_Received   
FROM financial_loan  
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)  
ORDER BY MONTH(issue_date);


# (b) STATE OVERVIEW
SELECT address_state AS State, 
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;


# (c) TERM OVERVIEW
SELECT term AS Term, 
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term;

# (d) EMPLOYEE LENGTH OVERVIEW
SELECT emp_length AS Employee_Length, 
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

# (e) PURPOSE OVERVIEW
SELECT purpose AS PURPOSE, 
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY purpose;

 
# (f) HOME OWNERSHIP OVERVIEW
SELECT home_ownership AS Home_Ownership, 
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY home_ownership;

# Grade A OVERVIEW
SELECT purpose AS PURPOSE, grade,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;

# (C). Miscellaneous | OVERVIEW
# (1). MoMLoanApplication growth rate
SELECT 
MONTH(issue_date) AS month, 
YEAR(issue_date) AS year,
COUNT(id) AS current_month_apps,
LAG(COUNT(id)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date)) AS prev_month_apps,
ROUND(((COUNT(id) - LAG(COUNT(id)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date))) / 
LAG(COUNT(id)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date))) * 100, 2) AS MoM_Growth_Rate
FROM financial_loan
GROUP BY YEAR(issue_date), MONTH(issue_date)
ORDER BY YEAR(issue_date), MONTH(issue_date);


# (2). MomLoanAmountDisbursed growth rate
SELECT 
MONTH(issue_date) AS month, 
YEAR(issue_date) AS year,
SUM(loan_amount) AS current_month_disbursed,
LAG(SUM(loan_amount)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date)) AS prev_month_disbursed,
ROUND(((SUM(loan_amount) - LAG(SUM(loan_amount)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date))) / 
LAG(SUM(loan_amount)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date))) * 100, 2) AS MoM_Growth_Rate
FROM financial_loan
GROUP BY YEAR(issue_date), MONTH(issue_date)
ORDER BY YEAR(issue_date), MONTH(issue_date);

# (3). Interest rate for various subgrade and grade loan type
SELECT grade, sub_grade, 
ROUND(AVG(CAST(int_rate AS DECIMAL(10,2))), 2) AS avg_interest_rate
FROM financial_loan
GROUP BY grade, sub_grade
ORDER BY grade, sub_grade;


select * from financial_loan;
 
 