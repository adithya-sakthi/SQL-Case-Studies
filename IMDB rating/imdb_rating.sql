select * from genre;
select * from imdb;
select * from earning;

-- Problem Statement 1 : 
-- From the IMDb dataset, print the title and rating of those movies which have a genre starting from 'C' released in 2014 with a budget higher than 4 Crore.

select i.title,i.rating from imdb i
join genre g on i.movie_id=g.movie_id
where g.genre LIKE "C%" and i.title LIKE "%2014%"
and i.Budget > 40000000;

-- Problem Statement 2 :  
-- Print the title and ratings of the movies released in 2012 whose metacritic rating is more than 60 and Domestic collections exceed 10 Crores.

select i.title,i.rating from imdb i join earning e on 
i.movie_id= e.movie_id 
where  i.title LIKE "%2012%" and
i.metacritic>60 and
e.domestic>100000000;


-- Problem Statement 3 : 
-- Print the genre and the maximum net profit among all the movies of that genre released in 2012 per genre. 
-- NOTE - 
-- 1. Do not print any row where either genre or the net profit is empty/null.
-- 2. net_profit = Domestic + Worldwide - Budget
-- 3. Keep the name of the columns as 'genre' and'net_profit'
-- 4. The genres should be printed in alphabetical order. 

with cte as(select g.genre, (e.domestic + e.worldwide - i.budget) AS net_profit
from genre g join earning e on g.movie_id = e.movie_id
join imdb i on e.movie_id=i.movie_id 
where i.title LIKE "%2012%")
select genre,max(net_profit) as net_profit from cte where genre is not null AND net_profit is not null
group by genre
order by genre asc;


-- Problem Statement 4 : 
-- Print the genre and the maximum weighted rating among all the movies of that genre released in 2014 per genre.
-- Note:
-- 1. Do not print any row where either genre or the weighted rating is empty/null.
-- 2. weighted_rating = avgerge of (rating + metacritic/10.0)
-- 3. Keep the name of the columns as 'genre' and 'weighted_rating'
-- 4. The genres should be printed in alphabetical order.


with cte as(select g.genre, (i.rating + i.metacritic/10.0)/2 AS weighted_rating
from genre g join imdb i on g.movie_id = i.movie_id 
where i.title LIKE "%2014%")

select genre,max(weighted_rating) AS weighted_rating from cte
where genre is not null and weighted_rating is not null
group by genre
order by genre asc;
