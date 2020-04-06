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
	Available_bookings INT
);

CREATE TABLE bookings(
	id SERIAL PRIMARY KEY,
	session_id INT REFERENCES sessions(id) ON DELETE CASCADE,
	member_id INT REFERENCES members(id) ON DELETE CASCADE
);

INSERT INTO members (id,status,first_name,last_name,account_type) VALUES
	(1,'active','Allan','Atkinson','standard'),
	(2,'active','Brian','Bedford','standard'),
	(3,'active','Charlie','Carlson','standard'),
	(4,'active','David','Davidson','standard'),
	(5,'active','Edward','Enders','standard'),
	(6,'active','Fred','Flanders','standard'),
	(7,'active','Greg','Granger','standard'),
	(8,'active','Holly','Hanson','premium'),
	(9,'active','Irene','Idlyeshire','premium'),
	(10,'inactive','Jake','Jackson','standard');

INSERT INTO gym_classes (id,status,name) VALUES
	(1,'active','spin'),
	(2,'active','treadmill'),
	(3,'active','yoga'),
	(4,'active','core'),
	(5,'active','life'),
	(6,'active','spartan'),
	(7,'active','crunch'),
	(8,'active','bootcamp'),
	(9,'active','peloton'),
	(10,'inactive','couch potato');

INSERT INTO sessions (id,gym_class_id,time_slot,maximum_bookings,available_bookings) VALUES
	(1,1,'0900','3','2'),
	(2,1,'1200','3','0'),
	(3,1,'1600','4','4'),
	(4,2,'1000','5','4'),
	(5,2,'1200','2','2'),
	(6,2,'1600','3','2'),
	(7,3,'0900','4','3'),
	(8,3,'1200','4','4'),
	(9,3,'1600','5','4'),
	(10,4,'0900','3','2');

INSERT INTO bookings (id,member_id,session_id) VALUES
	(1,1,1),
	(2,1,2),
	(3,1,3),
	(4,2,2),
	(5,2,4),
	(6,2,6),
	(7,3,2),
	(8,3,7),
	(9,3,10),
	(10,4,9);
