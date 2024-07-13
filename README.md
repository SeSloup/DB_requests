# Домашнее задание к занятию «SQL. Часть 1»

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.

```
SELECT distinct district from sakila.address a 
WHERE (district like 'K%a') and (district not like '% %');
```
```
select distinct district from sakila.address a 
WHERE district REGEXP '^K[a-zA-Z]*a$';
```

### Задание 2

Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года **включительно** и стоимость которых превышает 10.00.

```
select * from sakila.payment c 
where amount > 10
and payment_date >= '2005-06-15 00:00:00' 
and payment_date < '2005-06-19 00:00:00';
```
```
select * from sakila.payment c 
where amount > 10
and payment_date BETWEEN '2005-06-15 00:00:00' and '2005-06-18 23:59:59'
```

### Задание 3

Получите последние пять аренд фильмов.

```
select * from sakila.rental c
order by rental_date desc, rental_id desc
limit 5;
```

### Задание 4

Одним запросом получите активных покупателей, имена которых Kelly или Willie. 

Сформируйте вывод в результат таким образом:
- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
- замените буквы 'll' в именах на 'pp'.

```
select REGEXP_REPLACE(LOWER(first_name), 'll','pp') first_name, 
REGEXP_REPLACE(LOWER(last_name), 'll','pp') last_name from sakila.customer
where active = 1 
and first_name REGEXP '(Kelly|Willie)' or last_name REGEXP '(Kelly|Willie)'
```

## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 5*

Выведите Email каждого покупателя, разделив значение Email на две отдельных колонки: в первой колонке должно быть значение, указанное до @, во второй — значение, указанное после @.

```
select SUBSTRING_INDEX(email, '@', 1) nick, SUBSTRING_INDEX(email, '@', -1) host from sakila.customer;
```

```
select  REGEXP_SUBSTR(email, '.*(?=@)') nick, REGEXP_SUBSTR(email, '(?<=@).*') host from sakila.customer;
```

### Задание 6*

Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, остальные — строчными.

```
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
```
