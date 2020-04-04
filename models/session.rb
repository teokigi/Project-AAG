require_relative('../db/sqlrunner.rb')

class Session

	def initialize
		@id = options['id'] if options['id']
		@gym_class_id = options['id']
		@time_slot = options['time_slot']
		@max_bookings = options['max_bookings']

		if !options['available_bookings']
			@available_bookings = @max_bookings
		else
			@available_bookings = options['available_bookings']
		end

		if !options['status']
			@status = options['status']
		else
			@status = 'active'
		end
	end

	def create()
        sql = "INSERT INTO sessions
        (
            gym_class_id,
            max_bookings,
            time_slot,
			available_bookings
        )
        VALUES
        (
        $1, $2, $3, $4
        )
        RETURNING *"
        values = [  @gym_class_id,
                    @max_bookings,
                    @time_slot,
					@available_bookings]
        query = SqlRunner.run(sql, values).first
        @id = query['id'].to_i
        return query
    end
        #read all
    def self.find_all()
        sql = "SELECT * FROM sessions"
        query = SqlRunner.run(sql,[])
        return nil if query.first == nil
        return query.map { |value| self.new( value ) }
    end

        #read one with matching id
    def find
        sql = "SELECT * FROM sessions WHERE id = $1"
        values = [@id]
        query = SqlRunner.run(sql,values).first()
        return nil if query.first == nil
        return Session.new(query)
    end
        #update
    def update()
        sql = "UPDATE sessions SET (gym_class_id,max_bookings,time_slot,available_bookings) = ($1,$2,$3,$4) WHERE id = $5"
        values = [@gym_class_id,@max_bookings,@time_slot,@available_bookings,@id]
        SqlRunner.run(sql,values)
    end
        #delete all
    def self.delete_all()
        sql = "DELETE FROM sessions"
        SqlRunner.run(sql,[])
    end
        #delete entry with matching id
    def delete()
        sql = "DELETE FROM sessions WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql,values)
    end

end

end
