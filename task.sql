-- Basic + WHERE + Operators (1–15)

-- 1. Retrieve all accounts with balance greater than 20,000.
select * from accounts
 where balance > 20000;

-- 2. Find customers who live in Chennai.
select * from customers
 where city = 'Chennai';

-- 3. Display accounts with balance between 20,000 and 50,000.
select * from accounts
 where balance between 20000 and 50000;

-- 4. Find customers whose names start with 'J'.
select * from customers
 where name like 'J%';

-- 5. Retrieve accounts of type 'Savings' or 'Current'.
select * from accounts
 where account_type in ( 'Savings', 'Current' );

-- 6. Display accounts that are not 'Savings'.
select * from accounts
 where account_type not in ( 'Savings' );

-- 7. Find customers whose names contain the letter 'a'.
select * from customers
 where name like "%a%";

-- 8. Retrieve accounts with balance less than or equal to 30,000.
select *
  from accounts
 where balance <= 30000;

-- 9. Find customers who are not from Madurai.
select * from customers
 where city != 'Madurai';

-- 10. Display accounts where balance is not between 10,000 and 40,000.
select * from accounts
 where balance not between 10000 and 40000;

-- 11. Retrieve customers whose names end with 'i'.
select * from customers
 where name like '%i';

-- 12. Find accounts with balance equal to 50,000.
select * from accounts
 where balance = 50000;

-- 13. Display customers whose city is either Chennai or Salem.
select * from customers
 where city in ( 'Chennai', 'Salem' );

-- 14. Find accounts with balance greater than 10,000 and less than 40,000.
select * from accounts
 where balance > 10000 and balance < 40000;

-- 15. Retrieve accounts where account type is not in ('Current').
select * from accounts
 where account_type not in ( 'Current' );

-- ORDER BY (16–18)

-- 16. Display all accounts sorted by balance in descending order.
select * from accounts
 order by balance desc;

-- 17. List customers sorted alphabetically by name.
select * from customers
 order by name;

-- 18. Display accounts sorted by account type and then by balance (descending).
select * from accounts
  order by account_type, balance desc;

-- Aggregate Functions (19–23)

-- 19. Find the total balance of all accounts.
select sum(balance) as "total_balance"
  from accounts;

-- 20. Calculate the average balance of accounts.
select avg(balance) as "average_balance"
  from accounts;

-- 21. Find the maximum account balance.
select max(balance) as "maximum_balance"
  from accounts;


-- 22. Find the minimum account balance.
select min(balance) as "minimum_balance"
  from accounts;


-- 23. Count the total number of customers.
select count(*) as "number_of_customers"
  from customers;

-- GROUP BY + HAVING (24–28)

-- 24. Find total balance grouped by account type.
select account_type, sum(balance) as "total_balance"
  from accounts
 group by account_type;

-- 25. Find average balance for each account type.
select account_type, avg(balance) as "average"
  from accounts
 group by account_type;


-- 26. Display account types having average balance greater than 20,000.
select account_type from accounts
 group by account_type
having avg(balance) > 20000;


-- 27. Count number of accounts for each customer.
select cystiner_id, count(*) as "total_accounts"
  from accounts
 group by customer_id;

-- 28. Display customers having more than one account.-------------------------------------------
SELECT c.customer_id, c.name, COUNT(a.account_id) AS "total_accounts"
FROM customers c INNER JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(a.account_id) > 1;

--  JOINS (29–35)

-- 29. Retrieve customer names along with their account balances.
select customers.name, accounts.balance from customers inner join accounts
on customers.customer_id = accounts.customer_id;


-- 30. Display all customers and their accounts (including customers without accounts).
select * from customers left join accounts
on customers.customer_id = accounts.customer_id;

-- 31. Display all accounts and corresponding customer details.
select * from accounts inner join customers
on customers.customer_id = accounts.customer_id;

-- 32. Retrieve customer names and account types where balance is greater than 20,000.
select customers.name , accounts.account_type from customers inner join accounts
on customers.customer_id = accounts.customer_id
where accounts.balance > 20000;

-- 33. List customers with their total balance using JOIN. ------------------------------------------------------------------------------------
select c.customer_id, c.name, sum(a.balance) as "total_balance" from customers c inner join accounts a 
on c.customer_id = a.customer_id
group by c.customer_id, c.name;

-- 34. Display customer names and balances sorted by balance.
select customers.name , accounts.balance from customers inner join accounts
on customers.customer_id = accounts.customer_id
order by accounts.balance;

-- 35. Count number of accounts for each city using JOIN.
select c.city, count(a.account_id) as "total_accounts" from customers c inner join accounts a 
on c.customer_id = a.customer_id
group by c.city;

-- SUBQUERIES (36–40)

-- 36. Find accounts with balance greater than average balance.
select * from accounts where balance > (
   select avg(balance) from accounts);

-- 37. Retrieve customers who have accounts.
select * from customers where customer_id in (
   select customer_id from accounts);


-- 38. Find customers who do not have any accounts.
SELECT * FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM accounts a
    WHERE a.customer_id = c.customer_id
);

-- 39. Display account(s) with the maximum balance.
select * from accounts where customer_id = (
   select customer_id from accounts where balance = (
      select max(balance) from accounts));

-- 40. Find customers whose total balance is greater than 40,000.
select * from customers where customer_id in (
   select customer_id from accounts where balance > 40000);


-- RAILWAY RESERVATION – QUESTIONS

-- Basic + WHERE + Operators (41–45)


-- 41. Retrieve all bookings with fare greater than 400.
select * from bookings where fare > 400;

-- 42. Find bookings where status is not 'Confirmed'.
select * from bookings where status not in ('Confirmed');

-- 43. Display trains starting from Chennai.
select * from trains where source = 'Chennai';

-- 44. Retrieve bookings with fare between 300 and 500.
select * from bookings where fare between 300 and 500;

-- 45. Find passengers whose names start with 'A'.
select * from bookings where passenger_name like 'A%';

-- JOINS + GROUP BY + ORDER BY (46–48)

-- 46. Retrieve train names along with passenger names.
select t.train_name, b.passenger_name from trains  t inner join bookings  b
on t.train_id = b.train_id;

-- 47. Count number of bookings for each train.
select t.train_name, count(*) as total_booking from trains  t inner join bookings  b
on t.train_id = b.train_id
group by t.train_name;

-- 48. Display train names and total fare collected for each train.
select t.train_name, sum(b.fare) as total_fare from trains  t inner join bookings  b
on t.train_id = b.train_id
group by t.train_name;

-- SUBQUERIES (49–50)

-- 49. Find bookings with fare equal to the highest fare.
select * from bookings where fare = (select max(fare) from bookings);

-- 50. Retrieve trains that have more than one booking.
select * from trains where train_id in (select train_id from bookings group by train_id having count(*) > 1);


-- Employee Table

-- 1. Find the total number of employees in each department.
select department, count(*) as "Number_of_emps" from employees group by department;

-- 2. Find the average salary of employees in each department.
select department, avg(salary) as "Average_salary" from employees group by department;

-- 3. Display departments having more than one employee.
select department, count(*) as "number_of_emps" from employees 
  group by department 
  having count(*) > 1;

-- 4. Find the highest salary in each department.
select department, max(salary) as "Maximum_salary" from employees group by department;

-- 5. Find the lowest salary in each department.
select department, min(salary) as "Minimum_salary" from employees group by department;


-- 6. Find departments whose average salary is greater than 50,000.
select department from employees group by department having avg(salary) > 50000;

-- 7. Calculate the total salary expenditure for each department.
select department, sum(salary) as "expenditure" from employees group by department;

-- 8. Display all employees sorted by salary in descending order.
select * from employees order by salary desc;

-- 9. Display employees sorted first by department and then by salary in descending order.
select * from employees order by department, salary desc;

-- 10. Find cities that have more than one employee.
select city from employees group by city having count(*) > 1;

-- 11. Find the total salary paid in each city.
select city, sum(salary) as "total_salary" from employees group by city;

-- 12. Display departments ordered by total salary expenditure from highest to lowest.
SELECT department, SUM(salary) AS total_expenditure FROM Employee
GROUP BY department
ORDER BY total_expenditure DESC;

-- 13. Find the number of employees in each department whose salary is greater than 50,000.
select department, count(*) as "Number_of_emps" from employees where salary > 50000 group by department;

-- 14. Find the difference between the highest and lowest salary in each department.
select department, max(salary), min(salary), max(salary) - min(salary) as "difference" from employees group by department;

-- 15. Display the top 3 highest-paid employees.
select * from employees order by salary desc 
limit 3;


-- Customers & Orders Tables

-- 16. Find the total order amount for each customer.
select c.customer_id, c.customer_name, sum(amount) as "total_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

-- 17. Find customers who have placed more than 3 orders.
select * from customers where customer_id in (select customer_id from orders group by customer_id having count(*) > 3);

-- 18. Find the average order amount for each customer.
select c.customer_id, c.customer_name, avg(amount) as "average_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;


-- 19. Find the highest order amount placed by each customer.
select c.customer_id, c.customer_name, max(amount) as "highest_order_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

-- 20. Display customers sorted by their total purchase amount.
select c.customer_id, c.customer_name, sum(amount) as "total_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by sum(amount);

-- 21. Find customers whose total purchase amount exceeds 10,000.
select c.customer_id, c.customer_name, sum(o.amount) as "total_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;
having sum(o.amount ) > 10000;

-- 22. Display customer names along with the total number of orders placed.
select c.customer_id, c.customer_name, count(*) as "number_of_orders" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

-- 23. Find the customer who spent the highest amount.
SELECT c.customer_id, c.customer_name, SUM(o.amount) AS total_amount
FROM Customers c INNER JOIN Orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_amount DESC
LIMIT 1;

-- 24. Find the customer who placed the maximum number of orders.
SELECT *
FROM Customers
WHERE customer_id = (
    SELECT customer_id FROM Orders
    GROUP BY customer_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
-- 25. Find customers whose average order amount is greater than 2,000.
select * from customers where customer_id in (select customer_id from orders group by  customer_id having avg(amount) > 2000);

-- 26. Display the top 5 customers based on total purchase amount.
select c.customer_id, c.customer_name, sum(amount) as "total_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by sum(amount) desc
limit 5;

-- 27. Find the minimum order amount for each customer.
select c.customer_id, c.customer_name, min(amount) as "minimum_order_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

-- 28. Find customers who have placed orders worth more than 5,000 in total.
select c.customer_id, c.customer_name, sum(amount) as "total_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(amount) > 5000;

-- 29. Display customer-wise total orders and total purchase amount.
select c.customer_id, c.customer_name, count(*) as "total_orders", sum(amount) as "total_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by sum(amount);

-- 30. Find customers who placed more than 2 orders and spent more than 8,000.
select c.customer_id, c.customer_name, count(*) as "total_orders", sum(amount) as "total_amount" from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(*) > 2 and sum(amount) > 8000;

-- Students Table

-- 31. Find the average marks scored by students in each department.
select department, avg(marks) as "average_marks" from students group by department;

-- 32. Find departments whose average marks are above 75.
select department from students group by department having avg(marks) > 75;


-- 33. Find the highest mark scored in each department.
select department, max(marks) as "highest_mark" from students group by department;

-- 34. Find the total number of students in each department.
select department, count(*) as "number_of_students" from students group by department;


-- 35. Find departments having more than 5 students.
select department from students group by department having count(*) > 5;


-- 36. Display departments sorted by average marks in descending order.
select department, avg(marks) as "average_marks" from students group by department order by avg(marks) desc;

-- 37. Find the top 3 departments based on average marks.
select department, avg(marks) from students group by department order by avg(marks) desc limit 3;

-- 38. Find departments whose average marks are between 70 and 90.
select department, avg(marks) as "average_marks" from students group by department having avg(marks) between 70 and 90;

-- 39. Find the total marks scored by students in each department.
select department, sum(marks) as "total_marks" from students group by department;

-- 40. Display departments sorted by the total number of students.
select department, count(*) as "number_of_students" from students group by department order by count(*);

-- 41. Find the lowest mark scored in each department.
select department, min(marks) as "minimum_mark" from students group by department;

-- 42. Find departments where the highest mark is greater than 90.
select department, max(marks) as "highest_mark" from students group by department having max(mark) > 90;

-- 43. Find the number of students scoring above 80 in each department.
select department,count(*) as "number_of_students" from students where marks > 80 group by department;

-- 44. Find departments where more than 3 students scored above 75.
select department from students where marks > 75 group by department having count(*) > 3;

-- 45. Display departments ordered by highest mark in descending order.
select department , max(marks) as "highest_mark" from students group by department order by max(marks) desc;