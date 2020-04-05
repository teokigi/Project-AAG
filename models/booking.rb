require_relative("../db/sqlrunner")

#template find and replace
# tablename = bookings
# classname capitalize = Booking
# first variable = status
# second varible = session_id
# third variable = member_id
# code .to_i for relevant variables in initialize that are integers
#line 32,79 references number of variables of your class. edit as appropriate
#fill attr reader and attr accessor
class Booking
    attr_accessor :member_id, :session_id, :status
    attr_reader :id
        #initialize
    def initialize( options )
        @id = options['id'].to_i if options['id']
        @member_id = options['member_id'].to_i
        @session_id = options['session_id'].to_i

		if options['status']
        @status = options['status']
		else
		@status = 'active'
		end
    end
        #create
    def create()
        sql = "INSERT INTO bookings
        (
            member_id,
            session_id,
            status
        )
        VALUES
        (
        $1, $2, $3
        )
        RETURNING *"
        values = [  @member_id,
                    @session_id,
                    @status]
        query = SqlRunner.run(sql, values).first
        @id = query['id'].to_i
        return Booking.new(query)
    end
        #read all
    def self.find_all()
        sql = "SELECT * FROM bookings"
        query = SqlRunner.run(sql,[])
        return nil if query.first == nil
        return query.map { |value| self.new( value ) }
    end

	def self.find_bookings_with_session_id(id)
		sql = "SELECT * FROM bookings
				WHERE session_id = $1"
		values = [id]
		query = SqlRunner.run(sql,values)
		return nil if query.first == nil
		return query.map { |value| self.new( value ) }
	end
        #read one with matching id
    def find
        sql = "SELECT * FROM bookings WHERE id = $1"
        values = [@id]
        query = SqlRunner.run(sql,values).first()
        return nil if query == nil
        return Booking.new(query)
    end
        #update
    def update()
        sql = "UPDATE bookings SET (member_id,session_id,status) = ($1,$2,$3) WHERE id = $4"
        values = [@member_id,@session_id,@status,@id]
        SqlRunner.run(sql,values)
    end
        #delete all
    def self.delete_all()
        sql = "DELETE FROM bookings"
        SqlRunner.run(sql,[])
    end
        #delete entry with matching id
    def delete()
        sql = "DELETE FROM bookings WHERE id = $1"
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
