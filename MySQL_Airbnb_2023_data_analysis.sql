
-- Average price of Airbnb listings per city
SELECT city, AVG(price) AS avg_price
FROM airbnb_mysql_analyze.airbnb_mysql
GROUP BY city
ORDER BY avg_price DESC;


-- Most popular neighborhoods groupby City by reviews:
SELECT city, neighbourhood, SUM(number_of_reviews) AS total_reviews
FROM airbnb_mysql_analyze.airbnb_mysql
GROUP BY city, neighbourhood
ORDER BY total_reviews DESC
LIMIT 10;

-- Distribution of room types:
SELECT room_type, COUNT(*) AS count
FROM airbnb_mysql_analyze.airbnb_mysql
GROUP BY room_type
ORDER BY count DESC;

-- Distribution of Prices

SELECT 
    CASE 
        WHEN price < 50 THEN 'Under $50'
        WHEN price BETWEEN 50 AND 100 THEN '$50-$100'
        WHEN price BETWEEN 101 AND 200 THEN '$101-$200'
        WHEN price BETWEEN 201 AND 500 THEN '$201-$500'
        ELSE 'Above $500'
    END AS price_range,
    COUNT(*) AS listings_count
FROM airbnb_mysql_analyze.airbnb_mysql
GROUP BY price_range
ORDER BY listings_count DESC;

-- Average price per room type:

SELECT room_type, AVG(price) AS avg_price
FROM airbnb_mysql_analyze.airbnb_mysql
GROUP BY room_type;

-- What are the average prices for each room type in the top cities?

SELECT city, room_type, AVG(price) AS avg_price, COUNT(*) AS total_listings
FROM airbnb_mysql_analyze.airbnb_mysql
GROUP BY city, room_type
HAVING total_listings > 100
ORDER BY avg_price DESC;


-- Top 5 hosts with the most listings:
SELECT host_name, SUM(calculated_host_listings_count) AS total_listings
FROM airbnb_mysql_analyze.airbnb_mysql
GROUP BY host_name
ORDER BY total_listings DESC
LIMIT 5;

-- Availability of listings over a year:
SELECT availability_365, COUNT(*) AS listings_count
FROM airbnb_mysql_analyze.airbnb_mysql
GROUP BY availability_365
ORDER BY availability_365 DESC;

-- Which neighborhoods have the highest availability throughout the year?

SELECT city, neighbourhood, AVG(availability_365) AS avg_availability
FROM airbnb_mysql_analyze.airbnb_mysql
GROUP BY city, neighbourhood
HAVING AVG(availability_365) > 300
ORDER BY avg_availability DESC
LIMIT 10;


-- SELECT id, name, reviews_per_month, city

SELECT id, name, reviews_per_month, city
FROM airbnb_mysql_analyze.airbnb_mysql
WHERE reviews_per_month IS NOT NULL
ORDER BY reviews_per_month DESC
LIMIT 10;

-- Which neighborhoods offer the lowest price per review, suggesting high value for guests?
SELECT city, neighbourhood, 
       AVG(price) / NULLIF(AVG(number_of_reviews), 0) AS price_per_review
FROM airbnb_mysql_analyze.airbnb_mysql
WHERE number_of_reviews > 0
GROUP BY city, neighbourhood
ORDER BY price_per_review ASC
LIMIT 10;

