drop table if exists zepto;

create table Zepto(
sku_id Serial Primary Key,
category Varchar(120),
name Varchar(150) not null,
mrp numeric(8,2),
discountpercent numeric (5,2),
availablequantity integer,
discountsellingprice numeric (8,2),
weightingm integer,
outofstock boolean,
quatity integer
);

--data exploration
--count of row

 select count(*)from zepto;

 --sample data

 select * from zepto
 limit 10 ;

 --null value
 select * from zepto
 where name is null
 or
 category is null
 or
 mrp is null
 or 
 discountpercent is null
 or
 discountsellingprice is null
 or
 weightingm is null
 or
availablequantity is null
 or
 outofstock is null
 or
 quatity is null;

--different product category
select distinct category
from zepto
order by category;

--product in stock vs out of stock
select outofstock, count(sku_id)
from zepto
group by outofstock

--product name present multiple times
select name,count(sku_id) as "number of SKUs"
from zepto
group by name
having count(sku_id)>1
order by count(sku_id) desc ;

--data cleaning

--product price = 0
select * from zepto
where mrp = 0 or discountsellingprice = 0;

delete from zepto
where mrp = 0 ;

--conver paise to rupee
update zepto
set mrp = mrp/100.0,
discountsellingprice = discountsellingprice/100.0;

select mrp , discountsellingprice
from zepto;

--busines question 
--1
select distinct name , mrp, discountpercent
from zepto
order by discountpercent desc
limit 10 ;

--2
select distinct name,mrp
from zepto
where outofstock = True and mrp>300
order by mrp desc;

--3
select category,
sum(discountsellingprice * availablequantity) as total_revenue
from zepto
group by category
order by total_revenue ;

--4
select  distinct name,mrp,discountpercent
from zepto
where mrp>500 and discountpercent<10
order by mrp desc , discountpercent desc ;

--5
select category,
round (avg(discountpercent),2)as avg_discount
from zepto
group by category
order by avg_discount desc 
limit 5 ;

--6
select distinct name, weightingm , discountsellingprice,
round(discountsellingprice/weightingm,2)as price_per_gram
from zepto
where weightingm >=100
order by price_per_gram;

--7
select distinct name , weightingm, 
case when weightingm <1000 then 'low'
	when weightingm <5000 then 'medium'
	else 'bulk'
	end as weight_category
from zepto;

--8
select category,
sum(weightingm * availablequantity) as total_weight
from zepto
group by category
order by total_weight;
