CREATE SCHEMA IF NOT EXISTS books;
SET SCHEMA 'books';

DROP TABLE IF EXISTS BOOKS CASCADE;

CREATE TABLE BOOKS (
    index INT,
    publishing_year INT,
    book_name TEXT,
    author TEXT,
    language_code TEXT,
    author_rating TEXT,
    book_avg_rating NUMERIC,
    book_ratings_count INT,
    genre TEXT,
    gross_sales NUMERIC,
    publisher_revenue NUMERIC,
    sale_price NUMERIC,
    sales_rank INT,
    publisher TEXT,
    units_sold INT
);


SELECT * FROM BOOKS LIMIT 10;

-- Top Rated Books
SELECT book_name, book_avg_rating
FROM BOOKS
ORDER BY book_avg_rating DESC
LIMIT 10;

-- Best-Selling Books by Genre
SELECT genre, SUM(gross_sales) AS total_sales
FROM BOOKS
GROUP BY genre
ORDER BY total_sales DESC;

-- Avg Sale Price
-- Negative publishing year indicates BCE
SELECT author, publishing_year, AVG(sale_price) AS avg_price
FROM BOOKS
GROUP BY publishing_year, author
ORDER BY publishing_year;

-- Best-Selling Authors
SELECT author, SUM(units_sold) AS total_books
FROM BOOKS
GROUP BY author
ORDER BY total_books DESC
LIMIT 10;

-- Total Books Sold
SELECT SUM(units_sold) AS total_books_sold
FROM BOOKS;

-- Total Gross Sales
SELECT SUM(gross_sales) as total_sales
FROM BOOKS;

-- Sales Over Time
SELECT publishing_year, SUM(units_sold) AS total_books_sold
FROM BOOKS
WHERE publishing_year >= 1850
GROUP BY publishing_year
ORDER BY publishing_year;

-- Avg Book Rating by Year
SELECT publishing_year, AVG(book_avg_rating) AS avg_rating
FROM BOOKS
GROUP BY publishing_year
ORDER BY publishing_year;

-- Top Rated Books w/ Minimum Ratings = 1000
SELECT book_name, book_avg_rating, book_ratings_count
FROM BOOKS
WHERE book_ratings_count >= 1000
ORDER BY book_avg_rating DESC
LIMIT 10;

-- Avg Price by Genre
SELECT genre, AVG(sale_price) as avg_price
FROM BOOKS
GROUP BY genre
ORDER BY avg_price DESC;

-- Revenue per Book Sold
SELECT book_name, gross_sales / units_sold AS revenue_per_book
FROM BOOKS
WHERE units_sold > 0
ORDER BY revenue_per_book DESC
LIMIT 10;

-- Sale Price vs. Units Sold
SELECT book_name, sale_price, units_sold
FROM BOOKS
ORDER BY units_sold DESC;

-- Profit Margin
SELECT book_name, gross_sales - publisher_revenue AS est_profit
FROM BOOKS
ORDER BY est_profit DESC
LIMIT 10;

-- Best-Selling Publisher
SELECT publisher, gross_sales
FROM BOOKS
ORDER BY gross_sales DESC
LIMIT 10;

-- Rating vs. Revenue
SELECT book_name, book_avg_rating, publisher_revenue
FROM BOOKS
ORDER BY publisher_revenue DESC;