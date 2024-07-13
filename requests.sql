SELECT User FROM mysql.user;

SHOW GRANTS FOR 'sys_temp'@'172.21.0.1';

SELECT CURRENT_USER();

-- --------------------------------------

SELECT * FROM  INFORMATION_SCHEMA.PARTITIONS
where TABLE_schema = 'sakila'

    
select table_name, column_name from information_schema.key_column_usage
where TABLE_schema = 'sakila' and CONSTRAINT_name = 'PRIMARY'    
    ;
    
   
--    SQL. Часть 1 ------------------------
-- 1)
   
SELECT distinct district from sakila.address a 
WHERE (district like 'K%a') and (district not like '% %');

select distinct district from sakila.address a 
WHERE district REGEXP '^K[a-zA-Z]*a$';

-- 2)
select * from sakila.payment c 
where amount > 10
and payment_date >= '2005-06-15 00:00:00' 
and payment_date < '2005-06-19 00:00:00';


select * from sakila.payment c 
where amount > 10
and payment_date BETWEEN '2005-06-15 00:00:00' and '2005-06-18 23:59:59'

-- 3)
select * from sakila.rental c
order by rental_date desc, rental_id desc
limit 5;

-- 4)

select REGEXP_REPLACE(LOWER(first_name), 'll','pp') first_name, 
REGEXP_REPLACE(LOWER(last_name), 'll','pp') last_name from sakila.customer
where active = 1 
and first_name REGEXP '(Kelly|Willie)' or last_name REGEXP '(Kelly|Willie)'

-- 5)
select SUBSTRING_INDEX(email, '@', 1) nick, SUBSTRING_INDEX(email, '@', -1) host from sakila.customer;

select  REGEXP_SUBSTR(email, '.*(?=@)') nick, REGEXP_SUBSTR(email, '(?<=@).*') host from sakila.customer;

-- 6)
with t as 
	(select
	REGEXP_SUBSTR(email, '.*(?=@)') nick,
	REGEXP_SUBSTR(email, '(?<=@).*') host
	from sakila.customer)
select *,
	CONCAT(LEFT(nick,1),
			REGEXP_SUBSTR(
				LOWER(nick), '(?<=[a-z]).*')) nick_modern_0, 
--
	CONCAT(LEFT(nick,1),
			LOWER(
				RIGHT(nick, LENGTH(nick)-1))) nick_modern_1
from t;











