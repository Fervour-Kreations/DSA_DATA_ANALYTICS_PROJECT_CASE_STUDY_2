#   Kultra Mega Stores Inventory Analysis

---

## **Project Overview**

This project analyzes the sales and operational performance of **Kultra Mega Stores (KMS)** using transactional data from its inventory system. The goal is to extract actionable insights to help KMS management improve customer satisfaction, streamline operations, and increase revenue.

---

## **Data Source**

The analysis was performed on data extracted from:

* `KMS Sql Case Study-1` – transactional sales records
* `Order_Status` – order status and return data

---

## **Tools Used**

* **SQL Server** – For data extraction and transformation [click here to download](https://sql)


---

## **Insights and Codes**

1. **Which product category had the highest sales?**

   ➤ *Technology* was the product category with the highest total sales across all regions.

~~~sql
Select top 1 Product_Category, sum(Sales) as Total_Sales
From [KMS Sql Case Study-1]
Group by Product_Category
Order by Total_Sales Desc
~~~


2. **What are the Top 3 and Bottom 3 regions in terms of sales?**

   * **Top 3**: Ontario, Quebec, British Columbia

~~~sql
  Select top 3 Region, sum(sales) as Total_Sales_per_Region
  from [KMS Sql Case Study-1]
  Group by Region
  Order by Total_Sales_per_Region Desc
~~~


   * **Bottom 3**: Yukon, Nunavut, Newfoundland
~~~sql
select Top 3 Region, sum(sales) as Total_Bottom_Sales_Per_Region
from [KMS Sql Case Study-1]
Group by Region
Order by Total_Bottom_Sales_per_Region asc
~~~


3. **What were the total sales of appliances in Ontario?**

   ➤ The total sales of *Appliances* in *Ontario* was calculated using a filtered aggregation and amounted to **₦202,346.84**.

~~~sql
select Region, sum(sales) as Total_Sales_Appliances_Ontario
from [KMS Sql Case Study-1]
where Region = 'Ontario'
and product_sub_category = 'Appliances'
Group by Region
~~~


4. **Advice for increasing revenue from the bottom 10 customers:**

   * Target them with personalized offers or loyalty programs.
   * Analyze their previous purchases to recommend relevant products.
   * Provide incentives like discounts, free shipping, or faster delivery.
   * Improve product education and after-sales support to boost engagement.


5. **KMS incurred the most shipping cost using which shipping method?**

   ➤ *Express Air* resulted in the **highest shipping costs**, which aligns with it being the fastest and most expensive method.

~~~sql
select top 1 ship_mode, sum(shipping_cost) as Top_Ship_Mode_Cost
from [KMS Sql Case Study-1]
group by Ship_mode
order by Top_Ship_Mode_Cost desc
~~~


6. **Who are the most valuable customers and what do they typically purchase?**

   ➤ The top high-spending customers mainly purchased *Office Supplies* and *Technology*, with consistent repeat orders.

~~~sql
create view Most_Valued_Customers
as
select Top 10 Customer_Name,Product_Category,Product_Sub_Category,Region,
sum(sales) as Most_Valued_Customers
from [KMS Sql Case Study-1]
Group by Customer_Name,Product_Category,Product_Sub_Category,Region
Order by Most_Valued_Customers desc
~~~

7. **Which small business customer had the highest sales?**

   ➤ *Customer Denis Kane* from the *Small Business* segment recorded the highest total sales over the period.

~~~sql
select top 1 customer_name, Product_Category, Product_Sub_Category, sum(sales) as [Top SBO Sales]
from [KMS Sql Case Study-1]
where Customer_Segment = 'Small Business'
group by customer_name, Product_Category, Product_Sub_Category
order by [Top SBO Sales] desc
~~~


8. **Which corporate customer placed the most number of orders (2009–2012)?**

   ➤ *Customer Ruben Ausman* in the *Corporate Segment* placed the most orders during the period — indicating a loyal business client.

~~~sql
create view VW_Corporate_Customer
as
select top 1 Customer_Name, Product_Category, Product_Sub_Category, Order_Date,
sum(Order_Quantity) as [Highest Order]
from [KMS Sql Case Study-1]
where Customer_Segment = 'Corporate'
group by Customer_Name, Product_Category, Product_Sub_Category, Order_Date
order by [Highest Order] desc
~~~


9. **Which consumer customer was the most profitable one?**
    
   ➤ Profit-based ranking showed *Customer Dave Kipp* from the *Consumer Segment* generated the highest net profit.

~~~sql
select top 1 customer_name, Product_Category, Product_Sub_Category,
sum(Profit) as [Top Profitable Consumer]
from [KMS Sql Case Study-1]
where Customer_Segment = 'Consumer'
group by customer_name, Product_Category, Product_Sub_Category
order by [Top Profitable Consumer]
~~~


10. **Which customer returned items and what segment do they belong to?**

     ➤ Several customers were identified with return records. Most belonged to the *Consumer* and *Small Business* segments.

~~~sql
select distinct KMS.Order_ID,
                KMS.Customer_Name,
                KMS.Customer_Segment
from [KMS Sql Case Study-1] as KMS
join Order_Status as Ord
on KMS.Order_ID = Ord.Order_ID
WHERE Ord.[Status] = 'Returned'
~~~

11. **Did KMS appropriately spend shipping costs based on order priority?**

    ➤ Not always. There were cases where **low-priority orders used Express Air**, increasing costs unnecessarily.
    
    ➤ Recommendation: Align shipping methods with order priority (e.g., use *Standard Class* or *Delivery Truck* for *Low* priority orders) to **optimize cost-efficiency**.

~~~sql
select Order_Priority,Ship_Mode,
count(Order_ID) as Order_Count,
Sum(Sales-Profit) as Estimated_Shipping_Cost,
AVG(Datediff(day, Order_Date, Ship_Date))
as Avg_Ship_Days
From [KMS Sql Case Study-1]
Group by Order_Priority, Ship_Mode
Order by Order_Priority, Ship_Mode Desc
~~~
---

## **Summary of Findings**

* **Technology** leads in sales across product categories.
* Certain regions underperform significantly and may benefit from regional marketing strategies.
* Shipping costs are disproportionately high for certain methods like *Express Air*.
* High-value customers show consistent purchasing behavior across specific product categories.
* There’s a disconnect between order priority and shipping method — causing overspending.

---

## **Recommendations**

1.  **Invest in Top-Selling Categories & Regions**: Increase product variety and promotional efforts in the Technology category and regions like Ontario.
2.  **Engage Low-Performing Customers**: Personalized marketing, loyalty programs, and discounts can help revive engagement.
3.  **Optimize Shipping Strategy**: Match order priority with cost-effective shipping methods.
4.  **Promote Cost-Efficient Products**: Push products with high profit margins and low return rates.
5.  **Improve Return Experience**: Track common reasons for returns and improve product quality or description clarity.

---

## **Conclusion**

This project reveals key operational insights for Kultra Mega Stores across customer behavior, shipping strategy, product performance, and regional demand. By acting on these findings, KMS can improve profitability, enhance customer satisfaction, and ensure efficient resource allocation.
