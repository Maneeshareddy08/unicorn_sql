-- Identify the top three industries with the highest number of new unicorns created over the combined period of 2019, 2020, and 2021.
select i.industry, count(*) as industry_count
from industries as i 
left join dates as d
on i.company_id = d.company_id
where EXTRACT(year from date_joined ) in ('2019','2020','2021')
group by i.industry
order by industry_count desc
limit 3 ;

--Analyze average valuation of unicorn companies by industry to understand where the largest companies are being created.
select count(valuation) as total,avg(valuation) as average, i.industry
from funding as f
left join industries as i
on f.company_id = i.company_id
group by i.industry
order by  total desc,average desc;

--What is the median time between a company's founding date and when it became a unicorn across different industries?
 with company_age as(
    select i.industry, (extract(year from d.date_joined)-d.year_founded) as unicorn_age 
    from dates as d
    left join industries as i
    on d.company_id = i.company_id
 )
select industry, percentile_cont(0.5) within group(order by unicorn_age) as median_years
from company_age
group by industry
order by median_years desc;

--Which industries have the highest percentage of unicorns achieving valuations over $10 billion?
select i.industry, count(case when f.valuation> 10000000000 then 1 end)*100.0/count(f.company_id) as percentage_unicorn
from funding as f
left join industries as i
on f.company_id = i.company_id
group by i.industry
order by percentage_unicorn desc
limit 5;


-- Which investors are backing the most unicorns across multiple industries, and how diversified are their investment portfolios?

select select_investors as investors , count(distinct i.industry) as industry
from funding as f
join industries as i
on f.company_id = i.company_id
group by investors
order by industry desc
limit 20;




