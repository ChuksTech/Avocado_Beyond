--Which PLU type is sold the most across all years?

SELECT
  SUM(plu4046) AS total_4046,
  SUM(plu4225) AS total_4225,
  SUM(plu4770) AS total_4770
FROM avocado_sales;