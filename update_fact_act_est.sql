with cte1 as(
select 
	s.date,s.fiscal_year,
    s.product_code, s.customer_code,
    s.sold_quantity, p.gross_price,
    round(sold_quantity*gross_price,2) as gross_sales_per_item
from fact_sales_monthly s
join fact_gross_price p
	on s.product_code=p.product_code and
    s.fiscal_year=p.fiscal_year),
    
cte2 as (
select 
	cx.market, cx.region,
    round(sum(gross_sales_per_item)/1000000,2) as gross_sales_mln
from cte1 c1
join dim_customer cx
	on c1.customer_code=cx.customer_code
where fiscal_year=2021
group by market, region),

cte3 AS (  -- New CTE to calculate and store rnk before filtering
    SELECT 
        *, 
        RANK() OVER (PARTITION BY region ORDER BY gross_sales_mln DESC) AS rnk
    FROM cte2
)
SELECT * 
FROM cte3 
WHERE rnk <= 2;

select * from fact_act_est;

update fact_act_est
set sold_quantity = 0
where sold_quantity is null;