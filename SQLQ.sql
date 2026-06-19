create table Books(
				Book_ID serial Primary key,
				Title varchar(100),
				Author varchar(100),
				Genre varchar(50),
				Published_Year int,
				Price numeric(10,2),
				Stock int
				)

select * from Books;
copy Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
from 'D:\Data_Analyst\SQLPROJECT\Books.csv'
csv header;

create table Customers(
				Customer_ID serial Primary key,
				Name varchar(100),
				Email varchar(100),
				Phone varchar(15),
				City varchar(50),
				Country varchar(150)

)
drop table Customers;
select * from Customers;

copy Customers(Customer_ID,Name,Email,Phone,City,Country)
from 'D:\Data_Analyst\SQLPROJECT\Customers.csv'
csv header;


create table Orders(
				Order_ID serial Primary key,
				Customer_ID int References Customers(Customer_ID),
				Book_ID int References Books(Book_ID),
				Order_Date date,
				Quantity int,
				Total_Amount numeric(10,2)
)
select * from Orders;
drop table Orders;
copy Orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
from 'D:\Data_Analyst\SQLPROJECT\Orders.csv'
csv header;


-- 1. Retrive All Books of Fiction Genre
select * from Books where genre='Fiction'

-- 2.Find Books Published After Year 1950
select * from Books where published_year>1950

-- 3.List All Customers From Candas
select * from Customers
select * from Customers where country='Canada'

--4.Show Orders Placed In November 2023
select * from Orders;
select * from Orders where order_date between '2023-11-01'and '2023-11-30'

--5.Retrive the Total Stock of Books Available
select * from Books;
select sum(stock) as Total_Stock from Books;

--6.find Most Expensive Books
select * from Books order by price desc limit 5;

--7.Show All Customers who ordered more than 1 quantity of books
select * from Orders where quantity>1

--8.Retrive the All Orders where the Total Amount Exceeds 20 Dollars
select * from Orders
select * from Orders where total_amount>20

--9.List all Genre
select distinct genre from Books;

--10.Lowest Stock
select * from Books order by stock ;


--11.Calculated Total Revenue Generated From All Orders
select  sum(total_amount) as Total_Revenue  from Orders


select * from Orders;
select b.Genre,o.quantity,sum(o.quantity) over(partition by b.Genre) from Books b inner join Orders o on b.Book_ID=o.Book_ID;

--12.Find The Average Price of books in The Fantasy Genre
select avg(price)as Avg_PriceofFantasy from Books where Genre='Fantasy';
select * from Books
select * from Orders;

--13. Find Customer Who Placed Atleat 2 Time Order
select customer_ID,count(customer_ID) from Orders group by customer_id having count(Customer_ID)>=2;
select count(o.Customer_ID),c.Name from Customers c inner join Orders o  on c.Customer_ID=o.Customer_ID group by o.Customer_ID,c.Name having count(o.Customer_ID)>=2;

--We can use order by after and before the having clause
--14.Most Frequently Ordered Books
select count(Book_Id)as total ,Book_ID from Orders group by Book_ID order by total desc;


--15.show the top 3 most Expensive Books Of Fantasy Genre
select * from Books where Genre='Fantasy' order by price desc limit 3;

--16.Retrive Total Quantity of Books sold by each author
select o.quantity,b.Title,b.author from Books b inner join Orders o on b.Book_ID=o.Book_ID order by Author;
select sum(o.quantity),b.Title,b.author from Books b inner join Orders o on b.Book_ID=o.Book_ID group by b.author,b.Title order by b.author ;


--17.List The City where Customers who spent over 30 dollars are located
select * from Customers;
select * from Books order by stock
select * from Orders order by Quantity;
select distinct c.city,sum(o.total_amount) from Customers c inner join Orders o  on c.Customer_ID=o.Customer_ID group by c.city,c.Name having sum(o.total_amount)>30 order by c.city;

--18.Find The Customer who Spent the Most On Orders
select o.customer_id,c.Name,count(o.customer_id),sum(o.total_amount)as Total_Spent from Orders o inner join Customers c on c.Customer_ID=o.Customer_ID group by o.customer_id,c.Name order by Total_Spent desc;
select o.customer_id,c.Name,count(o.customer_id),sum(o.total_amount)as Total_Spent from Orders o inner join Customers c on c.Customer_ID=o.Customer_ID group by o.customer_id,c.Name order by Total_Spent desc limit 5;

--19.Calculate the Stock Remaining after fulfilling all records
select o.Book_ID,b.stock,count(o.Book_ID),sum(o.quantity)as total_q,(b.stock-sum(o.quantity))as remaining_stock from Books b inner join Orders o on b.Book_ID=o.Book_ID group by o.Book_ID,b.stock order by o.Book_ID;







