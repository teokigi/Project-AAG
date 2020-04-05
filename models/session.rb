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
			available_bookings,
			status
        )
        VALUES
        (
        $1, $2, $3, $4, $5
        )
        RETURNING *"
        values = [  @gym_class_id,
                    @maximum_bookings,
                    @time_slot,
					@available_bookings,@status]
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
						available_bookings,
						status)
 				= ($1,$2,$3,$4,$5)
 				WHERE id = $6"
        values = [@gym_class_id,@maximum_bookings,@time_slot,@available_bookings,@status,@id]
        SqlRunner.run(sql,values)
    end

        #delete entry with matching id
    def delete()
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

	def toggle_status
		if @status == "active"
			@status = "inactive"
			update()
		elsif @status == "inactive"
			@status = "active"
			update()
		end
	end

end
