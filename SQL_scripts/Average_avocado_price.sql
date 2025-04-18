--What’s the average avocado price across regions?

SELECT region, AVG(AveragePrice) AS avg_price
FROM avocado_sales
GROUP BY region
ORDER BY avg_price DESC;

select *,
EXTRACT(MONTH FROM date) AS date_month
from avocado_sales

--What is the average price trend of avocados over time?
SELECT year, SUM(averageprice) as price_trend
FROM avocado_sales
WHERE year = 2

SELECT
    year,
    AVG(averageprice) AS average_price
FROM
    avocado_sales
GROUP BY
    year
ORDER BY
    year DESC;

--average price trend of avocados over months
SELECT EXTRACT(MONTH FROM date) AS date_month,
    AVG(averageprice) AS average_price
FROM avocado_sales
WHERE year = 2020
GROUP BY
    date_month
ORDER BY
    date_month DESC;



SELECT
    TO_CHAR(date, 'YYYY-MM') AS month,
    ROUND(AVG("AveragePrice"), 2) AS average_price
FROM
    avocado
GROUP BY
    TO_CHAR(date, 'YYYY-MM')
ORDER BY
    TO_CHAR(date, 'YYYY-MM');


--How do prices vary across different regions?
SELECT
    region,
    ROUND(AVG("averageprice") :: numeric, 2) AS average_price
FROM
    avocado_sales
GROUP BY
    region
ORDER BY
    average_price DESC;

--Which type (conventional or organic) is generally more expensive?
SELECT
    type,
    ROUND(AVG("AveragePrice")::numeric, 2) AS average_price
FROM
    avocado
GROUP BY
    type
ORDER BY
    average_price DESC;

--Which regions consume the most avocados?
SELECT
    region,
    ROUND(SUM("Total Volume")::numeric, 2) AS total_volume
FROM
    avocado
GROUP BY
    region
ORDER BY
    total_volume DESC;

--. Are there seasonal patterns in avocado sales or prices?
/*To explore seasonal patterns in avocado sales or prices,
 you'll need to group the data by month (across all years)
  and look at the average price or total volume sold each month.*/
SELECT
    TO_CHAR(date, 'Month') AS month,
    ROUND(SUM("totalvolume")::numeric, 2) AS total_volume
FROM
    avocado_sales
GROUP BY
    TO_CHAR(date, 'Month'), EXTRACT(MONTH FROM date)
ORDER BY
    EXTRACT(MONTH FROM date);

--What is the correlation between price and volume?
/*
CORR(col1, col2): This PostgreSQL function returns 
the Pearson correlation coefficient between two columns.

+1: Strong positive correlation

-1: Strong negative correlation

0: No correlation

You might want to analyze specific regions or types (organic vs. conventional) to see if the relationship is stronger in certain segments.

Or visualize it with a scatter plot — would you like 
help with that in Python?
*/
/*
The number falls between -1 and 0, which means 
there's a negative correlation.

Because it's close to 0, 
it’s a weak negative correlation.
As avocado prices increase, the total volume sold tends to decrease slightly, 
but the relationship is not strong.
*/
SELECT
    CORR("averageprice", "totalvolume") AS price_volume_correlation
FROM
    avocado_sales;

--How does avocado sales differ across years?
/*
Want a chart version in Python too? Or maybe break it down by type (organic/conventional)?
*/
SELECT
    EXTRACT(YEAR FROM date) AS year,
    ROUND(SUM("Total Volume")::numeric, 2) AS total_volume
FROM
    avocado
GROUP BY
    year
ORDER BY
    year;

--What packaging size is most sold (small, large, XL bags)?
/*
This will clearly show you which bag size is most 
popular in terms of sales.

Would you like to visualize this in a 
pie chart or bar chart in Python as well?
*/
SELECT
    'smallbags' AS bag_type,
    ROUND(SUM("smallbags")::numeric, 2) AS total_volume
FROM avocado_sales

UNION ALL

SELECT
    'largebags' AS bag_type,
    ROUND(SUM("largebags")::numeric, 2) AS total_volume
FROM avocado_sales

UNION ALL

SELECT
    'xlargebag' AS bag_type,
    ROUND(SUM("xlargebags")::numeric, 2) AS total_volume
FROM avocado_sales

ORDER BY total_volume DESC;

--Alternative: Use a CROSS JOIN on VALUES()
SELECT
    bag_type,
    total_volume
FROM (
    VALUES
        ('smallbags', (SELECT SUM("smallbags") FROM avocado_sales)),
        ('largebags', (SELECT SUM("largebags") FROM avocado_sales)),
        ('xlargebags', (SELECT SUM("xlargebags") FROM avocado_sales))
) AS volumes(bag_type, total_volume)
ORDER BY total_volume DESC;


--Which PLU (product lookup code) contributes most to the total volume sold?
SELECT
    '4046' AS plu,
    ROUND(SUM("4046")::numeric, 2) AS total_volume
FROM avocado

UNION ALL

SELECT
    '4225' AS plu,
    ROUND(SUM("4225")::numeric, 2) AS total_volume
FROM avocado

UNION ALL

SELECT
    '4770' AS plu,
    ROUND(SUM("4770")::numeric, 2) AS total_volume
FROM avocado

ORDER BY total_volume DESC;

--BY Region
SELECT
    region,
    '4046' AS plu,
    SUM("4046") AS total_volume
FROM avocado
GROUP BY region

UNION ALL

SELECT
    region,
    '4225',
    SUM("4225")
FROM avocado
GROUP BY region

UNION ALL

SELECT
    region,
    '4770',
    SUM("4770")
FROM avocado
GROUP BY region

ORDER BY region, total_volume DESC;

--BY YEAR
SELECT
    EXTRACT(YEAR FROM date) AS year,
    '4046' AS plu,
    SUM("4046") AS total_volume
FROM avocado
GROUP BY year

UNION ALL

SELECT
    EXTRACT(YEAR FROM date),
    '4225',
    SUM("4225")
FROM avocado
GROUP BY EXTRACT(YEAR FROM date)

UNION ALL

SELECT
    EXTRACT(YEAR FROM date),
    '4770',
    SUM("4770")
FROM avocado
GROUP BY EXTRACT(YEAR FROM date)

ORDER BY year, total_volume DESC;

--Top-Selling PLU Per Region using CTEs and ROW_NUMBER()
WITH plu_sales AS (
    SELECT region, '4046' AS plu, SUM("4046") AS total_volume
    FROM avocado
    GROUP BY region

    UNION ALL

    SELECT region, '4225', SUM("4225")
    FROM avocado
    GROUP BY region

    UNION ALL

    SELECT region, '4770', SUM("4770")
    FROM avocado
    GROUP BY region
),
ranked_plu AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY region ORDER BY total_volume DESC) AS rank
    FROM plu_sales
)
SELECT region, plu, total_volume
FROM ranked_plu
WHERE rank = 1
ORDER BY region;


--Top-Selling PLU Per Region using CTEs and ROW_NUMBER()

WITH plu_sales AS (
    SELECT EXTRACT(YEAR FROM date) AS year, '4046' AS plu, SUM("4046") AS total_volume
    FROM avocado
    GROUP BY EXTRACT(YEAR FROM date)

    UNION ALL

    SELECT EXTRACT(YEAR FROM date), '4225', SUM("4225")
    FROM avocado
    GROUP BY EXTRACT(YEAR FROM date)

    UNION ALL

    SELECT EXTRACT(YEAR FROM date), '4770', SUM("4770")
    FROM avocado
    GROUP BY EXTRACT(YEAR FROM date)
),
ranked_plu AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY year ORDER BY total_volume DESC) AS rank
    FROM plu_sales
)
SELECT year, plu, total_volume
FROM ranked_plu
WHERE rank = 1
ORDER BY year;

--How do organic and conventional avocados sell in different regions?
SELECT
    region,
    type,
    SUM(total_volume) AS total_volume_sold
FROM avocado
GROUP BY region, type
ORDER BY region, total_volume_sold DESC;
