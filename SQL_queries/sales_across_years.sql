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