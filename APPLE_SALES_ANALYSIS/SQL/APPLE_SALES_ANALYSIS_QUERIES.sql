-- 1.Find each country and number of stores
select country, count(store_id) as Total_Stores
from stores
Group by country
order by Total_Stores desc;

-- What is the total number of units sold by each store?
select 
st.store_id,
st.store_name,
sum(quantity) as total_units
from sales sl inner join stores st
on st.store_id = sl.store_id
Group by st.store_id,st.store_name
order by total_units Desc;

-- How many sales occurred in December 2023?
select
count(sale_id) as total_sales
from sales
where TO_CHAR(sale_date,'MM-YYYY') = '12-2023';


-- 4 How many stores have never had a warranty claim filed against any of their products?
 select * from stores
 where store_id NOT IN(
 						select 
 						distinct(store_id)
 						--store_id
 						from warranty w left join sales s
 						on w.sale_id = s.sale_id);-- recieved warranty claims stores

-- 5 Identify least selling product of each country for each year based on total unit sold
WITH product_rank AS (
    SELECT
        st.country,
        p.product_name,
        EXTRACT(YEAR FROM sl.sale_date) AS year,
        SUM(sl.quantity) AS total_quantity_sold,
        RANK() OVER(PARTITION BY st.country, EXTRACT(YEAR FROM sl.sale_date) ORDER BY SUM(sl.quantity) DESC) AS rank
    FROM
        stores st
    JOIN
        sales sl ON st.store_id = sl.store_id
    JOIN
        products p ON p.product_id = sl.product_id
    GROUP BY
        st.country, p.product_name, EXTRACT(YEAR FROM sl.sale_date)
)
SELECT *
FROM product_rank
WHERE rank = 1;

-- 6. How many warranty claims were filed within 180 days of a product sale?

select
	w.*,
	s.sale_date,
	w.claim_date - s.sale_date as Claim_days
from warranty w 
left join 
sales s
on s.sale_id = w.sale_id
where 
	w.claim_date - s.sale_date <=180;

-- -- 7 Write a query to calculate the monthly running total of sales for each store
-- over the past four years and compare trends during this period.

WITH monthly_sales
AS
(
select
	s.store_id,
	EXTRACT(YEAR from s.sale_date) as year,
	EXTRACT(MONTH from s.sale_date) as month,
	SUM(p.price * s.quantity) as total_revenue
from sales as s
join products as p
on p.product_id = s.product_id
GROUP BY s.store_id,year,month
ORDER BY s.store_id,year,month
)
SELECT 
	store_id,
	month,
	year,
	total_revenue,
	SUM(total_revenue) OVER(PARTITION BY store_id ORDER BY year, month) as running_total
FROM monthly_sales

-- 8 Identify the store with the highest percentage of "Paid Repaired" claims relative to total claims filed

WITH paid_repair
AS
(select 
	s.store_id,
	count(w.claim_id) as paid_repaired
from sales as s
Right join warranty as w
on s.sale_id = w.sale_id
where w.repair_status = 'Paid Repaired'
Group by 1
),

total_repaired
AS
(select 
	s.store_id,
	count(w.claim_id) as total_repaired
from sales as s
Right join warranty as w
on s.sale_id = w.sale_id
Group by 1
)

select
	tr.store_id,
	st.store_name,
	pr.paid_repaired,
	tr.total_repaired,
	ROUND(pr.paid_repaired::numeric /tr.total_repaired::numeric *100,2) as percentage_paid_repaired
from paid_repair as pr
JOIN
total_repaired as tr
on pr.store_id = tr.store_id
JOIN stores as st
on st.store_id = tr.store_id
ORDER BY percentage_paid_repaired DESC


