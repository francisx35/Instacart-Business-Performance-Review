-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

SELECT *
FROM products;

-- Total Customers - not correct
SELECT COUNT(DISTINCT user_id) AS total_customers
FROM orders;

-- Total revenue
SELECT SUM(p.unit_price * o.quantity) AS total_revenue
FROM orders o
JOIN products p USING(product_id);

-- Average Order Value
SELECT ROUND (SUM(p.unit_price * o.quantity) / COUNT(order_id), 0) 
       AS average_order_value
FROM orders o
JOIN products p USING(product_id);

-- What are the top 5 depts by revenue

SELECT d.department, SUM(p.unit_price * o.quantity) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY total_revenue DESC
LIMIT 5;

-- What are top 3 products we sold most during the weekends?
SELECT p.product_name,
       COUNT(*) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_dow IN (0, 6)
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- Does bread generate more profits than alcoholic products?
SELECT product_name,
       SUM(p.unit_price * o.quantity) AS total_revenue
FROM orders o
JOIN products p USING(product_id)
where product_name like '%bread%'
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

SELECT SUM(p.unit_price * o.quantity) AS total_bread_revenue
FROM orders o
JOIN products p USING(product_id)
where product_name like '%bread%'
GROUP BY p.product_name;

SELECT SUM(p.unit_price * o.quantity) AS total_alcoholic_revenue
FROM orders o
JOIN products p USING(product_id)
where product_name like '%ohol'
GROUP BY p.product_name;

-- Which products have not been sold at all?
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE o.product_id IS NULL;


