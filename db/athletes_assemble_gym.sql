DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS gym_classes;
DROP TABLE IF EXISTS members;

CREATE TABLE members(
	id SERIAL PRIMARY KEY,
	status VARCHAR(255),
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	account_Type VARCHAR(255)
);
CREATE TABLE gym_classes(
	id SERIAL PRIMARY KEY,
	status VARCHAR(255),
	name VARCHAR(255)
);

CREATE TABLE sessions(
	id SERIAL PRIMARY KEY,
	status VARCHAR(255),
	gym_class_id INT REFERENCES gym_classes(id),
	time_slot VARCHAR(255),
	maximum_bookings INT,
	Available_bookings INT
);

CREATE TABLE bookings(
	id SERIAL PRIMARY KEY,
	status VARCHAR(255),
	session_id INT REFERENCES sessions(id),
	member_id INT REFERENCES members(id)
);
