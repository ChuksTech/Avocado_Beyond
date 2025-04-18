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
