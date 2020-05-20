# Solo project Athletes Assemble Gym

Gym App for managing members, gym classes and bookings.

## Pre-Requisites procedure to run app

Language: Ruby
database: PostgreSQL
Ruby Gem's:
- sinatra
- sinatra-contrib-all
- PG
### After, run these terminal commands.

This makes sure there are no other iterations of the database on your system, note the sql contains seed data it populates the tables on run.
```` 
dropdb athletes_assemble_gym
createdb athletes_assemble_gym
psql -d athletes_assemble_gym -f db/athletes_assemble_gym.sql
ruby app.rb
````
after running
 ````ruby app.rb````
open a web browser and enter the url

http://localhost:4567/

This will take you to the website.

### Automated test files.

inside the specs folder contains 4 files for testing the app. the directory are as follows

* specs/member_specs.rb
* specs/gym_class_specs.rb
* specs/session_specs.rb
* specs/booking_specs.rb

each file, tests the different model classes. To be more specific, the class methods are tested under scenarios and relative conditions it is intended for.

Note this build, is focused primarily on offline functionality and there are no login requirements. Login condition is an assumed scenario for this project.

### Author:
Tony Tang, part of the G18 Code Clan Software Development Course.
