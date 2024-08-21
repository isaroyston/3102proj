-- Practical Examples and Use Cases
-- Example 1: Analyze film category popularity
SELECT
    c.name as category,
    COUNT(r.rental_id) as rental_count,
    AVG(f.rental_rate) as avg_rental_rate
FROM
    category c
    INNER JOIN film_category fc ON c.category_id = fc.category_id
    INNER JOIN film f ON fc.film_id = f.film_id
    INNER JOIN inventory i ON f.film_id = i.film_id
    INNER JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY
    c.category_id
ORDER BY
    rental_count DESC;

-- Example 2: Analyze customer rental behavior
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT r.rental_id) as total_rentals,
    COUNT(DISTINCT DATE(r.rental_date)) as rental_days,
    ROUND(
        COUNT(DISTINCT r.rental_id) / COUNT(DISTINCT DATE(r.rental_date)),
        2
    ) as avg_rentals_per_day
FROM
    customer c
    INNER JOIN rental r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id
HAVING
    total_rentals > 30
ORDER BY
    avg_rentals_per_day DESC
LIMIT
    10;