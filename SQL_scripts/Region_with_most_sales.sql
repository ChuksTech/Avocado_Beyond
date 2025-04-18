--Which region sells the most avocados overall?

SELECT region, SUM(TotalVolume) AS total_sold
FROM avocado_sales
GROUP BY region
ORDER BY total_sold DESC;