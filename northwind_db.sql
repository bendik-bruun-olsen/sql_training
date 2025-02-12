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
SELECt
  employee_id,
  order_id,
  customer_id,
  required_date,
  shipped_date
FROM orders
WHERE shipped_date > required_date;
---
