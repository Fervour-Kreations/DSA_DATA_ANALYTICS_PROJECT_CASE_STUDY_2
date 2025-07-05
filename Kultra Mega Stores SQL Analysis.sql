-------KULTRA MEGA STORES INVENTORY------

----Imported KMS SQL Data Table---

Select * from [KMS Sql Case Study-1]

----Imported Order Status Table----

Select * from Order_Status

---------CASE SCENARIO 1------

--1----The Product Category with the Highest Sales

Select top 1 Product_Category, sum(Sales) as Total_Sales
From [KMS Sql Case Study-1]
Group by Product_Category
Order by Total_Sales Desc

--2----The Top 3 & Bottomm 3 Regions in Terms of Sales----

--2a--The Top 3 Regions in Terms of Sales
Select top 3 Region, sum(sales) as Total_Sales_per_Region
from [KMS Sql Case Study-1]
Group by Region
Order by Total_Sales_per_Region Desc

--2b--Bottom 3 Regions in Terms of Sales----
select Top 3 Region, sum(sales) as Total_Bottom_Sales_Per_Region
from [KMS Sql Case Study-1]
Group by Region
Order by Total_Bottom_Sales_per_Region asc
 

--3---The Total Sales of Appliance In Ontario---

select Region, sum(sales) as Total_Sales_Appliances_Ontario
from [KMS Sql Case Study-1]
where Region = 'Ontario'
and product_sub_category = 'Appliances'
Group by Region


--4---Advice the Management of KMS on what to do to increase the Revenue from the bottom 10 Customers

Select * from [KMS Sql Case Study-1]

drop view Bottom_10_Sales
drop view top_10_sales

---Bottom 10 Customers per Sales
create view Bottom_10_Sales
as
select Top 10 Row_Id,Customer_Name,Discount,product_category,shipping_cost,Unit_price, sum(sales) as Bottom_10_Sales
from [KMS Sql Case Study-1]
Group by Row_Id,Customer_Name,Discount,Product_Category,Shipping_Cost,unit_price
Order by Bottom_10_Sales asc


----Top 10 Customers per Sales
create view Top_10_Sales
as
select Top 10 Row_Id,Customer_Name,Discount,Product_Category,Shipping_Cost,unit_price, sum(sales) as Top_10_Sales
from [KMS Sql Case Study-1]
Group by Row_Id,Customer_Name,Discount,Product_Category,Shipping_Cost,unit_price
Order by Top_10_Sales desc

select * from Bottom_10_Sales
select * from Top_10_Sales

----The above comparative analysis shows that customers who makes the lowest sales
--purchases mainly Office Supplies which have relatively low unit prices and further
--explains the cause of low sales, while customers who made the highest sales have been
--observed to purchase more technology inclined products which are relatively high in price
--and hence justifies the reason for the high sales

-----Hence, management should consider the following to boost the sales of the bottom 10 customers;
--a--Personalised offers: The management can consider providing targeted promotions
-----and discounts to these customers.
--b--Enhanced Customer Service: Improve their shopping experience
--c--Loyalty Programs: Management can consider incentives and giveaway products for
-----customers who purchases high priced items.

-----Alternatively, focus on;
--a--Retaining High Value Customers: Prioritizing  satisfaction and loyalty amoong top customers
--b--Acquiring New Customers: Target high-potential customers through marketing campaigns and
-----quality products


--5--The Shipping method with the highest cost

select top 1 ship_mode, sum(shipping_cost) as Top_Ship_Mode_Cost
from [KMS Sql Case Study-1]
group by Ship_mode
order by Top_Ship_Mode_Cost desc


--6--The Top 10 Most Valued Customers and the Product/Service Category 

create view Most_Valued_Customers
as
select Top 10 Customer_Name,Product_Category,Product_Sub_Category,Region,
sum(sales) as Most_Valued_Customers
from [KMS Sql Case Study-1]
Group by Customer_Name,Product_Category,Product_Sub_Category,Region
Order by Most_Valued_Customers desc

select * from Most_Valued_Customers


--7--The Small Business Owner with the Highest Sale

select top 1 customer_name, Product_Category, Product_Sub_Category, sum(sales) as [Top SBO Sales]
from [KMS Sql Case Study-1]
where Customer_Segment = 'Small Business'
group by customer_name, Product_Category, Product_Sub_Category
order by [Top SBO Sales] desc

--8--The Corporate Customer with the highest order between 2009 - 2012

create view VW_Corporate_Customer
as
select top 1 Customer_Name, Product_Category, Product_Sub_Category, Order_Date,
sum(Order_Quantity) as [Highest Order]
from [KMS Sql Case Study-1]
where Customer_Segment = 'Corporate'
group by Customer_Name, Product_Category, Product_Sub_Category, Order_Date
order by [Highest Order] desc

select * from VW_Corporate_Customer


--9--The Consumer Customer with the highest Profit

select top 1 customer_name, Product_Category, Product_Sub_Category,
sum(Profit) as [Top Profitable Consumer]
from [KMS Sql Case Study-1]
where Customer_Segment = 'Consumer'
group by customer_name, Product_Category, Product_Sub_Category
order by [Top Profitable Consumer]

--10--The Customers who retured Items and their Segment

select distinct KMS.Order_ID,
                KMS.Customer_Name,
                KMS.Customer_Segment
from [KMS Sql Case Study-1] as KMS
join Order_Status as Ord
on KMS.Order_ID = Ord.Order_ID
WHERE Ord.[Status] = 'Returned'


--11--Comparative Analysis to provide insight on what Shipping Mode is beneficial to the Company

select Order_Priority,Ship_Mode,
count(Order_ID) as Order_Count,
Sum(Sales-Profit) as Estimated_Shipping_Cost,
AVG(Datediff(day, Order_Date, Ship_Date))
as Avg_Ship_Days
From [KMS Sql Case Study-1]
Group by Order_Priority, Ship_Mode
Order by Order_Priority, Ship_Mode Desc


