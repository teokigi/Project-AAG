require_relative('../db/sqlrunner.rb')

class Member

		attr_accessor :status, :first_name, :last_name, :account_type
		attr_reader :id

	def initialize(options)
		@status = 'active'
		@first_name = options['first_name']
		@last_name = options['last_name']
		@account_type = options['account_type']
		@id = options['id'].to_i if options['id']
	end

	def register
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
		return returning_data
	end


end
