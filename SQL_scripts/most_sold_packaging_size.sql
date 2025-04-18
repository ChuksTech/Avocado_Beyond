
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