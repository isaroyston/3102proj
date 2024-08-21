-- a. Subquery:
-- Example 1: Find films with above-average rental rates
SELECT
    title,
    rental_rate
FROM
    film
WHERE
    rental_rate > (
        SELECT
            AVG(rental_rate)
        FROM
            film
    );

-- Example 2: Find customers who have rented more than the average number of films
SELECT
    customer_id,
    first_name,
    last_name
FROM
    customer
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            rental
        GROUP BY
            customer_id
        HAVING
            COUNT(*) > (
                SELECT
                    AVG(rental_count)
                FROM
                    (
                        SELECT
                            COUNT(*) as rental_count
                        FROM
                            rental
                        GROUP BY
                            customer_id
                    ) as avg_rentals
            )
    );

-- b. Common Table Expression (CTE):
-- Example 1: Find top 5 customers by rental count
WITH customer_rentals AS (
    SELECT
        customer_id,
        COUNT(*) as rental_count
    FROM
        rental
    GROUP BY
        customer_id
)
SELECT
    c.first_name,
    c.last_name,
    cr.rental_count
FROM
    customer c
    JOIN customer_rentals cr ON c.customer_id = cr.customer_id
ORDER BY
    cr.rental_count DESC
LIMIT
    5;

-- Example 2: Calculate the percentage of total revenue for each film category
WITH category_revenue AS (
    SELECT
        c.name as category,
        SUM(p.amount) as revenue
    FROM
        category c
        JOIN film_category fc ON c.category_id = fc.category_id
        JOIN film f ON fc.film_id = f.film_id
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
        JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY
        c.category_id
),
total_revenue AS (
    SELECT
        SUM(revenue) as total
    FROM
        category_revenue
)
SELECT
    cr.category,
    cr.revenue,
    (cr.revenue / tr.total) * 100 as percentage
FROM
    category_revenue cr,
    total_revenue tr
ORDER BY
    percentage DESC;

-- c. Window Function:
-- Example 1: Rank films by rental rate
SELECT
    title,
    rental_rate,
    RANK() OVER (
        ORDER BY
            rental_rate DESC
    ) as rental_rate_rank
FROM
    film
LIMIT
    10;

-- Example 2: Calculate a moving average of rental rates
SELECT
    title,
    rental_rate,
    AVG(rental_rate) OVER (
        ORDER BY
            rental_rate ROWS BETWEEN 2 PRECEDING
            AND 2 FOLLOWING
    ) as moving_avg_rate
FROM
    film
ORDER BY
    rental_rate;