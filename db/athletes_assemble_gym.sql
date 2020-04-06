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
	gym_class_id INT REFERENCES gym_classes(id) ON DELETE CASCADE,
	time_slot VARCHAR(255),
	maximum_bookings INT,
	available_bookings INT
);

CREATE TABLE bookings(
	id SERIAL PRIMARY KEY,
	session_id INT REFERENCES sessions(id) ON DELETE CASCADE,
	member_id INT REFERENCES members(id) ON DELETE CASCADE
);


INSERT INTO members (status,first_name,last_name,account_type) VALUES
	('active','Allan','Atkinson','standard'),
	('active','Brian','Bedford','standard'),
	('active','Charlie','Carlson','standard'),
	('active','David','Davidson','standard'),
	('active','Edward','Enders','standard'),
	('active','Fred','Flanders','standard'),
	('active','Greg','Granger','standard'),
	('active','Holly','Hanson','premium'),
	('active','Irene','Idlyeshire','premium'),
	('inactive','Jake','Jackson','standard');

INSERT INTO gym_classes (status,name) VALUES
	('active','spin'),
	('active','treadmill'),
	('active','yoga'),
	('active','core'),
	('active','life'),
	('active','spartan'),
	('active','crunch'),
	('active','bootcamp'),
	('active','peloton'),
	('inactive','couch potato');

INSERT INTO sessions (gym_class_id,time_slot,maximum_bookings,available_bookings) VALUES
	(1,'0900','3','2'),
	(1,'1200','3','0'),
	(1,'1600','4','3'),
	(2,'1000','5','4'),
	(2,'1200','2','2'),
	(2,'1600','3','2'),
	(3,'0900','4','3'),
	(3,'1200','4','4'),
	(3,'1600','5','4'),
	(4,'0900','3','2');

INSERT INTO bookings (member_id,session_id) VALUES
	(1,1),
	(1,2),
	(1,3),
	(2,2),
	(2,4),
	(2,6),
	(3,2),
	(3,7),
	(3,10),
	(4,9);
