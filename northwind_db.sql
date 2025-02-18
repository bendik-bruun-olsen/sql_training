--- NORTHWIND DB---

--- EASY ---
SELECT category_name, description
FROM categories
ORDER BY category_name;
---
SELECT contact_name, address, city
FROM customers
WHERE country NOT IN ('Germany', 'Mexico', 'Spain');
---
SELECT order_date, shipped_date, customer_id, freight
FROM orders
WHERE order_date = '2018-02-26';
---
SELECT
  employee_id,
  order_id,
  customer_id,
  required_date,
  shipped_date
FROM orders
WHERE shipped_date > required_date;
---
SELECT order_id
FROM orders
WHERE order_id % 2 = 0;
---
SELECT
  city,
  company_name,
  contact_name
FROM customers
where city LIKE '%L%'
ORDER by contact_name;
---
SELECT
  company_name,
  contact_name,
  fax
FROM customers
where fax IS NOT NULL;
---
SELECT
  first_name,
  lASt_name,
  MAX(hire_date)
FROM employees;
---
SELECT
  ROUND(AVG(unit_price), 2) AS average_price,
  SUM(units_in_stock) AS total_stock,
  SUM(discontinued) AS total_discontinued
from products;
---

--- MEDIUM ---
SELECT
  p.product_name,
  s.company_name,
  c.category_name
FROM products AS p
  JOIN suppliers AS s ON s.supplier_id = p.supplier_id
  JOIN categories AS c ON c.category_id = p.category_id;
---
select
  c.category_name,
  ROUND(AVG(p.unit_price), 2)
FROM categories AS c
  JOIN products AS p ON p.category_id = c.category_id
GROUP BY category_name;
---
SELECT
  city,
  company_name,
  contact_name,
  'customers' AS relationship
from customers
UNION
SELECT
  city,
  company_name,
  contact_name,
  'suppliers' AS relationship
FROM suppliers
---
SELECT
  YEAR(order_date) AS order_year,
  MONTH(order_date) AS order_month,
  COUNT(*) AS no_of_orders
FROM orders
GROUP BY order_year, order_month;
---

--- HARD ---
SELECT
  e.first_name,
  e.last_name,
  COUNT(*) as num_orders,
  CASE
    WHEN o.shipped_date IS NULL THEN 'Not Shipped'
    WHEN o.shipped_date <= o.required_date THEN 'On Time'
    ELSE 'Late'
  END as shipped
FROM employees e
  JOIN orders o ON o.employee_id = e.employee_id
GROUP BY
  e.first_name,
  e.last_name,
  shipped
ORDER BY
  e.last_name,
  e.first_name,
  num_orders DESC
---