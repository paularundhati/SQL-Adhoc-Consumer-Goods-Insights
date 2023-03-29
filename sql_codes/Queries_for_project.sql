//Adhoc 1
select distinct(market)
from dim_customer
where lower(customer) like '%atliq exclusive%'
and region ='APAC'
order by 1

//Adhoc 2
select unique_products_2020
,unique_products_2021
,round((unique_products_2021 - unique_products_2020)*100.0 / (unique_products_2020),2) as percentage_chg
from
(select
 count(distinct case when fiscal_year = 2020 then product_code end) as unique_products_2020
 ,count(distinct case when fiscal_year = 2021 then product_code end) as unique_products_2021
 from fact_sales_monthly
) as src

//Adhoc 3
select segment
,count(distinct product_code) as product_count
from dim_product
group by 1
order by 2 desc

//Adhoc 4
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

//Adhoc 5
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

//Adhoc 6
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

//Adhoc 7
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

//Adhoc 8
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

//Adhoc 9
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

//Adhoc 10
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












































