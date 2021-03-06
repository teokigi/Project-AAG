require_relative('../db/sqlrunner.rb')

class Session

	attr_reader :id
	attr_accessor 	:gym_class_id,
 					:time_slot,
 					:maximum_bookings,
 					:available_bookings

	def initialize(options)
		@id = options['id'] if options['id']
		@gym_class_id = options['gym_class_id'].to_i
		@time_slot = options['time_slot']
		@maximum_bookings = options['maximum_bookings'].to_i

		if !options['available_bookings']
			@available_bookings = @maximum_bookings
		else
			@available_bookings = options['available_bookings'].to_i
		end
	end

	def create()
        sql = "INSERT INTO sessions
        (
            gym_class_id,
            maximum_bookings,
            time_slot,
			available_bookings
        )
        VALUES
        (
        $1, $2, $3, $4
        )
        RETURNING *"
        values = [  @gym_class_id,
                    @maximum_bookings,
                    @time_slot,
					@available_bookings]
        query = SqlRunner.run(sql, values).first
        @id = query['id'].to_i
        return Session.new(query)
    end
        #read all
    def self.find_all()
        sql = "SELECT * FROM sessions"
        query = SqlRunner.run(sql,[])
        return nil if query.first == nil
        return query.map { |value| self.new( value ) }
    end
    def self.find_by_id(id)
        sql = "SELECT * FROM sessions WHERE id = $1"
        values = [id]
        query = SqlRunner.run(sql,values).first()
        return nil if query.first == nil
        return self.new(query)
    end

        #read one with matching id
    def find
        sql = "SELECT * FROM sessions WHERE id = $1"
        values = [@id]
        query = SqlRunner.run(sql,values).first()
        return nil if query == nil
        return Session.new(query)
    end

	def self.find_sessions_with_gym_class_id(id)
		sql = "SELECT * FROM sessions
				WHERE gym_class_id = $1"
		values = [id]
		query = SqlRunner.run(sql,values)
		return nil if query.first == nil
		return query.map { |value| self.new( value ) }
	end
        #update
    def update()
        sql = "	UPDATE sessions
				SET (	gym_class_id,
						maximum_bookings,
						time_slot,
						available_bookings
					)
 				= ($1,$2,$3,$4)
 				WHERE id = $5"
        values = [@gym_class_id,@maximum_bookings,@time_slot,@available_bookings,@id]
        SqlRunner.run(sql,values)
    end
        #delete entry with matching id
    def delete()
		#function requires a string stored in a variable that carries out a SQL command to delete
		# from the sessions table where the unique identifier will be the id from the session class object.
		#use the class method run from class SqlRunner passing through 2 arguments, one containing
		#the sql commands in string form, and the other. the unique identifier id contained the
		# in the class object session that is being passed to this delete method.
        sql = "DELETE FROM sessions WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql,values)
    end
		#delete by id
    def self.delete_by_id(id)
        sql = "DELETE FROM sessions WHERE id = $1"
        values = [id]
        query = SqlRunner.run(sql,values)
    end

end
