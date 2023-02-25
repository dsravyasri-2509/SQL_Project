--USERS
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	first_name CHARACTER VARYING (25),
	last_name CHARACTER VARYING (25),
	email CHARACTER VARYING (25),
	Gender CHARACTER VARYING (25),
	phone_number INTEGER
	
);
--COUNTRIES

CREATE TABLE countries (
	country_id SERIAL PRIMARY KEY,
	country_code INTEGER,
	country_name CHARACTER VARYING (40)
	);
--CITIES
CREATE TABLE cities(
	city_id SERIAL PRIMARY KEY,
	city_name CHARACTER VARYING (40),
	country_id INTEGER NOT NULL,
	FOREIGN KEY (country_id) REFERENCES countries (country_id) ON UPDATE CASCADE ON DELETE CASCADE
);
--PLACES

CREATE TABLE places (
	place_id SERIAL PRIMARY KEY,
	address CHARACTER VARYING (40),
	postal_code INTEGER,
	city_id INTEGER NOT NULL,
	FOREIGN KEY (city_id) REFERENCES cities (city_id),
	country_id INTEGER NOT NULL,
	FOREIGN KEY (country_id) REFERENCES countries (country_id) ON UPDATE CASCADE ON DELETE CASCADE
);
--BOOKINGS
CREATE TABLE bookings (
	booking_id SERIAL PRIMARY KEY,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	number_of_days INTEGER NOT NULL,
	price_per_day NUMERIC (8, 2) NOT NULL,
	place_id INTEGER NOT NULL,
	FOREIGN KEY (place_id) REFERENCES places (place_id),
	user_id INTEGER NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users (user_id) ON UPDATE CASCADE ON DELETE CASCADE		
);
--REVIEWS

CREATE TABLE reviews (
	review_id SERIAL PRIMARY KEY,
	rating INTEGER,
	booking_id INTEGER NOT NULL,
	FOREIGN KEY (booking_id) REFERENCES bookings (booking_id) ON UPDATE CASCADE ON DELETE CASCADE
	);


