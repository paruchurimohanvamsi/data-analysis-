Select *
from layoffs;

select *
from layoffs
where percentage_laid_off=1
order by location;

Select min(date), max(date)
from layoffs;

select industry, max(total_laid_off)
from layoffs
where stage='Acquired'
group by industry;

select country,avg(total_laid_off) AS AVGTOTAL
from layoffs
GROUP BY country;

SELECT date , sum(total_laid_off),industry,company
FROM layoffs
where date is not null
group by date,industry,company
order by 1 desc ;

WITH layoffperyear(DATE, layoff, INDUSTRY, COMPANY) AS
(
    SELECT date, sum(total_laid_off), industry, company
    FROM layoffs
    WHERE date IS NOT NULL
    GROUP BY date, industry, company
),
layyoffperyear_ranking AS
(
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY DATE ORDER BY layoff DESC) AS ranking
    FROM layoffperyear
    WHERE layoff IS NOT NULL
)
SELECT *
FROM layyoffperyear_ranking
where ranking <= 5
order by DATE desc;
