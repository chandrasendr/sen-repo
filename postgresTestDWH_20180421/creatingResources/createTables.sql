-- Creating Sales OLTP cube in postgreSQL (Link Followed: https://www.codeproject.com/Articles/652108/Create-First-Data-WareHouse) 


-- Create Customer dimension table in Data Warehouse which will hold customer personal details.
DROP TABLE IF EXISTS test_dwh_20180421.DimCustomer;
Create table test_dwh_20180421.DimCustomer
(
CustomerID serial primary key,
CustomerAltID varchar(10) not null,
CustomerName varchar(50),
Gender varchar(20)
);

-- Fill the Customer dimension with sample Values
Insert into test_dwh_20180421.DimCustomer(CustomerAltID,CustomerName,Gender)values
('IMI-001','Henry Ford','M'),
('IMI-002','Bill Gates','M'),
('IMI-003','Muskan Shaikh','F'),
('IMI-004','Richard Thrubin','M'),
('IMI-005','Emma Wattson','F');

-- Create basic level of Product Dimension table without considering any Category or Subcategory
Create table test_dwh_20180421.DimProduct
(
ProductKey serial primary key,
ProductAltKey varchar(10)not null,
ProductName varchar(100),
ProductActualCost money,
ProductSalesCost money
);

-- Fill the Product dimension with sample Values
Insert into test_dwh_20180421.DimProduct(ProductAltKey,ProductName, ProductActualCost, ProductSalesCost)values
('ITM-001','Wheat Floor 1kg',5.50,6.50),
('ITM-002','Rice Grains 1kg',22.50,24),
('ITM-003','SunFlower Oil 1 ltr',42,43.5),
('ITM-004','Nirma Soap',18,20),
('ITM-005','Arial Washing Powder 1kg',135,139);

-- Create Store Dimension table which will hold details related stores available across various places.
Create table test_dwh_20180421.DimStores
(
StoreID serial primary key,
StoreAltID varchar(10)not null,
StoreName varchar(100),
StoreLocation varchar(100),
City varchar(100),
State varchar(100),
Country varchar(100)
);

-- Fill the Store Dimension with sample Values
Insert into test_dwh_20180421.DimStores(StoreAltID,StoreName,StoreLocation,City,State,Country )values
('LOC-A1','X-Mart','S.P. RingRoad','Ahmedabad','Guj','India'),
('LOC-A2','X-Mart','Maninagar','Ahmedabad','Guj','India'),
('LOC-A3','X-Mart','Sivranjani','Ahmedabad','Guj','India');

-- Create Dimension Sales Person table which will hold details related stores available across various places.
Create table test_dwh_20180421.DimSalesPerson
(
SalesPersonID serial primary key,
SalesPersonAltID varchar(10)not null,
SalesPersonName varchar(100),
StoreID int,
City varchar(100),
State varchar(100),
Country varchar(100)
);

-- Fill the Dimension Sales Person with sample values:
Insert into test_dwh_20180421.DimSalesPerson(SalesPersonAltID,SalesPersonName,StoreID,City,State,Country )values
('SP-DMSPR1','Ashish',1,'Ahmedabad','Guj','India'),
('SP-DMSPR2','Ketan',1,'Ahmedabad','Guj','India'),
('SP-DMNGR1','Srinivas',2,'Ahmedabad','Guj','India'),
('SP-DMNGR2','Saad',2,'Ahmedabad','Guj','India'),
('SP-DMSVR1','Jasmin',3,'Ahmedabad','Guj','India'),
('SP-DMSVR2','Jacob',3,'Ahmedabad','Guj','India');

-- Create Table for Date Dimension
DROP TABLE IF EXISTS test_dwh_20180421.DimDate;
CREATE TABLE test_dwh_20180421.DimDate AS
SELECT 	TO_CHAR(datum,'yyyymmdd')::INT AS "DateKey",
		TO_CHAR(datum,'DD/MM/YYYY') as "FullDateUK",
		TO_CHAR(datum,'MM/DD/YYYY') as "FullDateUSA",
       	EXTRACT(DAY FROM datum) AS "DayOfMonth",
       	TO_CHAR(datum,'Day') AS "DayName",
		date_part('isodow', datum) AS "DayOfWeekUSA",
		CASE
			WHEN date_part('isodow', datum) = 1 THEN 7
			WHEN date_part('isodow', datum) = 2 THEN 1
			WHEN date_part('isodow', datum) = 3 THEN 2
			WHEN date_part('isodow', datum) = 4 THEN 3
			WHEN date_part('isodow', datum) = 5 THEN 4
			WHEN date_part('isodow', datum) = 6 THEN 5
			WHEN date_part('isodow', datum) = 7 THEN 6
			END 
			AS "DayOfWeekUK",
       	datum - DATE_TRUNC('quarter',datum)::DATE +1 AS "DayOfQuarter",
       	TO_CHAR(datum,'W')::INT AS "WeekOfMonth",
		-- WeekOfQuarter,
       	TO_CHAR(datum,'Month') AS "MonthName",
       	EXTRACT(MONTH FROM datum) AS "MONTH",
       	EXTRACT(quarter FROM datum) AS "Quarter",
       	EXTRACT(isoyear FROM datum) AS "YEAR",
       	TO_CHAR(datum,'mmyyyy') AS "MonthYear",
		-- IsHolidayUK,
		-- HolidayUK,
		-- IsHolidayUSA,
		-- HolidayUSA,
		
	   -- Extra columns  
       datum AS date_actual,
       EXTRACT(epoch FROM datum) AS epoch,
       TO_CHAR(datum,'fmDDth') AS day_suffix,
       EXTRACT(isodow FROM datum) AS day_of_week,
       EXTRACT(doy FROM datum) AS day_of_year,
       EXTRACT(week FROM datum) AS week_of_year,
       TO_CHAR(datum,'YYYY"-W"IW-') || EXTRACT(isodow FROM datum) AS week_of_year_iso,
       TO_CHAR(datum,'Mon') AS month_name_abbreviated,
       CASE
         WHEN EXTRACT(quarter FROM datum) = 1 THEN 'First'
         WHEN EXTRACT(quarter FROM datum) = 2 THEN 'Second'
         WHEN EXTRACT(quarter FROM datum) = 3 THEN 'Third'
         WHEN EXTRACT(quarter FROM datum) = 4 THEN 'Fourth'
       END AS quarter_name,
       datum +(1 -EXTRACT(isodow FROM datum))::INT AS first_day_of_week,
       datum +(7 -EXTRACT(isodow FROM datum))::INT AS last_day_of_week,
       datum +(1 -EXTRACT(DAY FROM datum))::INT AS first_day_of_month,
       (DATE_TRUNC('MONTH',datum) +INTERVAL '1 MONTH - 1 day')::DATE AS last_day_of_month,
       DATE_TRUNC('quarter',datum)::DATE AS first_day_of_quarter,
       (DATE_TRUNC('quarter',datum) +INTERVAL '3 MONTH - 1 day')::DATE AS last_day_of_quarter,
       TO_DATE(EXTRACT(isoyear FROM datum) || '-01-01','YYYY-MM-DD') AS first_day_of_year,
       TO_DATE(EXTRACT(isoyear FROM datum) || '-12-31','YYYY-MM-DD') AS last_day_of_year,
       TO_CHAR(datum,'mmddyyyy') AS mmddyyyy,
       CASE
         WHEN EXTRACT(isodow FROM datum) IN (6,7) THEN TRUE
         ELSE FALSE
       END AS weekend_indr
FROM (SELECT '1970/01/01'::DATE+ SEQUENCE.DAY AS datum
      FROM GENERATE_SERIES (0,29219) AS SEQUENCE (DAY)
      GROUP BY SEQUENCE.DAY) DQ
ORDER BY 1;

ALTER TABLE test_dwh_20180421.DimDate ADD CONSTRAINT DimDate_date_dim_id_pk PRIMARY KEY ("DateKey");

CREATE INDEX d_date_date_actual_idx ON test_dwh_20180421.DimDate(date_actual);

-- Create Table for Time Dimension
DROP TABLE IF EXISTS test_dwh_20180421.DimTime;
CREATE TABLE test_dwh_20180421.DimTime AS

SELECT  cast(to_char(minute, 'hh24mi') as numeric) "TimeKey",
		to_char(minute, 'hh24:mi') AS time_value,
		-- Hour of the day (0 - 23)
		to_char(minute, 'hh24') AS hour_24, 
		-- Hour of the day (0 - 11)
		to_char(minute, 'hh12') hour_12,
		-- Hour minute (0 - 59)
		to_char(minute, 'mi') hour_minutes,
		-- Minute of the day (0 - 1439)
		extract(hour FROM minute)*60 + extract(minute FROM minute) day_minutes,
		-- Names of day periods
		case when to_char(minute, 'hh24:mi') BETWEEN '06:00' AND '08:29'
		then 'Morning'
		when to_char(minute, 'hh24:mi') BETWEEN '08:30' AND '11:59'
		then 'AM'
		when to_char(minute, 'hh24:mi') BETWEEN '12:00' AND '17:59'
		then 'PM'
		when to_char(minute, 'hh24:mi') BETWEEN '18:00' AND '22:29'
		then 'Evening'
		else 'Night'
		end AS day_time_name,
		-- Indicator of day or night
		case when to_char(minute, 'hh24:mi') BETWEEN '07:00' AND '19:59' then 'Day'
		else 'Night'
		end AS day_night
FROM (SELECT '0:00'::time + (sequence.minute || ' minutes')::interval AS minute 
FROM generate_series(0,1439) AS sequence(minute)
GROUP BY sequence.minute
) DQ
ORDER BY 1

ALTER TABLE test_dwh_20180421.DimTime ADD CONSTRAINT DimTime_Time_dim_id_pk PRIMARY KEY ("TimeKey");

-- Create Table FactProductSales
DROP TABLE IF EXISTS test_dwh_20180421.FactProductSales;
Create Table test_dwh_20180421.FactProductSales
(
TransactionId bigserial primary key,
SalesInvoiceNumber int not null,
SalesDateKey int,
-- SalesTimeKey int,
-- SalesTimeAltKey int,
StoreID int not null,
CustomerID int not null,
ProductID int not null,
SalesPersonID int not null,
Quantity float,
SalesTotalCost money,
ProductActualCost money,
Deviation float
);

-- Add relation between fact table foreign keys to Primary keys of Dimensions
AlTER TABLE test_dwh_20180421.FactProductSales ADD CONSTRAINT
FK_StoreID FOREIGN KEY (StoreID) REFERENCES test_dwh_20180421.DimStores(StoreID);

AlTER TABLE test_dwh_20180421.FactProductSales ADD CONSTRAINT
FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES test_dwh_20180421.Dimcustomer(CustomerID);

AlTER TABLE test_dwh_20180421.FactProductSales ADD CONSTRAINT
FK_ProductKey FOREIGN KEY (ProductID) REFERENCES test_dwh_20180421.Dimproduct(ProductKey);

AlTER TABLE test_dwh_20180421.FactProductSales ADD CONSTRAINT
FK_SalesPersonID FOREIGN KEY (SalesPersonID) REFERENCES test_dwh_20180421.Dimsalesperson(SalesPersonID);

AlTER TABLE test_dwh_20180421.FactProductSales ADD CONSTRAINT
FK_SalesDateKey FOREIGN KEY (SalesDateKey) REFERENCES test_dwh_20180421.DimDate("DateKey");

-- AlTER TABLE test_dwh_20180421.FactProductSales ADD CONSTRAINT
-- FK_SalesTimeKey FOREIGN KEY (SalesTimeKey) REFERENCES test_dwh_20180421.DimTime("TimeKey");

-- Populating fact table 
Insert into test_dwh_20180421.FactProductSales(SalesInvoiceNumber,SalesDateKey
,StoreID,CustomerID,ProductID ,
SalesPersonID,Quantity,ProductActualCost,SalesTotalCost,Deviation)

values
--1-jan-2013
--SalesInvoiceNumber,SalesDateKey,SalesTimeKey,SalesTimeAltKey,_
-- StoreID,CustomerID,ProductID ,SalesPersonID,Quantity,
-- ProductActualCost,SalesTotalCost,Deviation)
(1,20130101,1,1,1,1,2,11,13,2),
(1,20130101,1,1,2,1,1,22.50,24,1.5),
(1,20130101,1,1,3,1,1,42,43.5,1.5),

(2,20130101,1,2,3,1,1,42,43.5,1.5),
(2,20130101,1,2,4,1,3,54,60,6),

(3,20130101,1,3,2,2,2,11,13,2),
(3,20130101,1,3,3,2,1,42,43.5,1.5),
(3,20130101,1,3,4,2,3,54,60,6),
(3,20130101,1,3,5,2,1,135,139,4),
--2-jan-2013
--SalesInvoiceNumber,SalesDateKey,SalesTimeKey,SalesTimeAltKey,_
-- StoreID,CustomerID,ProductID ,SalesPersonID,Quantity,ProductActualCost,SalesTotalCost,Deviation)
(4,20130102,1,1,1,1,2,11,13,2),
(4,20130102,1,1,2,1,1,22.50,24,1.5),

(5,20130102,1,2,3,1,1,42,43.5,1.5),
(5,20130102,1,2,4,1,3,54,60,6),

(6,20130102,1,3,2,2,2,11,13,2),
(6,20130102,1,3,5,2,1,135,139,4),

(7,20130102,2,1,4,3,3,54,60,6),
(7,20130102,2,1,5,3,1,135,139,4),

--3-jan-2013
--SalesInvoiceNumber,SalesDateKey,SalesTimeKey,SalesTimeAltKey,StoreID,_
-- CustomerID,ProductID ,SalesPersonID,Quantity,ProductActualCost,SalesTotalCost,Deviation)
(8,20130103,1,1,3,1,2,84,87,3),
(8,20130103,1,1,4,1,3,54,60,3),


(9,20130103,1,2,1,1,1,5.5,6.5,1),
(9,20130103,1,2,2,1,1,22.50,24,1.5),

(10,20130103,1,3,1,2,2,11,13,2),
(10,20130103,1,3,4,2,3,54,60,6),

(11,20130103,2,1,2,3,1,5.5,6.5,1),
(11,20130103,2,1,3,3,1,42,43.5,1.5);
