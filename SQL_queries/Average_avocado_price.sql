--What’s the average avocado price across regions?

SELECT region, AVG(AveragePrice) AS avg_price
FROM avocado_sales
GROUP BY region
ORDER BY avg_price DESC;

--What is the average price trend of avocados over time?

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
    ROUND(AVG("averageprice"):: numeric, 2) AS average_price
FROM
    avocado_sales
GROUP BY
    TO_CHAR(date, 'YYYY-MM')
ORDER BY
    TO_CHAR(date, 'YYYY-MM');

