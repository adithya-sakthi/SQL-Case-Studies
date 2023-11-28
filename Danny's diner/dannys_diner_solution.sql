-- Problem statement 1: What is the total amount each customer spent at the restaurant?

select a.customer_id,sum(b.price) as total_amount_spent
from sales a JOIN menu b
on a.product_id = b.product_id
GROUP BY a.customer_id
ORDER BY a.customer_id;

-- Problem Statement 2: How many days have each customer visited the restaurant?

select customer_id,count(distinct order_date) as number_of_days
from sales 
GROUP BY customer_id;

-- Problem statement 3: What was the first item from the menu purchased by each customer?

with final as(select a.customer_id, b.product_name AS first_order,
rank() over(partition by a.customer_id order by a.order_date) AS rnk
from sales a JOIN menu b
ON a.product_id = b.product_id)
select * from final where rnk=1;

-- Problem Statement 4: What is the most purchased item on the menu and how many times was it purchased by all customers?

select b.product_name,count(a.product_id) as most_purchased
from sales a join menu b
on a.product_id=b.product_id
group by b.product_name
order by most_purchased desc
limit 1;


 -- Problem Statement 5: Which item was the most popular for each customer?

with final as(select a.customer_id,b.product_name,count(a.product_id) as counts,
dense_rank() over(partition by a.customer_id  order by count(a.product_id) desc) as rnk
from sales a join menu b
on a.product_id=b.product_id
group by a.customer_id,b.product_name)
select customer_id,product_name,counts from final where rnk=1;

 -- Problem Statement 6: Which item was purchased first by the customer after they became a member?

with final as (select a.customer_id,b.product_name,a.order_date,m.join_date,
dense_rank() over(partition by a.customer_id order by a.order_date) as rnk
from sales a join menu b on a.product_id=b.product_id 
join members m on a.customer_id=m.customer_id
where a.order_date>=m.join_date)
select customer_id,product_name,order_date,join_date from final where rnk=1;


-- Problem Statement 7: Which item was purchased just before the customer became a member? 

with final as (select a.customer_id,b.product_name,a.order_date,
dense_rank() over(partition by a.customer_id order by a.order_date desc) as rnk
from sales a join menu b on a.product_id=b.product_id 
join members m on a.customer_id=m.customer_id
where a.order_date < m.join_date)
select customer_id,product_name,order_date from final where rnk=1 ;

-- Problem Statement 8: What are the total items and amount spent for each member before they became a member?

select a.customer_id, count(b.product_id) AS total_items, SUM(b.price) as total_sales
from sales a join menu b on a.product_id=b.product_id join
members m on a.customer_id=m.customer_id
where a.order_date<m.join_date
group by a.customer_id
order by a.customer_id;

-- Problem Statement 9: If each $1 spent equates to 10 points and sushi has a 2x points multiplier how many points would each customer have?

with final as (select *, 
case when 
product_id=1 then price * 20
else price * 10
End as points
from menu) 
select a.customer_id, sum(f.points) AS toal_points from
final f join sales a
on f.product_id=a.product_id
group by a.customer_id;


-- Bonus Question 1 : Join all the things 

SELECT a.customer_id, a.order_date, b.product_name, b.price, 
CASE WHEN a.order_date >= m.join_date THEN 'Y'
     WHEN a.order_date < m.join_date THEN 'N'  
     ELSE 'N' 
     END AS member 
FROM sales a
LEFT JOIN menu b ON a.product_id = b.product_id 
LEFT JOIN members m 
ON a.customer_id = m.customer_id ;

-- Bonus Question 2: Rank all the things 

with final as (SELECT a.customer_id, a.order_date, b.product_name, b.price, 
CASE WHEN a.order_date >= m.join_date THEN 'Y'
     WHEN a.order_date < m.join_date THEN 'N'  
     ELSE 'N' 
     END AS member
FROM sales a
LEFT JOIN menu b ON a.product_id = b.product_id 
LEFT JOIN members m 
ON a.customer_id = m.customer_id)
select *, 
CASE WHEN member = 'Y' THEN DENSE_RANK() OVER(PARTITION BY customer_id,member ORDER BY order_date)
ELSE 'Null'
END AS ranking 
from final ;
