
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