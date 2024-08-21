-- Different Types of Joins for our Sakila example
-- a. INNER JOIN:
-- Returns rows that have matching value in both tables
-- Example 1: Find all rentals with customer information
SELECT
    r.rental_id,
    c.first_name,
    c.last_name,
    r.rental_date
FROM
    rental AS r
    INNER JOIN customer AS c ON r.customer_id = c.customer_id
LIMIT
    10;

-- Example 2: Get film titles and their categories
SELECT
    f.title,
    c.name AS category
FROM
    film f
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    INNER JOIN category AS c ON fc.category_id = c.category_id
LIMIT
    10;

-- b. LEFT JOIN:
-- Return all rows from the left table, and the matched rows from the right table
-- Example 1: List all customers and their rentals (including customers with no rentals)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    r.rental_id
FROM
    customer c
    LEFT JOIN rental r ON c.customer_id = r.customer_id
LIMIT
    15;

-- Example 2: Find films and their rental information (including films never rented)
SELECT
    f.film_id,
    f.title,
    r.rental_id
FROM
    film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE
    r.rental_id IS NULL
LIMIT
    10;

-- c. RIGHT JOIN:
-- Returns all rows from the right table, and the matched rows from the left table
-- Example 1: List all stores and their managers (if any)
SELECT
    s.store_id,
    s.address_id,
    st.first_name,
    st.last_name
FROM
    staff st
    RIGHT JOIN store s ON st.store_id = s.store_id;

-- Example 2: Show all film categories, even those without films
SELECT
    f.title,
    c.name AS category
FROM
    film f
    RIGHT JOIN film_category fc ON f.film_id = fc.film_id
    RIGHT JOIN category c ON fc.category_id = c.category_id
LIMIT
    15;

-- d. FULL OUTER JOIN (Simulated in MySQL):
-- Returns all rows when there is a match in either left or right table.
-- NOTE: MySQL doesn't support FULL OUTER JOIN directly. Use a UNION operation.
-- Example: List all customers and all payments, matching where possible
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    p.payment_id,
    p.amount
FROM
    customer c
    LEFT JOIN payment p ON c.customer_id = p.customer_id
UNION
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    p.payment_id,
    p.amount
FROM
    customer c
    RIGHT JOIN payment p ON c.customer_id = p.customer_id
LIMIT
    15;

-- e. CROSS JOIN:
-- Returns all possible combinations of both tables
-- Example 1: Generate all possible film and actor combinations
SELECT
    f.title,
    a.first_name,
    a.last_name
FROM
    film f
    CROSS JOIN actor a
LIMIT
    20;

-- Example 2: Create a combination of all stores and films (for potential inventory)
SELECT
    s.store_id,
    f.film_id,
    f.title
FROM
    store s
    CROSS JOIN film f
LIMIT
    15;

-- f. Using CROSS JOIN as INNER JOIN (Not Recommended):
-- Example: Find rentals and customer information (inefficient way)
SELECT
    r.rental_id,
    c.first_name,
    c.last_name,
    r.rental_date
FROM
    rental r
    CROSS JOIN customer c
WHERE
    r.customer_id = c.customer_id
LIMIT
    10;