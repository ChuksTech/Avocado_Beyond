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