-- BASIC SQL CONCEPTS
-- Example 1: Exploring the 'film' table
DESCRIBE film;

-- Example 2: Exploring the 'customer' table
DESCRIBE customer;

SELECT
    *
FROM
    customer
LIMIT
    5;

-- ESSENTIAL SQL COMMANDS FOR DATA EXPLORATION
-- a. SELECT and WHERE:
-- Example 1: Find films from 2006 with high rental rates
SELECT
    title,
    release_year,
    rental_rate
FROM
    film
WHERE
    release_year = 2006
    AND rental_rate > 4;

-- Example 2: Find all PG-rated films longer than 2 hours
SELECT
    title,
    length,
    rating
FROM
    film
WHERE
    rating = 'PG'
    AND length > 120;

-- b. ORDER BY:
-- Example 1: Find the 10 longest films
SELECT
    title,
    length
FROM
    film
ORDER BY
    length DESC
LIMIT
    10;

-- Example 2: List actors by the number of films they've appeared in
SELECT
    a.first_name,
    a.last_name,
    COUNT(*) as film_count
FROM
    actor AS a
    INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id
ORDER BY
    film_count DESC
LIMIT
    10;

-- c. Aggregation and GROUP BY:
-- Example 1: Average rental rate and film count by rating
SELECT
    rating,
    AVG(rental_rate) as avg_rental_rate,
    COUNT(*) as film_count
FROM
    film
GROUP BY
    rating;

-- Example 2: Calculate total revenue by store
SELECT
    s.store_id,
    SUM(p.amount) as total_revenue
FROM
    payment AS p
    INNER JOIN staff AS s ON p.staff_id = s.staff_id
GROUP BY
    s.store_id;