-- Create the original table
CREATE TEMPORARY TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Insert sample data
INSERT INTO ProductDetail VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Transform to 1NF
SELECT 
    OrderID,
    CustomerName,
    TRIM(product.value) AS Product
FROM ProductDetail,
JSON_TABLE(
    CONCAT('["', REPLACE(Products, ',', '","'), '"]'),
    '$[*]' COLUMNS (value VARCHAR(100) PATH '$')
) AS product;



/*QUES 2
Remove partial dependencies by decomposing into two tables:

1. Orders Table (OrderID, CustomerName)*/
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

/*2. OrderItems Table (OrderID, Product, Quantity)*/
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);


