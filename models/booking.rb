require_relative("../db/sqlrunner")

class Booking
    attr_accessor :member_id, :session_id
    attr_reader :id
        #initialize
    def initialize( options )
        @id = options['id'].to_i if options['id']
        @member_id = options['member_id'].to_i
        @session_id = options['session_id'].to_i
    end
        #create
    def create()
        if availability_screening()
            minus_1_availability()
            sql = "INSERT INTO bookings
            (
                member_id,
                session_id
            )
            VALUES
            (
            $1, $2
            )
            RETURNING *"
            values =    [
                            @member_id,
                            @session_id
                        ]
            query = SqlRunner.run(sql, values).first
            @id = query['id'].to_i
            return Booking.new(query)
        else
            return "Session is full"
        end

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
        plus_1_availability()
    end

		#delete by id
    def self.delete_by_id(id)
        sql = "DELETE FROM bookings WHERE id = $1"
        values = [id]
        query = SqlRunner.run(sql,values)
    end
        #find by id
    def self.find_by_id(id)
        sql = "SELECT * FROM bookings WHERE id = $1"
        values = [id]
        query = SqlRunner.run(sql,values).first()
        return nil if query.first == nil
        return self.new(query)
    end

    def availability_screening()
        sql = " SELECT available_bookings
                FROM sessions
                WHERE id = $1"
        values = [@session_id]
        query = SqlRunner.run(sql,values).first()
        if query['available_bookings'] == "0"
            return false
        else
            return true
        end
        return query
    end

    def minus_1_availability()
        sql =  "UPDATE sessions
                SET available_bookings
                = available_bookings - 1
                WHERE id = $1"
        values = [@session_id]
        SqlRunner.run(sql,values)
    end

    def plus_1_availability()
        sql =  "UPDATE sessions
                SET available_bookings
                = available_bookings + 1
                WHERE id = $1"
        values = [@session_id]
        SqlRunner.run(sql,values)
    end
end
