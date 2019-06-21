--1. 
SELECT avg(Credit_Score)
FROM Pre_Qualification pq
WHERE accept='Y';


SELECT c.first_name, c.last_name, MAX(pq.credit_score)
FROM pre_qualification pq, consumer c 
WHERE pq.approve= 'N' AND pq.ssn = c.ssn
GROUP BY c.first_name, c.last_name;

SELECT * FROM
(SELECT RANK() OVER(PARTITION BY EXTRACT(YEAR FROM x.c_date) ORDER BY x.loan_amount DESC) rn, x.SSN, x.first_name, x.last_name, x.loan_amount, EXTRACT(YEAR FROM x.c_date) AS c_year
FROM (
    SELECT c.SSN, c.first_name, c.last_name, l.loan_amount, MAX(l.date_created) c_date
    FROM consumer c, relationship r, loan l 
    WHERE c.ssn = r.ssn AND r.loan_number = l.loan_number
    GROUP BY c.SSN, c.first_name, c.last_name, l.loan_amount) x
)WHERE rn= 1;


--List the individuals who took out the biggest loan for each of the loan types (auto, boat, other secured, unsecured)
SELECT l.loan_type, MAX(loan_amount)
FROM loan l
GROUP BY l.loan_type;

-- For which conversations were the employees able to successfully collect $ from the consumers? 
SELECT cm.collection_tick_number, amount_collected
FROM collection_management cm
WHERE cm.amount_collected NOT IN (0);

SELECT e.emp_first_name, e.emp_last_name, MAX(x.amount_collected)
FROM employee e, (
    SELECT cm.employee_id, SUM(amount_collected) amount_collected
    FROM collection_management cm
    WHERE cm.amount_collected NOT IN (0)
    GROUP BY cm.employee_id) x
WHERE e.employee_id=x.employee_id
GROUP BY e.emp_first_name, e.emp_last_name;


SELECT loan_type, SUM(loan_amount)
FROM loan
GROUP BY loan_type
ORDER BY SUM(loan_amount) DESC;

SELECT *
FROM employee;

SELECT *
FROM collection_management;

SELECT *
FROM collection_management cm JOIN employee e ON cm.employee_id = e.employee_id;


SELECT first_name, last_name, DoB
FROM consumer 
WHERE TO_DATE('02/05/2019','dd/mm/yyyy')- DoB > '30';

SELECT loan_number, ROUND((curr_balance/12)*(interest_rate/100),2) AS interest
FROM loan
WHERE ((curr_balance/12)*(interest_rate/100)) > 200;

SELECT loan.date_created
FROM loan;
