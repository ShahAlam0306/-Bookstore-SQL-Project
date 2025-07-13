CREATE TABLE customers (
    cust_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    city VARCHAR(100),
    country VARCHAR(100)
);
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(100),
    published_year INT,
    price DECIMAL(10, 2),
    stock INT
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    cust_id INT REFERENCES customers(cust_id),
    book_id INT REFERENCES books(book_id),
    quantity INT,
    order_date DATE
);

select * from books;
select *from customers;
select * from orders;
--retriver fiction genre--
select * from books where genre = 'Fiction';

--2) find books published after year 1950:
select * from books where published_year>1950;

--3) list all the customers from city canada:
select * from customers where country = 'Canada';

--4)show orders placed in november 2023:
select * from orders where order_date between '2023-11-01' and '2023-11-30';

--5)Retrive the total stock of books available:
select sum(stock) as Total_stock from books;

--6)find the details of most expensive books:
select * from books order by price desc limit 1;

--7)show all cx who order more than quantity of books:
select * from orders where quantity>1;
--8)retriver all orders where the amount exceeds $20:
select * from orders where total_amt>20;

--9) list all the genres available in the books table:
select distinct genre from books;
--10) find the books with the lowest stock:
select * from books order by stock limit 1;
--11) calculate the total revenue generated from all books:
select sum(total_amt) as revenue from orders;

--Advance Questions:
--1) retireve the total number of books sold for each genre:
select b.genre,sum(o.quantity) as Total_books_sold
from orders o 
join books b on o.book_id = b.book_id 
group by b.genre;

--2) find the average price of books in Fantasy genre:
select avg(price) as average_price from books where genre = 'Fantasy';

--3)list of cx who have placed atleast 2 orders:
select o.cust_id,c.name , count(o.order_id) as order_count from orders o
join customers c on  o.cust_id = c.cust_id
group by o.cust_id , c.name
having count(order_id) >= 2;

--4) find the most frequent order book
select o.book_id ,b.title, count(order_id) as order_count from orders o
join books b on o.book_id = b.book_id
group by o.book_id , b.title
order by order_count desc limit 5;

--5) show the top 3 most expensive books of 'fantasy ' genre:
select * from books where genre = 'Fantasy' order by price desc limit 3;

--6) Retrieve the total quantity of books sold by each author:
select b.author, sum(o.quantity) as Total_books_sold from orders o
join books b on o.book_id = b.book_id
group by b.author;
--7) list the cities where cx who spent over $30 are located:
select distinct c.city ,total_amt
from orders o
join customers c on o.cust_id = c.cust_id
where o.total_amt > 30;

--8) find the cx who spent the most on orders:
select c.cust_id , c.name ,sum(o.total_amt) as Total_spent
from orders o
join customers c on o.cust_id = c.cust_id
group by c.cust_id,c.name 
order by Total_spent desc limit 1;

--9) Calculate the stock remaining after fulfilling all orders:
select b.book_id ,b.title , b.stock , coalesce(sum(o.quantity),0) as order_quantity,
b.stock - coalesce(sum(o.quantity),0) as Remaining_quantity
from books b
left join orders o on b.book_id = o.book_id
group by b.book_id;




