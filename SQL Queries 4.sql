#Is ‘Academy Dinosaur’ available for rent from Store 1?
select film.film_id, film.title, store.store_id, inventory.inventory_id
from inventory 
inner join store on store.store_id = inventory.store_id
inner join film on film.film_id = inventory.inventory_id
where film.title = 'Academy Dinosaur' and store.store_id = 1;

#Insert a record to represent Mary Smith renting ‘Academy Dinosaur’ from Mike Hillyer at Store 1 today.
insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (NOW(), 1, 1, 1);

#When is ‘Academy Dinosaur’ due?
select rental_date as datum_izdavanja, rental_date + interval
(select rental_duration from film where film_id = 1) day as datum_vracanja
from rental
where rental_id = (select rental_id from rental order by rental_id desc limit 1);

#What is that average running time of all the films in the sakila DB?
select avg(length) from film;

#What is the average running time of films by category?
select category.name as naziv_kategorije, avg(length) as prosecna_duzina
from film 
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
group by category.name
order by prosecna_duzina;

#Which film categories are long (longer then average length)?
select category.name as naziv_kategorije, avg(length) as prosecna_duzina
from film 
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
group by category.name
having avg(length) > (select avg(length) from film)
order by avg(length);




