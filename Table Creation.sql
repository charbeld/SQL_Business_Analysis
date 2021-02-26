Create table Staff (
	Staff_id INT NOT NULL,
	Fname varchar(40) NOT NULL,
	Lname varchar(40) NOT NULL,
	Gender varchar(1) NOT NULL,
	Salary Int NOT NULL,
	Primary key (Staff_id))

Create table Customer (
	Cust_id INT NOT NULL,
	Fname varchar(40) NOT NULL,
	Lname varchar(40) NOT NULL,
	Email varchar(100),
	Phone_num INT NOT NULL,
	Country varchar(40) Not NULL,
	Primary Key (Cust_id))

Create table Food (
	Food_id INT NOT NULL,
	Food_name varchar(40) NOT NULL,
	Category varchar(40) NOT NULL,
	Quantity INT NOT NULL,
	Purchase_Date DATE NOT NULL,
	Primary Key (Food_id))

Create table Orders (
	Order_id INT NOT NULL,
	Cust_id INT NOT NULL,
	Staff_id INT NOT NULL,
	Order_Date DATE NOT NULL,
	Total INT NOT NULL,
	Primary Key (Order_id),
	Foreign Key (Cust_id) REFERENCES Customer(Cust_id),
	Foreign Key (Staff_id) REFERENCES Staff(Staff_id))

Create table Order_Details (
	Order_detail_id INT NOT NULL,
	Order_id INT NOT NULL,
	Food_id INT NOT NULL,
	Quantity INT NOT NULL,
	Primary KEY (Order_detail_id),
	FOREIGN KEY (Order_id) REFERENCES Orders(Order_id),
	FOREIGN KEY (Food_id) REFERENCES Food(Food_id))
