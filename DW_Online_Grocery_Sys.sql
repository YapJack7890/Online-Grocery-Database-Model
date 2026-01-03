--CREATE DATABASE DWGROCER;

--CONNECT TO DWGROCER;


-- Drop Tables to Reset --
--DROP TABLE SUPPLIER;
--DROP TABLE PRODUCT;
--DROP TABLE PROMOTION;
--DROP TABLE DELIVERY;
--DROP TABLE CUSTOMER;
--DROP TABLE TIME_DIMENSION;
--DROP TABLE PAYMENT;
--DROP TABLE SALES;


-- Table Creation --
CREATE TABLE SUPPLIER
(
	SUPPLIER_ID INTEGER NOT NULL PRIMARY KEY,
	SUPP_NAME VARCHAR(50) NOT NULL,
	SUPP_EMAIL VARCHAR(50) NOT NULL,
	SUPP_PHONENUMBER VARCHAR(15) NOT NULL,
	SUPP_COUNTRY VARCHAR(50) NOT NULL
);

CREATE TABLE PRODUCT
(
	PRODUCT_ID INTEGER NOT NULL PRIMARY KEY,
	PROD_NAME VARCHAR(50) NOT NULL,
	PROD_CATEGORY VARCHAR(50) NOT NULL,
	PROD_UNIT_PRICE DECIMAL(6,2) NOT NULL, -- max is 9,999.99
	PROD_AVAILABLE_STOCK INTEGER NOT NULL,
	SUPPLIER_ID INTEGER NOT NULL,
	FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER
);

CREATE TABLE PROMOTION
(
	PROMOTION_ID INTEGER NOT NULL PRIMARY KEY,
	PROMO_NAME VARCHAR(50) NOT NULL,
	PROMO_START_DATE DATE NOT NULL,
	PROMO_END_DATE DATE NOT NULL,
	PROMO_TYPE VARCHAR(50) NOT NULL,
	PROMO_VALUE DECIMAL(6,2) NOT NULL, -- max is 9,999.99
	PROMO_MINIMUM_PURCHASE DECIMAL(6,2) NOT NULL -- max is 9,999.99
);

CREATE TABLE DELIVERY
(
	DELIVERY_ID INTEGER NOT NULL PRIMARY KEY,
	DELIV_DATE DATE NOT NULL,
	DELIV_STATE VARCHAR(50) NOT NULL,
	DELIV_CITY VARCHAR(50) NOT NULL,
	DELIV_STREET VARCHAR(50) NOT NULL,
	DELIV_POSTCODE VARCHAR(10) NOT NULL,
	DELIV_METHOD VARCHAR(20) NOT NULL CHECK (DELIV_METHOD IN ('Home Delivery','Express Delivery')),
	DELIV_STATUS VARCHAR(19) NOT NULL CHECK (DELIV_STATUS IN ('Delivered','Partially Delivered','Cancelled'))
);

CREATE TABLE CUSTOMER
(
	CUSTOMER_ID INTEGER NOT NULL PRIMARY KEY,
	CUST_NAME VARCHAR(50) NOT NULL,
	CUST_AGE SMALLINT NOT NULL CHECK (CUST_AGE BETWEEN 0 AND 100),
	CUST_EMAIL VARCHAR(50) NOT NULL,
	CUST_PHONENUMBER VARCHAR(15),
	CUST_ADDRESS VARCHAR(100),
	CUST_REGISTRATION_DATE DATE NOT NULL,
	CUST_LOYALTY_TIER INTEGER NOT NULL CHECK (CUST_LOYALTY_TIER BETWEEN 1 AND 3)
);

CREATE TABLE TIME_DIMENSION
(
	TIME_ID INTEGER NOT NULL PRIMARY KEY,
	TIME_YEAR INTEGER NOT NULL,
	TIME_QUARTER INTEGER NOT NULL CHECK (TIME_QUARTER BETWEEN 1 AND 4),
	TIME_MONTH INTEGER NOT NULL CHECK (TIME_MONTH BETWEEN 1 AND 12),
	TIME_DAY INTEGER NOT NULL CHECK (TIME_DAY BETWEEN 1 AND 31),
	TIME_SEASON VARCHAR(6) NOT NULL CHECK (TIME_SEASON IN ('Spring','Summer','Autumn','Winter'))
);

CREATE TABLE PAYMENT
(
	PAYMENT_ID INTEGER NOT NULL PRIMARY KEY,
	PAY_METHOD VARCHAR(14) NOT NULL CHECK (PAY_METHOD IN ('Credit','Debit','Bank','Digital Wallet')),
	PAY_AMOUNT DECIMAL(9,2) NOT NULL, -- max is 9,999,999.99
	PAY_STATUS VARCHAR(9) NOT NULL CHECK (PAY_STATUS IN ('Completed','Cancelled')),
	PAY_DATE DATE NOT NULL
);

CREATE TABLE SALES
(
	PRODUCT_ID INTEGER NOT NULL,
	CUSTOMER_ID INTEGER NOT NULL,
	TIME_ID INTEGER NOT NULL,
	DELIVERY_ID INTEGER NOT NULL,
	PROMOTION_ID INTEGER NOT NULL,
	PAYMENT_ID INTEGER NOT NULL,
	UNIT_PRICE DECIMAL(6,2) NOT NULL, -- max is 9,999.99
	UNIT_ORDERED INTEGER NOT NULL,
	TOTAL_PRICE DECIMAL(9,2) NOT NULL, -- max is 9,999,999.99
	TOTAL_DISCOUNT DECIMAL(9,2) NOT NULL, -- max is 9,999,999.99
	TOTAL_NET_PRICE DECIMAL(9,2) NOT NULL, -- max is 9,999,999.99
	TOTAL_REVENUE DECIMAL(9,2) NOT NULL, -- max is 9,999,999.99
	PRIMARY KEY (PRODUCT_ID, CUSTOMER_ID, TIME_ID, DELIVERY_ID, PROMOTION_ID, PAYMENT_ID),
	FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT,
	FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER,
	FOREIGN KEY (TIME_ID) REFERENCES TIME_DIMENSION,
	FOREIGN KEY (DELIVERY_ID) REFERENCES DELIVERY,
	FOREIGN KEY (PROMOTION_ID) REFERENCES PROMOTION,
	FOREIGN KEY (PAYMENT_ID) REFERENCES PAYMENT
);


-- Data Insertion --
INSERT INTO SUPPLIER VALUES
(1,'Company A','aaa@gmail.com','111-111 1111','Malaysia'),
(2,'Company B','bbb@gmail.com','222-222 2222','Singapore'),
(3,'Company C','ccc@gmail.com','333-333 3333','United States'),
(4,'Company D','ddd@gmail.com','222-444 4444','Singapore'),
(5,'Company E','eee@gmail.com','222-555 5555','Singapore'),
(6,'Company F','fff@gmail.com','111-666 6666','Malaysia'),
(7,'Company G','ggg@gmail.com','333-777 7777','United States'),
(8,'Company H','hhh@gmail.com','333-888 8888','United States'),
(9,'Company I','iii@gmail.com','111-999 9999','Malaysia'),
(10,'Company J','jjj@gmail.com','111-000 0000','Malaysia');

INSERT INTO PRODUCT VALUES
(1,'Product A','Category A',25.75,57,10),
(2,'Product B','Category C',14.89,48,1),
(3,'Product C','Category C',11.65,60,5),
(4,'Product D','Category B',26.16,51,2),
(5,'Product E','Category C',26.98,94,6),
(6,'Product F','Category A',12.18,58,4),
(7,'Product G','Category A',29.48,40,6),
(8,'Product H','Category C',26.39,22,8),
(9,'Product I','Category C',14.39,17,10),
(10,'Product J','Category B',11.36,69,5);

INSERT INTO PROMOTION VALUES
(1,'Promotion A','2023-02-09','2023-04-10','Type A',45.50,50.00),
(2,'Promotion F','2023-02-20','2023-03-14','Type D',25.00,20.50),
(3,'Promotion B','2023-04-27','2023-06-14','Type B',50.00,45.50),
(4,'Promotion D','2024-01-02','2024-02-16','Type D',50.00,45.00),
(5,'Promotion C','2024-01-22','2024-03-02','Type C',25.50,20.00),
(6,'Promotion E','2024-06-02','2024-06-29','Type C',30.50,35.50),
(7,'Promotion H','2024-07-01','2024-08-31','Type C',40.50,30.50),
(8,'Promotion G','2024-08-17','2024-08-27','Type A',25.50,15.00),
(9,'Promotion I','2024-09-15','2024-10-07','Type B',30.00,20.00),
(10,'Promotion J','2024-10-15','2024-11-12','Type D',20.50,15.00);

INSERT INTO DELIVERY VALUES
(1,'2023-02-24','State D','City D2','Street D21','4002','Home Delivery','Partially Delivered'),
(2,'2023-03-02','State D','City D2','Street D21','4002','Home Delivery','Delivered'),
(3,'2023-05-01','State A','City A2','Street A21','1002','Home Delivery','Cancelled'),
(4,'2024-02-10','State A','City A1','Street A13','1001','Home Delivery','Delivered'),
(5,'2024-02-21','State A','City A1','Street A13','1001','Home Delivery','Delivered'),
(6,'2024-06-08','State C','City C1','Street C11','3001','Express Delivery','Cancelled'),
(7,'2024-07-03','State D','City D1','Street D12','4001','Express Delivery','Delivered'),
(8,'2024-08-09','State A','City A3','Street A33','1003','Express Delivery','Cancelled'),
(9,'2024-09-10','State B','City B1','Street B12','2001','Home Delivery','Partially Delivered'),
(10,'2024-10-22','State B','City B1','Street B11','2001','Express Delivery','Cancelled');

INSERT INTO CUSTOMER VALUES
(1,'Cus A',58,'cusA@gmail.com','011-111 1111','Home Address A','2022-01-20',1),
(2,'Cus B',45,'cusB@gmail.com','012-222 2222','Home Address B','2022-09-27',3),
(3,'Cus C',35,'cusC@gmail.com','013-333 3333','Home Address C','2022-10-20',2),
(4,'Cus D',29,'cusD@gmail.com','014-444 4444','Home Address D','2022-11-07',2),
(5,'Cus E',25,'cusE@gmail.com','015-555 5555','Home Address A','2022-12-12',3),
(6,'Cus F',48,'cusF@gmail.com','016-666 6666','Home Address B','2022-12-31',2),
(7,'Cus G',25,'cusG@gmail.com','017-777 7777','Home Address D','2023-07-14',1),
(8,'Cus H',45,'cusH@gmail.com','018-888 8888','Home Address D','2023-07-25',2),
(9,'Cus I',45,'cusI@gmail.com','019-999 9999','Home Address A','2023-10-09',2),
(10,'Cus J',46,'cusJ@gmail.com','000-000 0000','Home Address A','2023-12-22',1);

INSERT INTO TIME_DIMENSION VALUES
(1,2023,1,2,22,'Spring'), -- D21 p7 29.48*4 - 45.50 = 72.42
(2,2023,1,2,28,'Spring'), -- D21 p9 14.39*2 - 25.00 = 3.78
(3,2023,1,4,29,'Spring'), -- A21 p4 26.16*4 - 50.00 = 54.64
(4,2024,1,2,9,'Spring'), -- A13 p3 11.65*5 - 50.00 = 8.25
(5,2024,1,2,16,'Spring'), -- A13 p8 26.39*2 - 25.50 = 27.10
(6,2024,2,6,5,'Summer'), -- C11 p5 26.98*3 - 30.50 = 50.44
(7,2024,2,7,2,'Summer'), -- D12 p1 25.75*3 - 40.50 = 36.75
(8,2024,2,8,7,'Summer'), -- A33 p6 12.18*4 - 25.50 = 23.22
(9,2024,2,9,9,'Summer'), -- B12 p10 11.36*6 - 30.00 = 38.16
(10,2024,2,10,17,'Summer'); -- B11 p2 14.89*5 - 20.50 = 53.95

-- (customer home address, product id,total net price calcualtion)
-- B,A... = Cus A, Cus B p1,p2... = product_id 1, product_id 2, total_net_price = unit_price*quantity-promo_val

INSERT INTO PAYMENT VALUES
(1,'Digital Wallet',72.42,'Completed','2023-02-22'),
(2,'Debit',3.78,'Completed','2023-03-02'),
(3,'Bank',54.64,'Cancelled','2023-05-01'),
(4,'Digital Wallet',8.25,'Completed','2024-02-10'),
(5,'Digital Wallet',27.10,'Completed','2024-02-18'),
(6,'Credit',50.44,'Cancelled','2024-06-08'),
(7,'Bank',36.75,'Completed','2024-07-03'),
(8,'Bank',23.22,'Cancelled','2024-08-09'),
(9,'Digital Wallet',38.16,'Completed','2024-09-10'),
(10,'Credit',53.95,'Cancelled','2024-10-22');

-- promo, time, payment, delivery same id for convenience
INSERT INTO SALES VALUES
(7,4,1,1,1,1,29.48,4,117.92,45.50,72.42,72.42),
(9,8,2,2,2,2,14.39,2,28.78,25.00,3.78,3.78),
(4,1,3,3,3,3,26.16,4,104.64,50.00,54.64,0),
(3,5,4,4,4,4,11.65,5,58.25,50.00,8.25,8.25),
(8,9,5,5,5,5,26.39,2,52.78,25.50,27.10,27.10),
(5,3,6,6,6,6,26.98,3,80.94,30.50,50.44,0),
(1,7,7,7,7,7,25.75,3,77.25,40.50,36.75,36.75),
(6,10,8,8,8,8,12.18,4,48.72,25.50,23.22,0),
(10,2,9,9,9,9,11.36,6,68.16,30.00,38.16,38.16),
(2,6,10,10,10,10,14.89,5,74.45,20.50,53.95,0);