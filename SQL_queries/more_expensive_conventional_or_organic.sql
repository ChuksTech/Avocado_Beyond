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

--How do organic and conventional avocados sell in different regions?
SELECT
    region,
    type,
    SUM(total_volume) AS total_volume_sold
FROM avocado
GROUP BY region, type
ORDER BY region, total_volume_sold DESC;