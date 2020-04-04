require_relative('../db/sqlrunner.rb')

class Session

	attr_reader :id
	attr_accessor 	:gym_class_id,
 					:time_slot,
 					:maximum_bookings,
 					:available_bookings,
					:status

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

		if !options['status']
			@status = 'active'
		else
			@status = options['status']
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
        sql = "UPDATE sessions SET (gym_class_id,maximum_bookings,time_slot,available_bookings) = ($1,$2,$3,$4) WHERE id = $5"
        values = [@gym_class_id,@maximum_bookings,@time_slot,@available_bookings,@id]
        SqlRunner.run(sql,values)
    end

        #delete entry with matching id
    def delete()
        sql = "DELETE FROM sessions WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql,values)
    end

		def toggle_status
			if @status == "active"
				@status = "inactive"
				update()
			else
				@status = "active"
				update()
			end
		end

end
