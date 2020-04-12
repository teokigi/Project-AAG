require_relative('../db/sqlrunner.rb')

class Member

		attr_accessor :status, :first_name, :last_name, :account_type
		attr_reader :id

	def initialize(options)
		#errors occur when passing through hash data, if status has pre-existing data
		#status reverts to default and ignores new data
		if !options['status']
			@status = 'active'
		else
			@status = options['status']
		end

		@first_name = options['first_name']
		@last_name = options['last_name']
		@account_type = options['account_type']
		@id = options['id'].to_i if options['id']
	end

	def create
		sql = "INSERT INTO members
 				(
					status,
					first_name,
					last_name,
					account_type
				)
				VALUES
				(
					$1,$2,$3,$4
				)
				RETURNING *"
		values = [@status,@first_name,@last_name,@account_type]
		returning_data = SqlRunner.run(sql,values)
		returning_data = returning_data.first()
		@id = returning_data['id'].to_i
		return Member.new(returning_data)
	end
        #read all
    def self.find_all()
        sql = "SELECT * FROM members"
        query = SqlRunner.run(sql,[])
        return nil if query.first == nil
        return query.map{ |value| self.new(value)}
    end
        #find by id
    def self.find_by_id(id)
        sql = "SELECT * FROM members WHERE id = $1"
        values = [id]
        query = SqlRunner.run(sql,values).first()
        return nil if query.first == nil
        return self.new(query)
    end
        #delete by id
    def self.delete(member_id)
		session_ids = self.sessions(member_id)
		for s_id in session_ids
			self.return_session_availability(s_id)
		end
		sql = "DELETE FROM members WHERE id = $1 RETURNING *"
        values = [id]
        query = SqlRunner.run(sql,values).first()
    end

	def self.sessions(member_id)
		sql = "SELECT session_id from bookings
				WHERE member_id = $1"
		value = [member_id]
		query = SqlRunner.run(sql,values)
		return query.each{|v| v['session_id']}
	end

	def self.return_session_availability(session_id)
		sql =  "UPDATE sessions
                SET available_bookings
                = available_bookings + 1
                WHERE id = $1"
        values = [session_id]
        SqlRunner.run(sql,values)
	end
	def update
		sql = " UPDATE members SET
 				(
					status,
					first_name,
					last_name,
					account_type
				) =
 				(
					$1,$2,$3,$4
				)
				WHERE id = $5"
		values = [@status,@first_name,@last_name,@account_type,@id]
		SqlRunner.run(sql,values)
	end
	#toggle active and inactive
	def toggle_status
		case @status
			when "active"
				@status = "inactive"
				update()
				return "success - updated"
			when "inactive"
				@status = "active"
				update()
				return "success - updated"
			else
			return "Error - status is currently invalid"
		end
	end
		#return full name
	def fullname
		members_full_name = "#{@first_name} #{@last_name}"
		return members_full_name
	end

end
