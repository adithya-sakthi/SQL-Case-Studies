## Case Study #2: IMDB Rating Analysis
For this Case Study, I have analyzed the IMDB dataset using SQL and wrote queries to answer some of the interesting problem statements.

The Database for this case study consists of 3 Tables -
1. Earning
2. Genre
3. IMDB

### Case study questions

1.  Print the title and rating of those movies that have a genre starting from 'C' released in 2014 with a budget higher than 4 Crore.
2. Print the title and ratings of the movies released in 2012 whose Metacritic rating is more than 60 and whose Domestic collections exceed 10 Crores.
3. Print the genre and the maximum net profit among all the movies of that genre released in 2012 per genre. 
#### Note :
-- Do not print any row where either the genre or the net profit is empty/null.\
-- net_profit = Domestic + Worldwide - Budget\
-- Keep the name of the columns as 'genre' and'net_profit'\
-- The genres should be printed in alphabetical order.

4. Print the genre and the maximum weighted rating among all the movies of that genre released in 2014 per genre.
#### Note:
-- Do not print any row where either the genre or the weighted rating is empty/null.\
-- weighted_rating = average of (rating + Metacritic/10.0)\
-- Keep the name of the columns as 'genre' and 'weighted_rating'\
-- The genres should be printed in alphabetical order.
