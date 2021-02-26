1.	How many people work for this company?

Select count(*)
from staff

2.	What is the female to male ratio?

Select gender, count(*) as "Number"
from staff
where gender in ('M','F')
GROUP BY gender

3.	a)Highest paid 5? b)Highest paid 6-10? c)Compare?

a)
Select fname as "First Name", lname as "Last Name", Salary
from staff
order by salary DESC
Limit 5

b)
Select fname as "First Name", lname as "Last Name", Salary
from staff
order by salary DESC
Limit 5 OFFSET 5

c)

CREATE VIEW First5 as
(Select fname as "First Name", lname as "Last Name", Salary
from staff
order by salary DESC
Limit 5)

CREATE VIEW Second5 as
(Select fname as "First Name", lname as "Last Name", Salary
from staff
order by salary DESC
Limit 5 OFFSET 5)

Select SUM(First5.Salary) as "Total First 5", SUM(Second5.Salary) as "Total Second 5",
	   Round(AVG(First5.Salary)) as "Average First 5", Round(AVG(Second5.Salary)) as "Average Second 5"
From First5, Second5

4.	Average salary for men and women?

Select Gender, round(AVG(Salary)) as "Average Salary"
from staff
group by gender

5.	How many registered customers do we have?

SELECT count(cust_id) as "Total"
from customer

6.	Top 5 countries with customer count?

SELECT count(*) as "Total", Country as "Country"
from customer
group by Country
Order by count(*) DESC
Limit 5

7.	a) What is the busiest month? b) Worst month?

a)
SELECT SUM(TOTAL) AS "TOTAL", EXTRACT(month from order_date) as "Month"
FROM orders
group by EXTRACT(month from order_date)
Order by SUM(TOTAL) DESC
LIMIT 1

b)
SELECT SUM(TOTAL) AS "TOTAL", EXTRACT(month from order_date) as "Month"
FROM orders
group by EXTRACT(month from order_date)
Order by SUM(TOTAL) ASC
LIMIT 1

8.	Who are our top 5 customers?

create view best_customers as

Select cust_id, SUM(Total)
from orders
group by cust_id
order by SUM(Total) Desc
Limit 5

select cust.cust_id, cust.fname as "First Name",
       cust.lname as "Last Name", best.sum as "Total Sale"
from customer cust, best_customers best
where cust.cust_id = best.cust_id
order by "Total Sale" DESC

9.	Best performing countries?

Create view Total_orders as
Select cust_id, SUM(Total)
from orders
group by cust_id


Select cust.country, sum(tot.sum) as TOTAL
from customer cust, total_orders tot
where cust.cust_id = tot.cust_id
group by cust.country
order by Total DESC
LIMIT 5

10.	Best performing staff?

Create view top_staff_id as
Select staff_id, SUM(Total) as TOTAL
from orders
group by staff_id
order by TOTAL DESC
LIMIT 5

Select staff.staff_id, staff.fname as "First Name", staff.lname as "Last Name", tsi.total as TOTAL, staff.salary as Salary
from staff, top_staff_id tsi
where staff.staff_id = tsi.staff_id
Order by TOTAL Desc

11.	Give bonus to best performing staff? (30% for 1st, 25% for 2nd…)

BEGIN;
UPDATE STAFF SET salary = salary * 1.3 WHERE staff_id = 109;
UPDATE STAFF SET salary = salary * 1.25 WHERE staff_id = 14;
UPDATE STAFF SET salary = salary * 1.2 WHERE staff_id = 47;
UPDATE STAFF SET salary = salary * 1.15 WHERE staff_id = 115;
UPDATE STAFF SET salary = salary * 1.1 WHERE staff_id = 29;
COMMIT;

12.	Most wanted food?

Select food.food_name, sum(od.quantity) as "Total Ordered"
from order_details od
join food on
food.food_id = od.order_id
group by food.food_name
order by "Total Ordered" desc
Limit 5

13.	Least wanted food?

Select food.food_name, sum(od.quantity) as "Total Ordered"
from order_details od
join food on food.food_id = od.order_id
group by food.food_name
order by "Total Ordered" asc
Limit 5

14.	Most ordered food by top 10 countries?

create view top10countries as
select cust.country, sum(orders.total) as Total
from customer cust, orders
where cust.cust_id = orders.cust_id
group by cust.country
order by Total desc
Limit 10

select food.food_name as "Name", sum(odet.quantity) as "Quantity"
from order_details odet, orders, food
where orders.order_id = odet.order_id
AND orders.cust_id IN (select cust.cust_id
					   					 from customer cust
					   			 	 	 where cust.country IN (Select country from top10countries))
AND food.food_id = odet.food_id
group by food.food_name
order by Quantity desc
Limit 5

15.	Get table with the emails and phone numbers?

Create table contactlist as
(Select email as "Email", phone_num as "Phone Number"
 From customer)
