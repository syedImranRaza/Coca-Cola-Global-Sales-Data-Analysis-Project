
CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    size VARCHAR(20),
    flavour VARCHAR(50)
);

CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_type VARCHAR(50),  -- e.g., retail, wholesale
    country VARCHAR(100),
    city VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Region (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL,
    country VARCHAR(100),
    continent VARCHAR(100)
);

CREATE TABLE Distributor (
    distributor_id SERIAL PRIMARY KEY,
    distributor_name VARCHAR(100) NOT NULL,
    region_id INT,
    contact_info VARCHAR(100),
    address VARCHAR(255),
    FOREIGN KEY (region_id) REFERENCES Region(region_id)
);

CREATE TABLE Salesperson (
    salesperson_id SERIAL PRIMARY KEY,
    salesperson_name VARCHAR(100) NOT NULL,
    region_id INT,
    email VARCHAR(100),
    phone VARCHAR(20),
    FOREIGN KEY (region_id) REFERENCES Region(region_id)
);

CREATE TABLE Sales (
    sales_id SERIAL PRIMARY KEY,
    product_id INT,
    customer_id INT,
    quantity INT NOT NULL,
    total_revenue DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    region_id INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (region_id) REFERENCES Region(region_id)
);



INSERT INTO Product (product_name, category, price, size, flavour)
VALUES 
    ('Coca-Cola Classic', 'Soft Drink', 1.50, '500ml', 'Original'),
    ('Coca-Cola Zero', 'Soft Drink', 1.70, '500ml', 'Zero Sugar'),
    ('Diet Coke', 'Soft Drink', 1.60, '500ml', 'Diet'),
    ('Coca-Cola Vanilla', 'Soft Drink', 1.80, '500ml', 'Vanilla'),
    ('Coca-Cola Cherry', 'Soft Drink', 1.80, '500ml', 'Cherry');

    INSERT INTO Customer (customer_name, customer_type, country, city, email)
VALUES 
    ('John Doe', 'Retail', 'USA', 'New York', 'john.doe@example.com'),
    ('Alice Smith', 'Wholesale', 'UK', 'London', 'alice.smith@example.co.uk'),
    ('David Brown', 'Retail', 'Australia', 'Sydney', 'david.brown@example.com'),
    ('Jane Doe', 'Wholesale', 'Canada', 'Toronto', 'jane.doe@example.ca'),
    ('Michael Green', 'Retail', 'Germany', 'Berlin', 'michael.green@example.de');


    INSERT INTO Region (region_name, country, continent)
VALUES 
    ('North America', 'USA', 'North America'),
    ('Europe West', 'UK', 'Europe'),
    ('Australia', 'Australia', 'Oceania'),
    ('Canada', 'Canada', 'North America'),
    ('Europe Central', 'Germany', 'Europe');


    INSERT INTO Distributor (distributor_name, region_id, contact_info, address)
VALUES 
    ('Coca-Cola North America', 1, 'info@coke-northamerica.com', '123 Coca St, NY, USA'),
    ('Coca-Cola UK', 2, 'info@coke-uk.com', '456 Coca Rd, London, UK'),
    ('Coca-Cola Australia', 3, 'info@coke-australia.com', '789 Coca Ave, Sydney, Australia'),
    ('Coca-Cola Canada', 4, 'info@coke-canada.com', '101 Coca Dr, Toronto, Canada'),
    ('Coca-Cola Germany', 5, 'info@coke-germany.com', '111 Coca Str, Berlin, Germany');



    INSERT INTO Salesperson (salesperson_name, region_id, email, phone)
VALUES 
    ('Emily White', 1, 'emily.white@coke-northamerica.com', '123-456-7890'),
    ('James Black', 2, 'james.black@coke-uk.com', '223-456-7890'),
    ('Olivia Blue', 3, 'olivia.blue@coke-australia.com', '323-456-7890'),
    ('Liam Grey', 4, 'liam.grey@coke-canada.com', '423-456-7890'),
    ('Sophia Brown', 5, 'sophia.brown@coke-germany.com', '523-456-7890');


    DO $$
DECLARE 
    i INT;
    random_product_id INT;
    random_customer_id INT;
    random_region_id INT;
    random_quantity INT;
    random_revenue DECIMAL(10,2);
    random_date DATE;
BEGIN
    FOR i IN 1..10000 LOOP
        -- Generate random data for each sale
        random_product_id := FLOOR(1 + (RANDOM() * 4));
        random_customer_id := FLOOR(1 + (RANDOM() * 4));
        random_region_id := FLOOR(1 + (RANDOM() * 4));
        random_quantity := FLOOR(1 + (RANDOM() * 100));
        random_revenue := random_quantity * (FLOOR(100 + RANDOM() * 200) / 100.0);  -- Random revenue
        random_date := DATE '2023-01-01' + (RANDOM() * 365)::INT;  -- Random date in 2023

        -- Insert the generated data into the Sales table
        INSERT INTO Sales (product_id, customer_id, quantity, total_revenue, date, region_id)
        VALUES (random_product_id, random_customer_id, random_quantity, random_revenue, random_date, random_region_id);
    END LOOP;
END $$;




