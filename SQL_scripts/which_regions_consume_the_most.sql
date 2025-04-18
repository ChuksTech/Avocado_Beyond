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