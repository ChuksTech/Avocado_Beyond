
--What is the correlation between price and volume?
/*
CORR(col1, col2): This PostgreSQL function returns 
the Pearson correlation coefficient between two columns.

+1: Strong positive correlation

-1: Strong negative correlation

0: No correlation

You might want to analyze specific regions or types (organic vs. conventional) to see if the relationship is stronger in certain segments.

Or visualize it with a scatter plot — would you like 
help with that in Python?
*/
/*
The number falls between -1 and 0, which means 
there's a negative correlation.

Because it's close to 0, 
it’s a weak negative correlation.
As avocado prices increase, the total volume sold tends to decrease slightly, 
but the relationship is not strong.
*/
SELECT
    CORR("averageprice", "totalvolume") AS price_volume_correlation
FROM
    avocado_sales;