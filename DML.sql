-- Insert data into the Customers table
INSERT INTO CUSTOMERS VALUES (
    1, 'John', 'Doe', 'johndoe@example.com', '1234567890', '123 Main St'
);

INSERT INTO CUSTOMERS VALUES (
    2, 'Jane', 'Smith', 'janesmith@example.com', '9876543210', '456 Elm St'
);

INSERT INTO CUSTOMERS VALUES (
    3, 'David', 'Johnson', 'davidjohnson@example.com', '4567890123', '789 Oak Ave'
);

INSERT INTO CUSTOMERS VALUES (
    4, 'Sarah', 'Williams', 'sarahwilliams@example.com', '0123456789', '987 Pine Rd'
);

INSERT INTO CUSTOMERS VALUES (
    5, 'Michael', 'Brown', 'michaelbrown@example.com', '5432109876', '654 Cedar Ln'
);

INSERT INTO CUSTOMERS VALUES (
    6, 'Emily', 'Taylor', 'emilytaylor@example.com', '1029384756', '321 Birch Dr'
);

INSERT INTO CUSTOMERS VALUES (
    7, 'Daniel', 'Anderson', 'danielanderson@example.com', '5678901234', '876 Maple Ave'
);

INSERT INTO CUSTOMERS VALUES (
    8, 'Olivia', 'Martinez', 'oliviamartinez@example.com', '4321098765', '219 Oak St'
);

INSERT INTO CUSTOMERS VALUES (
    9, 'James', 'Lopez', 'jameslopez@example.com', '6789012345', '543 Pine Ave'
);

INSERT INTO CUSTOMERS VALUES (
    10, 'Sophia', 'Gonzalez', 'sophiagonzalez@example.com', '9012345678', '987 Elm Ln'
);

INSERT INTO CATEGORIES VALUES (
    1, 'Clothing'
);

INSERT INTO CATEGORIES VALUES (
    2, 'Footwear'
);

INSERT INTO CATEGORIES VALUES (
    3, 'Fitness'
);

-- Insert data into the Products table
INSERT INTO PRODUCTS VALUES (
    1, 'T-shirt', 19.99, 'A classic cotton T-shirt', 1
);

INSERT INTO PRODUCTS VALUES (
    2, 'Jeans', 59.99, 'Durable denim jeans for everyday wear', 1
);

INSERT INTO PRODUCTS VALUES (
    3, 'Running Shoes', 79.99, 'Lightweight and comfortable for long runs', 2
);

INSERT INTO PRODUCTS VALUES (
    4, 'Yoga Mat', 29.99, 'Non-slip surface with a comfortable cushion', 3
);

INSERT INTO PRODUCTS VALUES (
    5, 'Resistance Bands', 14.99, 'Set of 3 resistance bands for strength training', 3
);

-- Insert data into the Orders table
INSERT INTO ORDERS VALUES (
    1, 1, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 39.98
);

INSERT INTO ORDERS VALUES (
    2, 2, TO_DATE('2023-03-02', 'YYYY-MM-DD'), 149.97
);

INSERT INTO ORDERS VALUES(
    3, 3, TO_DATE('2023-03-03', 'YYYY-MM-DD'), 44.97
);

INSERT INTO ORDERS VALUES(
    4, 4, TO_DATE('2023-03-04', 'YYYY-MM-DD'), 89.97
);

INSERT INTO ORDERS VALUES(
    5, 5, TO_DATE('2023-03-05', 'YYYY-MM-DD'), 94.97
);

INSERT INTO ORDERS VALUES(
    6, 6, TO_DATE('2023-03-06', 'YYYY-MM-DD'), 159.98
);

INSERT INTO ORDERS VALUES(
    7, 7, TO_DATE('2023-03-07', 'YYYY-MM-DD'), 49.99
);

INSERT INTO ORDERS VALUES(
    8, 8, TO_DATE('2023-03-08', 'YYYY-MM-DD'), 179.97
);

INSERT INTO ORDERS VALUES(
    9, 9, TO_DATE('2023-03-09', 'YYYY-MM-DD'), 104.96
);

INSERT INTO ORDERS VALUES(
    10, 10, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 199.98
);

-- Create a trigger to update the total_price column in the Orders table
CREATE OR REPLACE TRIGGER UPDATE_TOTAL_PRICE AFTER
    INSERT OR UPDATE OR DELETE ON ORDER_ITEMS FOR EACH ROW
DECLARE
    V_TOTAL_PRICE NUMBER;
BEGIN
 -- Calculate the total price for the order
    SELECT SUM(QUANTITY * UNIT_PRICE) INTO V_TOTAL_PRICE
    FROM ORDER_ITEMS
    WHERE ORDER_ID = :NEW.ORDER_ID;
 -- Update the total_price column in the Orders table
    UPDATE ORDERS
    SET
        TOTAL_PRICE = V_TOTAL_PRICE
    WHERE
        ORDER_ID = :NEW.ORDER_ID;
END;
/

-- Insert data into the Order_Items table
INSERT INTO ORDER_ITEMS VALUES (
    1, 1, 2, 19.99
);

INSERT INTO ORDER_ITEMS VALUES (
    2, 2, 1, 59.99
);

INSERT INTO ORDER_ITEMS VALUES (
    2, 3, 1, 79.99
);

INSERT INTO ORDER_ITEMS VALUES (
    3, 4, 1, 29.99
);

INSERT INTO ORDER_ITEMS VALUES (
    3, 5, 3, 14.99
);

INSERT INTO ORDER_ITEMS VALUES (
    4, 1, 1, 19.99
);

INSERT INTO ORDER_ITEMS VALUES (
    5, 2, 1, 59.99
);

INSERT INTO ORDER_ITEMS VALUES (
    5, 3, 1, 79.99
);

INSERT INTO ORDER_ITEMS VALUES (
    6, 4, 2, 29.99
);

INSERT INTO ORDER_ITEMS VALUES (
    6, 5, 1, 14.99
);

INSERT INTO ORDER_ITEMS VALUES (
    7, 1, 1, 19.99
);

INSERT INTO ORDER_ITEMS VALUES (
    8, 2, 1, 59.99
);

INSERT INTO ORDER_ITEMS VALUES (
    8, 3, 1, 79.99
);

INSERT INTO ORDER_ITEMS VALUES (
    8, 4, 1, 29.99
);

INSERT INTO ORDER_ITEMS VALUES (
    9, 5, 2, 14.99
);

INSERT INTO ORDER_ITEMS VALUES (
    10, 1, 3, 19.99
);

INSERT INTO ORDER_ITEMS VALUES (
    10, 2, 1, 59.99
);

INSERT INTO ORDER_ITEMS VALUES (
    10, 3, 1, 79.99
);

-- update total price in orders table
UPDATE ORDERS O
SET
    TOTAL_PRICE = (
        SELECT SUM(OI.QUANTITY * OI.UNIT_PRICE) FROM ORDER_ITEMS OI WHERE OI.ORDER_ID = O.ORDER_ID
    )
WHERE
    O.ORDER_ID IN (
        SELECT ORDER_ID FROM ORDER_ITEMS
    );

SELECT *
FROM CUSTOMERS;

SELECT *
FROM CATEGORIES;

SELECT *
FROM PRODUCTS;

SELECT *
FROM ORDERS;

SELECT *
FROM ORDER_ITEMS;

-- UPDATE
UPDATE CUSTOMERS
SET
    EMAIL ='johndoe@gmail.com'
WHERE
    CUSTOMER_ID=1;

SELECT *
FROM CUSTOMERS
WHERE CUSTOMER_ID=1;

-- INSERT
INSERT INTO CUSTOMERS VALUES (
    11, 'Jobair', 'Nahian', 'jobairnahian2017@gmail.com', '01876023389', 'fulbari gate, khulna'
);

-- DELETE
DELETE FROM CUSTOMERS
WHERE
    CUSTOMER_ID = 11;

--Distict data. selects name who have ordered items
SELECT DISTINCT(FIRST_NAME)
FROM CUSTOMERS C, ORDERS O, ORDER_ITEMS OI
WHERE C.CUSTOMER_ID = O.CUSTOMER_ID
    AND O.ORDER_ID = OI.ORDER_ID;

-- Comparison search
SELECT PRODUCT_NAME, PRICE
FROM PRODUCTS
WHERE PRICE > 20
    AND PRICE < 75;

-- Range search
SELECT PRODUCT_NAME, PRICE
FROM PRODUCTS
WHERE PRICE BETWEEN 10
    AND 60;

--set membership
SELECT PRODUCT_NAME, PRICE
FROM PRODUCTS
WHERE PRICE IN (19.99, 29.99);

-- string matching
SELECT FIRST_NAME, LAST_NAME
FROM CUSTOMERS
WHERE EMAIL LIKE '%gmail%';

-- ordering descending
SELECT ORDER_ID, ORDER_DATE
FROM ORDERS
ORDER BY ORDER_DATE DESC;

-- with clause
--finding the detais about the maximum price product
WITH MAX_PRICE(VAL) AS (
    SELECT MAX(PRICE)
    FROM PRODUCTS
)
SELECT *
FROM PRODUCTS, MAX_PRICE
WHERE PRODUCTS.PRICE=MAX_PRICE.VAL;

--- aggregate functions ---

-- how many orders placed in a date.
SELECT COUNT(*) AS ORDER_COUNT
FROM ORDERS
WHERE ORDER_DATE = TO_DATE('2023-03-02', 'YYYY-MM-DD');

-- finding secnd maximum price
SELECT MAX(PRICE)
FROM PRODUCTS
WHERE PRICE < (
        SELECT MAX(PRICE)
        FROM PRODUCTS
    );

-- minimum price of prouducts
SELECT MIN(PRICE)
FROM PRODUCTS;

--- with group by ---

-- finding the total price of orderd items of every customer
SELECT SUM(UNIT_PRICE * QUANTITY) AS TOTAL_PRICE
FROM ORDER_ITEMS
GROUP BY ORDER_ID;

-- finding the average price ordered by a customer
SELECT AVG(UNIT_PRICE * QUANTITY)
FROM ORDER_ITEMS
GROUP BY ORDER_ID;

-- having , finding the category of products with avg price > 30
SELECT CATEGORY_ID, AVG(PRICE)
FROM PRODUCTS
GROUP BY CATEGORY_ID
HAVING AVG(PRICE)> 30;

---- union intersect and except ----

-- finding the customers with email 'gmail' and last name has char 'o'
SELECT FIRST_NAME
FROM CUSTOMERS
WHERE EMAIL LIKE '%gmail%' UNION
    SELECT FIRST_NAME
    FROM CUSTOMERS
    WHERE LAST_NAME LIKE '%o%';

--finding the customer who have on orders
SELECT CUSTOMER_ID
FROM CUSTOMERS INTERSECT
    SELECT CUSTOMER_ID
    FROM ORDERS;

--finding the products without the maximum priced product
SELECT PRODUCT_ID
FROM PRODUCTS EXCEPT
    SELECT PRODUCT_ID
    FROM PRODUCTS
    WHERE PRICE=(
            SELECT MAX(PRICE)
            FROM PRODUCTS
        );

--Nested Query,finding one product bought by a customer
SELECT PRODUCT_NAME
FROM PRODUCTS
WHERE PRODUCT_ID= (
        SELECT PRODUCT_ID
        FROM ORDER_ITEMS
        WHERE ORDER_ID=(
                SELECT ORDER_ID
                FROM ORDERS
                WHERE CUSTOMER_ID=1
            )
    );

-- set membership AND/OR/NOT
SELECT *
FROM PRODUCTS
WHERE PRODUCT_NAME LIKE '%e%'
    AND CATEGORY_ID NOT IN (
        SELECT CATEGORY_ID
        FROM CATEGORIES
        WHERE CATEGORY_NAME LIKE '%oo%'
    );

--some/all/exists
SELECT PRODUCT_NAME
FROM PRODUCTS
WHERE PRICE > SOME (
        SELECT PRICE
        FROM PRODUCTS
        WHERE PRICE> 50
    );

SELECT PRODUCT_NAME
FROM PRODUCTS
WHERE PRICE > ALL (
        SELECT PRICE
        FROM PRODUCTS
        WHERE PRICE> 50
    );

SELECT *
FROM CUSTOMERS
WHERE FIRST_NAME LIKE '%e%'
    AND EXISTS(
        SELECT *
        FROM PRODUCTS
        WHERE PRICE > 20
    );

----  string operation ----
SELECT LAST_NAME
FROM CUSTOMERS
WHERE LAST_NAME LIKE '___';

--- Join ---

--natural join
SELECT PRODUCT_NAME, CATEGORY_NAME
FROM PRODUCTS
    NATURAL JOIN CATEGORIES;

-- selecting category name which price are >20
SELECT PRODUCT_NAME, CATEGORY_NAME
FROM PRODUCTS P
    JOIN CATEGORIES C USING (CATEGORY_ID)
WHERE P.PRICE>20;

--self join ,-- find the order id who has at least two products
SELECT O1.ORDER_ID
FROM ORDER_ITEMS O1, ORDER_ITEMS O2
WHERE (O1.ORDER_ID = O2.ORDER_ID
    AND O1.PRODUCT_ID <> O2.PRODUCT_ID);

-- finding the products bought by a customer.
SELECT PRODUCT_NAME
FROM PRODUCTS P
    JOIN ORDER_ITEMS OI ON P.PRODUCT_ID = OI.PRODUCT_ID JOIN ORDERS O ON OI.ORDER_ID = O.ORDER_ID
WHERE O.CUSTOMER_ID=2;

-- left outer join
SELECT PRODUCT_ID, PRODUCT_NAME, CATEGORY_NAME
FROM PRODUCTS
    LEFT OUTER JOIN CATEGORIES USING(CATEGORY_ID);

-- right outer join
SELECT FIRST_NAME, LAST_NAME, ORDER_ID
FROM CUSTOMERS
    RIGHT OUTER JOIN ORDERS USING(CUSTOMER_ID);

--- view ---
CREATE VIEW PRODUCT_CATEGORY AS
    SELECT PRODUCT_NAME
    FROM PRODUCTS
    WHERE CATEGORY_ID = (
            SELECT CATEGORY_ID
            FROM CATEGORIES
            WHERE CATEGORY_NAME = 'Fitness'
        );

SELECT *
FROM PRODUCT_CATEGORY;

CREATE VIEW CUSTOM AS
    SELECT *
    FROM PRODUCT_CATEGORY
    WHERE PRODUCT_NAME LIKE '%ga%';

SELECT *
FROM CUSTOM;