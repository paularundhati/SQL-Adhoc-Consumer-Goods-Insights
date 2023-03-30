# SQL-Adhoc-Consumer-Goods-Insights
### SQL challenge submission for Codebasics. 10 ad hoc requests on Consumer Goods domain answered using SQL queries and presented visually.

Codebasics Challenge Link : [Link](https://codebasics.io/challenge/codebasics-resume-project-challenge)

Linkedin Presentation Link : [Link]()

## Table of Contents

- [Problem Statement and Task](#problem-statement-and-task)
- [Database Structure](#database-structure)
- [Important Aspects Of Our Consumer Goods Company, Atliq Hardwares](#important-aspects-of-our-consumer-goods-company-atliq-hardwares)
- [Adhoc Requests with SQL codes, Output, Visualization, and Insights](#adhoc-requests-with-sql-codes-output-visualization-and-insights)

## Problem Statement and Task

Consumer Goods Atliq Hardwares (imaginary company) is one of the leading computer hardware producers in India and well expanded in other countries too.
However, the management noticed that they do not get enough insights to make quick and smart data-informed decisions. They want to expand their data analytics team by adding several junior data analysts. Tony Sharma, their data analytics director wanted to hire someone who is good at both tech and soft skills. Hence, he decided to conduct a SQL challenge which will help him understand both the skills.

As an applicant for the role, you must run SQL queries to answer 10 ad hoc requests in and present your findings in a creative presentation.



## Database Structure

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/database_structure.jpg"
  height="400">
</p>



## Important Aspects Of Our Consumer Goods Company, Atliq Hardwares

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/atliq_customers_visual.jpg"
  height="400">
</p>


<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/geolocation_markets.jpg" height="400">
</p>


<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/distribution__channels.jpg"
  height="400">
</p>


<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/product_distribution.jpg"
  height="400">
</p>



## Adhoc Requests with SQL codes, Output, Visualization, and Insights

### **Adhoc 1:** Provide the list of markets in which customer `Atliq Exclusive` operates its business in the `APAC region`

```sql
select distinct(market)
from dim_customer
where lower(customer) like '%atliq exclusive%'
and region ='APAC'
order by 1
```
**Output:**
<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc1-output.jpg" height="250">
</p>

**Visualization and Insights:**
<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc1_visual.jpg" height="400">
</p>

- APAC region contains 10 markets. Out of those 10 markets, Atliq Exclusive operates on 8 markets, except - Pakistan and China.



### **Adhoc 2:** What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, unique_products_2020     unique_products_2021      percentage_chg

```sql
select unique_products_2020
,unique_products_2021
,round((unique_products_2021 - unique_products_2020)*100.0 / (unique_products_2020),2) as percentage_chg
from
(select
 count(distinct case when fiscal_year = 2020 then product_code end) as unique_products_2020
 ,count(distinct case when fiscal_year = 2021 then product_code end) as unique_products_2021
 from fact_sales_monthly
) as src
```
**Output:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc2_output.jpg" height="80">
</p>


**Visualization and Insights:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc_2_visual.jpg" height="400">
</p>


-	A 36.33% jump in unique product in 2021 shows that Atliq Hardwares wants to offer a diversified range of products from which their customers can choose from.



### **Adhoc 3:** Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. The final output contains 2 fields, segment     product_count 


```sql
select segment
,count(distinct product_code) as product_count
from dim_product
group by 1
order by 2 desc
```
**Output:**
<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc3_output.jpg" height="200">
</p>


**Visualization and Insights:**
<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc_3_visual.jpg" height="400">
</p>

-	Atliq Hardwares offers the most count of products in the “Notebook” followed by “Accessories” segment. It shows they have more focus on these areas.

-	“Peripherals” being the third suggests that company specializes producing components for computer assembly.

__Note__ : Atliq Hardware should expand into areas with fewer products to address gaps in their product line and meet customer needs.



### **Adhoc 4:** Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields,    segment     product_count_2020 product_count_2021    difference


```sql
select 
segment
,product_count_2020
,product_count_2021
,(product_count_2021 - product_count_2020) as difference
from
(select
 segment
 ,count(distinct case when fiscal_year = 2020 then sales.product_code end) as product_count_2020
 ,count(distinct case when fiscal_year = 2021 then sales.product_code end) as product_count_2021
 from fact_sales_monthly as sales
 left join dim_product as product
 using(product_code)
 group by 1
) as src
order by 4 desc
```
**Output:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc4_output.jpg" height="200">
</p>

**Visualization and Insights:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc4_visual.jpg" height="400">
</p>

-	All segments have a boost in product count in 2021

-	"Accessories" segment has the most growth. Pandemic might be reason, reflecting customers' interest in products that enhance their work-from-home setups, such as mouse, keyboards, and batteries.

-	“Notebook” and “Peripherals” has the 2nd highest increase, reflecting a demand for laptops for both personal and business use and computer components for cost-effective upgrades or DIY builds.



### **Adhoc 5:** Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields,      product_code        product    manufacturing_cost

```sql
select
manufacture.product_code
,product
,round(manufacturing_cost,2) as manufacturing_cost
from fact_manufacturing_cost as manufacture
left join dim_product as product
using(product_code)
where manufacturing_cost in (select max(manufacturing_cost) from fact_manufacturing_cost)
      or manufacturing_cost in (select min(manufacturing_cost) from fact_manufacturing_cost)
order by 3 desc
```
**Output:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc5_output.jpg" height="120">
</p>

**Visualization and Insights:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc5_visual.jpg" height="320">
</p>

-	"AQ Master wired x1 Ms"  has the lowest manufacturing cost of 1.

-	"AQ HOME Allin1 Gen 2“ has the highest manufacturing cost of 241 which was contributed due to high cost associated with its raw materials, labor, and overhead expenses.

__Note__ : Atliq Hardwares should explore ways to reduce manufacturing costs to increase competitiveness by offering products at a lower price than competitors.



### **Adhoc 6:** Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. The final output contains these fields,     customer_code    customer average_discount_percentage

```sql
select
cstmr.customer_code
,customer
,concat(round(avg(pre_invoice_discount_pct)*100,2),'%') as average_discount_percentage
from fact_pre_invoice_deductions as invoice
left join dim_customer as cstmr
using(customer_code)
where fiscal_year = 2021 and market = 'India'
group by 1,2
order by avg(pre_invoice_discount_pct) desc 
limit 5 
```
**Output:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc6_output.jpg" height="200">
 
</p>

**Visualization and Insights:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc6_visual.jpg" height="350">
</p>

-	Flipkart has the highest average discount percentage (30.83%) while Amazon has the lowest (29.33%).

-	Flipkart’s receiving the high pre-invoice discount on the products for its audience might be due to its:
    1. Large order and long-term contract
    2. Bargaining and Purchasing power
    3. Offering lower commission margin 
    4. The high demand of its audience for hardware products.

__Note__ : Atliq Hardwares should optimize pricing and discount strategies and negotiate more effectively with customers to maximize profitability and customer satisfaction.



### **Adhoc 7:** Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . This analysis helps to get an idea of low and high-performing months and take strategic decisions. The final report contains these columns:     Month    Year     Gross sales Amount

```sql
select
TO_CHAR(date, 'Month') as Month
,sales.fiscal_year as Year
,round(sum(gross_price*sold_quantity),2) as "Gross Sales Amount"
from fact_sales_monthly as sales
left join fact_gross_price as price
using(product_code)
where customer_code in ('70002017','70003181','70004069',
						'70006157','70007198','70008169',
						'70009133','70010047','70011193',
						'70012042','70013125','70014142',
                        '70015151','70016177','70022084',
						'70023031','90002011')
group by TO_CHAR(date, 'Month'),EXTRACT(MONTH FROM date),sales.fiscal_year
ORDER BY sales.fiscal_year, EXTRACT(MONTH FROM date)
```
**Output:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc7_output.jpg" height="450">
</p>

**Visualization and Insights:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc7_visual.jpg" height="400">
</p>

-	November witnessed the highest gross sales in both 2020 and 2021 followed by September, October, and December likely due to seasonal factors and holiday shopping periods.
-	April performed the least suggesting a lack of major holidays or events driving sales during this period.
-	January performed well in both years possibly due to post-holiday demand and New Year's resolutions.

__Note__ : 1. Atliq Hardwares can optimize sales revenue by targeting peak holiday periods and taking advantage of post-holiday demand. 

2. They should also adjust their marketing strategies for lower-performing months like April to remain competitive.



### **Adhoc 8:** In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity,     Quarter total_sold_quantity

```sql
select
Quarter
,sum(sold_quantity) as total_sold_quantity
from
(select
case when EXTRACT(MONTH FROM date) in (9,10,11) then 'Q1'
	 when EXTRACT(MONTH FROM date) in (12,1,2) then 'Q2'
	 when EXTRACT(MONTH FROM date) in (3,4,5) then 'Q3'
	 when EXTRACT(MONTH FROM date) in (6,7,8) then 'Q4' end as Quarter
,sold_quantity
from fact_sales_monthly 
where fiscal_year = 2020) as src
group by 1
order by 2 desc
```
**Output:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc8_output.jpg" height="200">
</p>

   
**Visualization and Insights:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc8_visual.jpg" height="400">
</p>

-	The most profitable quarters are Q1 (7M quantity sold) and Q2 (6.6M).

-	Q3 has offered the least sale (2.1 M). One of the reason might be the pandemic.

__Note__ : 1. Optimizing sales strategy during Q1 and Q2 is crucial for revenue maximization. 

2. Investing in holiday-specific promotions and advertising to maximize revenue during Q4.

3. During uncertain times such as Q3 and the pandemic, the company needs to be flexible and explore new ways to sell their products and continue reaching customers.



### **Adhoc 9:** Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields,          channel  gross_sales_mln         percentage

```sql
with src1 as
(select
channel
,sum(gross_price*sold_quantity) as gross_sales_mln
from fact_sales_monthly as sales
left join fact_gross_price as price
using(product_code)
left join dim_customer as customer
using(customer_code)
where sales.fiscal_year = 2021
group by 1
 )
 
,src2 as 
(select sum(gross_sales_mln) as total_sales
from src1)

select 
channel
,round(gross_sales_mln,2) as gross_sales_mln
,concat(round(gross_sales_mln*100.0/total_sales,2),'%') as percentage
from src1,src2
order by (gross_sales_mln/total_sales) desc
```
**Output:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc9_output.jpg" height="150">
</p>

**Visualization and Insights:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc9_visual.jpg" height="200">
</p>

-	73% sales are coming through physical or online stores.

-	15% sales contributed directly from the company's website or other direct means.

-	11% is from the intermediaries between the manufacturer and the end consumer.

__Note__ : Atliq Hardwares should continue to invest in D2C that would help rely less on retail thereby assisting with larger sales margin.



### **Adhoc 10:**  Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? The final output contains these fields,     division     product_code    product     total_sold_quantity      rank_order 

```sql
with src1 as
(select
division
,product_code
,product
,sum(sold_quantity) as quantity
from fact_sales_monthly as sales
left join dim_product as pdt
using(product_code)
where sales.fiscal_year = 2021
group by 1,2,3)

,src2 as
(select
division
,product_code
,product
,quantity as total_sold_quantity
,dense_rank() over(partition by division order by quantity desc) as rank_order
from src1)

select 
* from src2
where rank_order <= 3
```
**Output:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc10_output.jpg" height="300">
</p>

**Visualization and Insights:**

<p align="center">
  <img src="https://github.com/paularundhati/SQL-Adhoc-Consumer-Goods-Insights/blob/master/Results-screenshots/adhoc10_visual.jpg" height="300">
</p>

-	In “N & S” division, USB Flash Drives products (“Accessories” segment) were sold in highest quantities in 2021.
-	For “P & A “ , Mouse products (“Storage” segment) were sold the most.
-	In “PC” division, Personal Laptops (“Notebook” segment) grabbed the limelight.

















