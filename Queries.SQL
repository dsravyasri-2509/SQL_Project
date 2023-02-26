--What are the top-rated places of Sushra hotels based on customer ratings?
select r.rating,pl.place_id,pl.branch_name,pl.address,co.country_name 
from reviews r join bookings b on r.booking_id=b.booking_id join places pl on pl.place_id=b.place_id 
join countries co on co.country_id=pl.country_id where r.rating>=8 order by r.rating;

-- Create a query to know the users who have bookings on 21-02-13 and the total amount that Sushra got for those bookings?

select user_id,(number_of_days*price_per_day) as Total_booking_amount,start_date,end_date from bookings where start_date='21-02-13';

--Display all the booking_id's whose stayed in Philippines
Select booking_id,Pl.country_id,Co.country_name 
from bookings B inner join places pl on B.place_id=pl.place_id 
inner join countries Co on pl.country_id=Co.country_id where Co.country_name='Philippines'
;
--Create a view and add a new column to the result called priority to group results into the following priority 
--groups top-rated, medium-rated, and low-rated the range for each group is provided in the table below high>= 8 *, medium - in (5,7,6)  and low<5. 
Create or replace view  Rating_system as
select B.booking_id,B.user_id,R.rating,B.place_id,co.country_name,
case when R.rating>=8 Then 'TOP-RATED'
	 when R.rating IN (7,5,6) then 'MEDIUM-RATED'
	 when R.rating<5 THEN 'LOW-RATED'
	 END as PRIORITY
from reviews R inner join bookings B on R.booking_id=B.booking_id 
inner join places Pl on Pl.place_id=B.place_id 
inner join countries Co on Co.country_id=Pl.country_id
order by R.rating ;
---------
select * from Rating_system;

--Who are the customers that they had a stay more than twice in sushra and can we get their details just in case wants to reward them?
select b.user_id, count(b.user_id) as no_of_times_visited from bookings B full join users U on B.user_id=U.user_id 
group by b.user_id having count(b.user_id)>1
order by b.user_id;

----What is the average income for bookings at  from February 13,2022 to 2023-01-14? 
select avg(number_of_days*price_per_day) as Avg_income 
from bookings where start_date ='2022-02-13' or end_date='2023-01-14';

--Display all the user details whose stay at Russia.
select B.user_id,B.booking_id,U.first_name,co.country_name,B.number_of_days,B.start_date,B.end_date from users U left join bookings B on U.user_id=B.user_id 
left join places Pl on B.place_id=Pl.place_id left join countries co on co.country_id=Pl.country_id
where co.country_name='Russia';
---create a common table expression(CTE) with all the bookings and join this new table with places showing for branches where bookings are created.
with bookings_CTE as (
select booking_id,start_date,number_of_days,price_per_day,place_id
from bookings
group by place_id,start_date,number_of_days,booking_id
)
select bookings_CTE.*,Pl.branch_name,Pl.address,Pl.country_id,Pl.postal_code
from bookings_CTE left Join places Pl on bookings_CTE.place_id=Pl.place_id;

---create a query that should display the booking details having more than two days stay at '243 Moulton avenue'
select bookings.booking_id,bookings.number_of_days,places.address,bookings.user_id 
from bookings 
inner join places on bookings.place_id=places.place_id 
where number_of_days>=2 and address='243 Moulton Avenue';
--create a new column that provides the information of the welcome gift: if the booking is from a female, then provide a plum gift hamper else provide a deodorant.

select bookings.booking_id,users.user_id,users.first_name,users.last_name,users.phone_number, users.gender ,
case when gender='female' then 'PlUM GIFT HAMPER'
	ELSE 'DEODORANT'
end as Welcome_Gifts
from  bookings inner join users on  bookings.user_id=users.user_id







