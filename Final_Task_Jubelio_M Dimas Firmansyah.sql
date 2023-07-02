
//TASK 1//

CREATE TABLE promo_code (
promo_id SERIAL,
promo_name VARCHAR(100),
price_deduction BIGINT,
description VARCHAR(200),
duration INT,
PRIMARY KEY (promo_id));

//TASK 2//

CREATE TABLE Q3_Q4_Review (
sales_id SERIAL,
purchase_date DATE,
total_price INT,
promo_code CHAR(30),
sales_after_promo INT,
PRIMARY KEY (sales_id));

SELECT * FROM buyer_table;
SELECT * FROM marketplace_table;
SELECT * FROM promo_code;
SELECT * FROM sales_table;
SELECT * FROM shipping_table;
SELECT * FROM seller_table;
SELECT * FROM q3_q4_review;

SELECT * FROM sales_table WHERE purchase_date BETWEEN '2022-07-01' AND '2022-12-31';

SELECT * FROM sales_table INNER JOIN marketplace_table USING(item_id)
WHERE purchase_date BETWEEN '2022-07-01' AND '2022-12-31'
ORDER BY purchase_date ASC;

SELECT * FROM sales_table INNER JOIN promo_code USING(promo_id)
WHERE purchase_date BETWEEN '2022-07-01' AND '2022-12-31'
ORDER BY purchase_date ASC;


//TASK 3//

SELECT sales_table.sales_id, sales_table.purchase_date, sales_table.quantity, marketplace_table.price, 
(quantity*price) AS total_price
FROM sales_table
INNER JOIN marketplace_table ON sales_table.item_id=marketplace_table.item_id
WHERE purchase_date BETWEEN '2022-07-01' AND '2022-12-31'
ORDER BY purchase_date ASC;

SELECT sales_table.sales_id, sales_table.purchase_date, sales_table.quantity, 
marketplace_table.price, sales_table.promo_id, 
(quantity*price) AS total_price, promo_code.price_deduction,
((quantity*price)-promo_code.price_deduction) AS price_after_promo
FROM ((sales_table
INNER JOIN marketplace_table ON sales_table.item_id=marketplace_table.item_id)
INNER JOIN promo_code ON sales_table.promo_id=promo_code.promo_id)
WHERE purchase_date BETWEEN '2022-07-01' AND '2022-12-31'
ORDER BY purchase_date ASC;


//TASK 4//

CREATE TABLE shipping_summary(
shipping_id INT,
shipping_date DATE,
seller_name VARCHAR (255),
buyer_name VARCHAR (255),
buyer_address VARCHAR (50),
buyer_city VARCHAR (255),
buyer_zipcode BIGINT,
kode_resi BIGINT,
PRIMARY KEY (shipping_id));

SELECT * FROM shipping_summary;

SELECT * FROM shipping_table INNER JOIN seller_table USING(seller_id)
WHERE purchase_date BETWEEN '2022-12-01' AND '2022-12-31'
ORDER BY purchase_date ASC;

SELECT * FROM shipping_table INNER JOIN buyer_table USING(buyer_id)
WHERE purchase_date BETWEEN '2022-12-01' AND '2022-12-31'
ORDER BY purchase_date ASC;

SELECT shipping_table.shipping_id, shipping_table.shipping_date, seller_table.seller_name, 
buyer_table.city, buyer_table.zipcode, 
CONCAT (shipping_id,purchase_date,shipping_date,shipping_table.buyer_id,shipping_table.seller_id) 
AS kode_resi FROM ((shipping_table
INNER JOIN seller_table ON shipping_table.seller_id=seller_table.seller_id)
INNER JOIN buyer_table ON shipping_table.buyer_id=buyer_table.buyer_id)
WHERE shipping_date BETWEEN '2022-12-01' AND '2022-12-31'
ORDER BY shipping_date ASC;

SELECT buyer_table.buyer_name, buyer_table.address, buyer_table.city, buyer_table.zipcode, 
CONCAT (shipping_id,purchase_date,shipping_date,shipping_table.buyer_id,shipping_table.seller_id) 
AS kode_resi FROM ((shipping_table
INNER JOIN seller_table ON shipping_table.seller_id=seller_table.seller_id)
INNER JOIN buyer_table ON shipping_table.buyer_id=buyer_table.buyer_id)
WHERE shipping_date BETWEEN '2022-12-01' AND '2022-12-31'
ORDER BY shipping_date ASC;