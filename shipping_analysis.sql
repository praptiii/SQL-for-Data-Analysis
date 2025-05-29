CREATE DATABASE ecommerce_data;
USE ecommerce_data;
CREATE TABLE shipping_data (
    ID INT PRIMARY KEY,
    Warehouse_block VARCHAR(10),
    Mode_of_Shipment VARCHAR(50),
    Customer_care_calls INT,
    Customer_rating FLOAT,
    Cost_of_the_Product FLOAT,
    Prior_purchases INT,
    Product_importance VARCHAR(20),
    Gender VARCHAR(10),
    Discount_offered FLOAT,
    Weight_in_gms FLOAT,
    Reached_on_time INT
);

SELECT Mode_of_Shipment, COUNT(*) AS total_orders
FROM shipping_data
GROUP BY Mode_of_Shipment;

SELECT Warehouse_block, AVG(Cost_of_the_Product) AS avg_cost
FROM shipping_data
GROUP BY Warehouse_block;

SELECT * FROM shipping_data
WHERE Reached_on_time = 1;

CREATE TABLE customers (
    Customer_ID INT PRIMARY KEY,
    Gender VARCHAR(10),
    Age_Group VARCHAR(20)
);
INSERT INTO customers (Customer_ID, Gender, Age_Group)
SELECT DISTINCT ID, Gender,
    CASE
        WHEN Customer_rating >= 4 THEN 'Young'
        WHEN Customer_rating >= 2 THEN 'Middle'
        ELSE 'Senior'
    END AS Age_Group
FROM shipping_data;

SELECT ID, Cost_of_the_Product, Discount_offered
FROM shipping_data
WHERE Cost_of_the_Product > 200
ORDER BY Discount_offered DESC;

SELECT Mode_of_Shipment, 
       AVG(Customer_rating) AS avg_rating, 
       SUM(Discount_offered) AS total_discount
FROM shipping_data
GROUP BY Mode_of_Shipment;

SELECT s.ID, s.Mode_of_Shipment, c.Age_Group
FROM shipping_data s
INNER JOIN customers c ON s.ID = c.Customer_ID;

SELECT s.ID, s.Mode_of_Shipment, c.Age_Group
FROM shipping_data s
LEFT JOIN customers c ON s.ID = c.Customer_ID;

SELECT ID, Customer_rating
FROM shipping_data
WHERE Customer_rating > (
    SELECT AVG(Customer_rating) FROM shipping_data
);

CREATE VIEW shipment_summary AS
SELECT Mode_of_Shipment, 
       AVG(Cost_of_the_Product) AS avg_cost,
       AVG(Customer_rating) AS avg_rating
FROM shipping_data
GROUP BY Mode_of_Shipment;
SELECT * FROM shipment_summary;

CREATE INDEX indx_mode_rating 
ON shipping_data (Mode_of_Shipment, Customer_rating);

SHOW INDEXES FROM shipping_data;





